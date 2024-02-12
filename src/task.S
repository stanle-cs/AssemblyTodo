.include "raylib.h"
.include "define.h"
.include "data.h"

.text
    // empty for now as we don't need logic update
   // .globl LogicUpdate
   // .p2align 2
   // LogicUpdate:
   //     MinFuncProlog
   //     MinFuncEpilog

    .p2align 2
    ActivateInput:
        MinFuncProlog
        mov isTextInputActive, 1
        MinFuncEpilog


    .globl AddTask
    .p2align 2
    AddTask:
        MinFuncProlog
        mov isTextInputActive, 1
        valload w9, taskListMaxCount
        cmp w9, w20
        ble skip_add
        // malloc 1024*sizeof(char)
        ldr x0, =1024
        bl _malloc
        mov currentStrPtr, x0
        skip_add:
        MinFuncEpilog

    .globl RemoveTask
    .p2align 2
    RemoveTask:
        MinFuncProlog
        cmp elementCount, 0
        beq skip_remove
        sub elementCount, elementCount, 1
        // load list
        ptrload x9, taskList
        // offset (each ptr is 8 bytes)
        mov x11, 8
        mul x11, elementCount, x11
        // taskList + 8*count is the current selection
        add x9, x9, x11
        // clear [x9] to NULL
        mov x10, 0
        str x10, [x9]
        skip_remove:
        MinFuncEpilog

    .globl EditTask
    .p2align 2
    EditTask:
        MinFuncProlog
        valload w12, taskListSelected
        cmp w20, w12
        ble skip_edit
        cmp w12, 0
        blt skip_edit
        // isEdit
        mov isEdit, 1
        mov isTextInputActive, 1
        // load list
        ptrload x9, taskList
        // offset (each ptr is 8 bytes)
        mov x11, 8
        // current
        mul x11, x12, x11
        // taskList + 8*count is the current selection
        add x9, x9, x11
        ldur currentStrPtr, [x9]
        skip_edit:
        MinFuncEpilog
