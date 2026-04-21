#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"

#define BLOCK_SIZE 512

int free_swap_slots[NSWAPSLOTS];
struct spinlock swaplock;

static int reserve_swap_slot(void) {
    acquire(&swaplock);
    for (int slot_idx = 0; slot_idx < NSWAPSLOTS; slot_idx++) {
      if (free_swap_slots[slot_idx]) {
        uint blockno = SWAP_SLOT_START + (PGSIZE / BLOCK_SIZE) * slot_idx;
        free_swap_slots[slot_idx] = 0;
        release(&swaplock);
        return blockno;
      }
    }
    release(&swaplock);
    return -1;
}

static void flush_local_tlb(void) {
    struct proc *p = myproc();
    // Reload the cr3 register to flush the TLB values
    if (p && p->pgdir) {
      switchuvm(p);
    } else {
      switchkvm();
    }
}

void swapinit() {
    initlock(&swaplock, "swap");
    for (int i = 0; i < NSWAPSLOTS; i++) {
        free_swap_slots[i] = 1; // 1 means free, 0 means used
    }
}

void mark_swap_slot_free(uint blockno) {
    int slot_index = (blockno - SWAP_SLOT_START) / 8;
    acquire(&swaplock);
    free_swap_slots[slot_index] = 1;
    release(&swaplock);
}

void mark_swap_slot_used(uint blockno) {
    int slot_index = (blockno - SWAP_SLOT_START) / 8;
    acquire(&swaplock);
    free_swap_slots[slot_index] = 0;
    release(&swaplock);
}


pte_t* get_victim_page(struct proc *p) {
    pde_t *pde = p -> pgdir;
    for (int retries = 0; retries < 10; retries++) {
      /* -------------------------------------------------------------- */
      /* TODO: Implement this function */
      /* Your code here */
      /* -------------------------------------------------------------- */
        int has_accessed_present_user_page = 0;
        for(int i = 0; i < NPDENTRIES; i++) {
          if(pde[i] & PTE_P) {
            pte_t* pte = (pte_t *) P2V(PTE_ADDR(pde[i]));
            for(int j = 0; j < NPTENTRIES; j++) {
              // A page that is present, unaccessed and a user page
              if((pte[j] & PTE_P) && (pte[j] & PTE_U)) {
                if(pte[j] & PTE_A) {
                  has_accessed_present_user_page++;
                } else {
                  return &pte[j];
                }
              } 
            }
          }
        }

      if(has_accessed_present_user_page > 0) {
        clear_proc_access_bits(p);
      }
    }
    panic("No victim page found");
}

void swap_out_page(pte_t *page) {
    /* -------------------------------------------------------------- */
    /* TODO: Implement this function */
    /* Your code here */
    /* -------------------------------------------------------------- */
    uint block_no = reserve_swap_slot();
    if(block_no != (uint)-1) {
      uint pa_page = PTE_ADDR(*page);
      uint page_flags = PTE_FLAGS(*page);
      // Step 1 -> Makring Swap slot used and Actually moving it from DRAM to FS Blocks
      move_page_memory_to_disk(ROOTDEV, P2V(pa_page), block_no);
      // Step 2 -> Mark the page not present in the PTE, mark as swapped
      page_flags &= ~PTE_P; page_flags |= PTE_SO;
      // Step 3 -> Remember the swap block no in Page Base Address
      *(page) = (block_no << PTXSHIFT)  | (page_flags & 0XFFF);
      flush_local_tlb();
      // Step 4 -> Adding this page back to free list
      kfree(P2V(pa_page));

      return;
    }
    panic("No free swap block found !");
}

void swap_out_victim_page(void)
{
    struct proc *victim_proc = get_victim_proc();
    victim_proc -> rss -= PGSIZE;

    pte_t *victim_page = get_victim_page(victim_proc);

    swap_out_page(victim_page);
}

void swap_in_page(void) {
    uint cr2 = rcr2(); // Returns the VA of the page whose access caused a fault
    struct proc *p = myproc();
    p->rss += PGSIZE;

    /* -------------------------------------------------------------- */
    /* TODO: Implement this function */
    /* Your code here */
    /* -------------------------------------------------------------- */
    pte_t *page = walkpgdir(p->pgdir, (char *)PGROUNDDOWN(cr2), 0);

    if(page == 0 || ((*page & PTE_P) != 0) || ((*page & PTE_SO) == 0)) {
      p->rss -= PGSIZE;
      p->killed = 1;
      return;
    }

    uint block_no = *page >> PTXSHIFT;
    uint old_flags = PTE_FLAGS(*page);
    char *mem = kalloc();

    move_page_disk_to_memory(ROOTDEV, mem, block_no);
    mark_swap_slot_free(block_no);

    old_flags |= PTE_P;
    old_flags &= ~PTE_SO;
    old_flags &= ~PTE_A;
    *page = V2P(mem) | (old_flags & 0xFFF);
    flush_local_tlb();
}
