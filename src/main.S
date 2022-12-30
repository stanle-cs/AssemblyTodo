.include "include/raylib.S"
.data
    /* data here */
    WIN_WIDTH = 330
    WIN_HEIGHT = 600
    winTitle: .asciz "App Window"

    addTaskRec:    .float 10.0
                   .float 33.0
                   .float 100.0
                   .float 50.0
    addTaskLabel: .asciz "Add Task"

    removeTaskRec: .float 115.0
                   .float 33.0
                   .float 100.0
                   .float 50.0
    removeTaskLabel: .asciz "Remove Task"

    editTaskRec:   .float 220.0
                   .float 33.0
                   .float 100.0
                   .float 50.0
    editTaskLabel: .asciz "Edit Task"

    titleRec:  .float 5.0
               .float 5.0
               .float 320.0
               .float 85.0
    panelLabel: .asciz "TODO APP"

    taskListRec:   .float 5.0
                   .float 93.0
                   .float 320.0
                   .float 500.0

    taskList: .fill 1024, 8, 0

    taskListScrollIndex: .word 0
    taskListFocus: .word -1
    taskListMaxCount: .word 1024
    taskListSelected: .word 0

    fadeAlpha: .float 0.6

    textInputRec:   .float 40
                    .float 150
                    .float 250
                    .float 150
    textInputWindowTitle: .asciz "Task Editor"
    textInputPrompt: .asciz "Please type in task..."
    textInputWindowButtons: .asciz "Ok;Cancel"
    textMaxSize: .int 255
.text
    .global _main
    .p2align 2
    _main:
        FuncProlog

        // x19 is isTextInputActive
        mov w19, 0
        // x20 is elementCount
        mov w20, 0
        // x21 is the ptr to current char* malloced
        mov x21, 0
        ldr x0, =1024
        bl _malloc
        mov x21, x0
        // x22 is isEdit
        mov x22, 0

        /* program starts here */
        mov x0, WIN_WIDTH
        mov x1, WIN_HEIGHT
        ptrload x2, winTitle
        bl _InitWindow

        mov x0, 60
        bl _SetTargetFPS

        main_loop:
            bl _WindowShouldClose
            tbnz w0, 0, exit
            bl LogicUpdate
            bl ScreenUpdate
            b main_loop
        exit:
        /* program ends here */

        // return 0
        mov w0, 0
        FuncEpilog

    .p2align 2
    LogicUpdate:
        MinFuncProlog
        MinFuncEpilog

    .p2align 2
    ScreenUpdate:
        MinFuncProlog
        bl _BeginDrawing

        ptrload x0, RAYWHITE
        ldur x0, [x0]
        bl _ClearBackground

        ptrload x9, titleRec
        ldr s0, [x9]
        ldr s1, [x9, 4]
        ldr s2, [x9, 8]
        ldr s3, [x9, 12]
        ptrload x0, panelLabel
        bl _GuiPanel

        ptrload x9, addTaskRec
        ldr s0, [x9]
        ldr s1, [x9, 4]
        ldr s2, [x9, 8]
        ldr s3, [x9, 12]
        ptrload x0, addTaskLabel
        bl _GuiButton
        tbz w0, 0, add_not_clicked
        bl AddTask
        add_not_clicked:

        ptrload x9, removeTaskRec
        ldr s0, [x9]
        ldr s1, [x9, 4]
        ldr s2, [x9, 8]
        ldr s3, [x9, 12]
        ptrload x0, removeTaskLabel
        bl _GuiButton
        tbz w0, 0, remove_not_clicked
        bl RemoveTask
        remove_not_clicked:

        ptrload x9, editTaskRec
        ldr s0, [x9]
        ldr s1, [x9, 4]
        ldr s2, [x9, 8]
        ldr s3, [x9, 12]
        ptrload x0, editTaskLabel
        bl _GuiButton
        tbz w0, 0, edit_not_clicked
        bl EditTask
        edit_not_clicked:

        ptrload x9, taskListRec
        ldr s0, [x9]
        ldr s1, [x9, 4]
        ldr s2, [x9, 8]
        ldr s3, [x9, 12]
        // list
        ptrload x0, taskList
        // count
        mov w1, w20
        // focus
        ptrload x2, taskListFocus
        // index
        ptrload x3, taskListScrollIndex
        // active
        ptrload x9, taskListSelected
        ldur w4, [x9]
        bl _GuiListViewEx
        // return the current active to taskListSelected
        ptrload x9, taskListSelected
        str w0, [x9]

        // draw input box if needed
        tbz x19, 0, no_input_needed
        bl DrawInput
        no_input_needed:

        bl _EndDrawing
        MinFuncEpilog

    .p2align 2
    ActivateInput:
        MinFuncProlog
        mov x19, 1
        MinFuncEpilog

    .p2align 2
    DrawInput:
        MinFuncProlog
        // w, h
        bl _GetScreenWidth
        mov w2, w0
        bl _GetScreenHeight
        mov w3, w0
        // fade background
        ptrload x9, RAYWHITE
        ldur x0, [x9]
        ptrload x9, fadeAlpha
        ldr s0, [x9]
        bl _Fade
        mov x4, x0
        // x, y
        mov w0, 0
        mov w1, 0
        bl _DrawRectangle

        // draw the box
        // boxRec
        ptrload x9, textInputRec
        ldr s0, [x9]
        ldr s1, [x9, 4]
        ldr s2, [x9, 8]
        ldr s3, [x9, 12]
        // title

        ptrload x0, textInputWindowTitle
        ptrload x1, textInputPrompt
        ptrload x2, textInputWindowButtons
        // x21 hold the newest
        mov x3, x21
        ptrload x9, textMaxSize
        ldur w4, [x9]
        mov x5, 0
        bl _GuiTextInputBox
        cmp w0, 1
        beq input_ok
        cmp w0, 2
        beq input_cancel
        b input_done

        input_ok:
        // check isEdit
        tbnz w22, 0, input_edit
        // add to taskList
        ptrload x9, taskList
        // offset (each ptr is 8 bytes)
        mov x11, 8
        mul x11, x20, x11
        // taskList + 8*count is the current selection
        add x9, x9, x11
        // store ptr in x21 to x9
        str x21, [x9]
        add x20, x20, 1
        mov w19, 0
        b input_done

        input_cancel:
        mov w19, 0
        b input_done

        input_edit:
        mov w19, 0
        mov x22, 0
        b input_done

        input_done:

        MinFuncEpilog

    .p2align 2
    AddTask:
        MinFuncProlog
        bl ActivateInput
        valload w9, taskListMaxCount
        cmp w9, w20
        ble skip_add
        // malloc 1024*sizeof(char)
        ldr x0, =1024
        bl _malloc
        mov x21, x0
        skip_add:
        MinFuncEpilog

    .p2align 2
    RemoveTask:
        MinFuncProlog
        cmp x20, 0
        beq skip_remove
        sub x20, x20, 1
        // load list
        ptrload x9, taskList
        // offset (each ptr is 8 bytes)
        mov x11, 8
        mul x11, x20, x11
        // taskList + 8*count is the current selection
        add x9, x9, x11
        // clear [x9] to NULL
        mov x10, 0
        str x10, [x9]
        skip_remove:
        MinFuncEpilog

    .p2align 2
    EditTask:
        MinFuncProlog
        valload w12, taskListSelected
        cmp w20, w12
        ble skip_edit
        cmp w12, 0
        blt skip_edit
        // isEdit
        mov x22, 1
        bl ActivateInput
        // load list
        ptrload x9, taskList
        // offset (each ptr is 8 bytes)
        mov x11, 8
        // current
        mul x11, x12, x11
        // taskList + 8*count is the current selection
        add x9, x9, x11
        ldur x21, [x9]
        skip_edit:
        MinFuncEpilog
