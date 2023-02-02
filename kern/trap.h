/* See COPYRIGHT for copyright information. */

#ifndef JOS_KERN_TRAP_H
#define JOS_KERN_TRAP_H
#ifndef JOS_KERNEL
# error "This is a JOS kernel header; user programs should not #include it"
#endif

#include <inc/trap.h>
#include <inc/mmu.h>

/* The kernel's interrupt descriptor table */
extern struct Gatedesc idt[];
extern struct Pseudodesc idt_pd;

void trap_init(void);
void trap_init_percpu(void);
void print_regs(struct PushRegs *regs);
void print_trapframe(struct Trapframe *tf);
void page_fault_handler(struct Trapframe *tf);
void breakpoint_handler(struct Trapframe *tf);
void backtrace(struct Trapframe *);

#endif /* JOS_KERN_TRAP_H */
extern void DIVIDE_H();
extern void DEBUG_H();
extern void NMI_H();
extern void BRKPT_H();
extern void OFLOW_H();
extern void BOUND_H();
extern void ILLOP_H();
extern void DEVICE_H();
extern void DBLFLT_H();
extern void TSS_H();
extern void SEGNP_H();
extern void STACK_H();
extern void GPFLT_H();
extern void PGFLT_H();
extern void FPERR_H();
extern void ALIGN_H();
extern void MCHK_H();
extern void SIMDERR_H();
extern void SYSCALL_H();
extern void DEFAULT_H();