/* See COPYRIGHT for copyright information. */

#include <inc/mmu.h>
#include <inc/memlayout.h>
#include <inc/trap.h>



###################################################################
# exceptions/interrupts
###################################################################

/* TRAPHANDLER defines a globally-visible function for handling a trap.
 * It pushes a trap number onto the stack, then jumps to _alltraps.
 * Use TRAPHANDLER for traps where the CPU automatically pushes an error code.
 *
 * You shouldn't call a TRAPHANDLER function from C, but you may
 * need to _declare_ one in C (for instance, to get a function pointer
 * during IDT setup).  You can declare the function with
 *   void NAME();
 * where NAME is the argument passed to TRAPHANDLER.
 */
#define TRAPHANDLER(name, num)						\
	.globl name;		/* define global symbol for 'name' */	\
	.type name, @function;	/* symbol type is function */		\
	.align 2;		/* align function definition */		\
	name:			/* function starts here */		\
	pushl $(num);							\
	jmp _alltraps

/* Use TRAPHANDLER_NOEC for traps where the CPU doesn't push an error code.
 * It pushes a 0 in place of the error code, so the trap frame has the same
 * format in either case.
 */
#define TRAPHANDLER_NOEC(name, num)					\
	.globl name;							\
	.type name, @function;						\
	.align 2;							\
	name:								\
	pushl $0;							\
	pushl $(num);							\
	jmp _alltraps

.text

/*
 * Lab 3: Your code here for generating entry points for the different traps.
 */

    TRAPHANDLER_NOEC(DIVIDE_H, T_DIVIDE)
    TRAPHANDLER_NOEC(DEBUG_H, T_DEBUG)
    TRAPHANDLER_NOEC(NMI_H, T_NMI)
    TRAPHANDLER_NOEC(BRKPT_H, T_BRKPT)
    TRAPHANDLER_NOEC(OFLOW_H, T_OFLOW)
    TRAPHANDLER_NOEC(BOUND_H, T_BOUND)
    TRAPHANDLER_NOEC(ILLOP_H, T_ILLOP)
    TRAPHANDLER_NOEC(DEVICE_H, T_DEVICE)
    TRAPHANDLER(DBLFLT_H, T_DBLFLT)
    TRAPHANDLER(TSS_H, T_TSS)
    TRAPHANDLER(SEGNP_H, T_SEGNP)
    TRAPHANDLER(STACK_H, T_STACK)
    TRAPHANDLER(GPFLT_H, T_GPFLT)
    TRAPHANDLER(PGFLT_H, T_PGFLT)
    TRAPHANDLER_NOEC(FPERR_H, T_FPERR)
    TRAPHANDLER_NOEC(ALIGN_H, T_ALIGN)
    TRAPHANDLER_NOEC(MCHK_H, T_MCHK)
    TRAPHANDLER_NOEC(SIMDERR_H, T_SIMDERR)
    TRAPHANDLER_NOEC(SYSCALL_H, T_SYSCALL)
    TRAPHANDLER_NOEC(DEFAULT_H, T_DEFAULT)

/*
 * Lab 3: Your code here for _alltraps
 */

_alltraps:
        pushw $0
        pushw %ds
        pushw $0
        pushw %es
        pushal
        push %esp
        movw $GD_KD, %ax
        movw %ax, %ds
        movw %ax, %es
        call trap
