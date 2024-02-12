/** load pointer to data from memory*/
.macro ptrload reg, label
    adrp \reg, \label@PAGE
    add \reg, \reg, \label@PAGEOFF
.endm

/** load data from memory*/
.macro valload reg, label
    adrp x15, \label@PAGE
    add x15, x15, \label@PAGEOFF
    ldur \reg, [x15]
.endm

/** function prolog*/
.macro FuncProlog
        // prolog
        .cfi_startproc
        // save framepointer and link reg
        stp fp, lr, [sp, -16]!
        // save callee-saved regs
        // calle-saved regs can be used as "global" variables
        stp x19, x20, [sp, -16]!
        stp x21, x22, [sp, -16]!
        stp x23, x24, [sp, -16]!
        stp x25, x26, [sp, -16]!
        stp x27, x28, [sp, -16]!
        // commence frameshift
        mov fp, sp
        // debug info
        .cfi_def_cfa w29, 96
        .cfi_offset w29, -8
        .cfi_offset w30, -16
        .cfi_offset w19, -24
        .cfi_offset w20, -32
        .cfi_offset w21, -40
        .cfi_offset w22, -48
        .cfi_offset w23, -56
        .cfi_offset w24, -64
        .cfi_offset w25, -72
        .cfi_offset w26, -80
        .cfi_offset w27, -88
        .cfi_offset w28, -96
.endm

/** function epilog*/
.macro FuncEpilog
        // epilog
        // restore callee-saved regs
        ldp x19, x20, [fp, 64]
        ldp x21, x22, [fp, 48]
        ldp x23, x24, [fp, 32]
        ldp x25, x26, [fp, 16]
        ldp x27, x28, [fp]
        // restore fp last since we're using still unwind frame before
        ldp fp, lr, [fp, 80]
        ret
        .cfi_endproc
.endm

/** minimal function prolog*/
.macro MinFuncProlog
        // prolog
        .cfi_startproc
        // save framepointer and link reg
        stp fp, lr, [sp, -16]!
        // commence frameshift
        mov fp, sp
        // debug info
        .cfi_def_cfa w29, 16
        .cfi_offset w29, -8
        .cfi_offset w30, -16
.endm

/** minimal function epilog*/
.macro MinFuncEpilog
        // epilog
        // restore fp last since we're using still unwind frame before
        ldp fp, lr, [fp]
        ret
        .cfi_endproc
.endm
