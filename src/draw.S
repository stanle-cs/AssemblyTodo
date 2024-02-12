.include "raylib.h"
.include "define.h"
.include "data.h"

.extern AddTask
.extern RemoveTask
.extern EditTask

isTextInputActive .req x19

.text

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
        mov x3, currentStrPtr
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
        tbnz isEdit, 0, input_edit
        // add to taskList
        ptrload x9, taskList
        // offset (each ptr is 8 bytes)
        mov x11, 8
        mul x11, elementCount, x11
        // taskList + 8*count is the current selection
        add x9, x9, x11
        // store ptr in x21 to x9
        str currentStrPtr, [x9]
        add elementCount, elementCount, 1
        mov w19, 0
        b input_done

        input_cancel:
        mov w19, 0
        b input_done

        input_edit:
        mov w19, 0
        mov isEdit, 0
        b input_done

        input_done:

        MinFuncEpilog

    .globl ScreenDraw
    .p2align 2
    ScreenDraw:
        MinFuncProlog
        bl _BeginDrawing

        // Clear white background
        ptrload x0, RAYWHITE
        ldur x0, [x0]
        bl _ClearBackground

        // draw overall panel
        ptrload x9, titleRec
        ldr s0, [x9]
        ldr s1, [x9, 4]
        ldr s2, [x9, 8]
        ldr s3, [x9, 12]
        ptrload x0, panelLabel
        bl _GuiPanel

        // draw addTask button
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

        // draw removeTask button
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

        // draw editTask button
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

        // draw the taskList
        ptrload x9, taskListRec
        ldr s0, [x9]
        ldr s1, [x9, 4]
        ldr s2, [x9, 8]
        ldr s3, [x9, 12]
        // list
        ptrload x0, taskList
        // count
        mov x1, elementCount
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
        tbz isTextInputActive, 0, no_input_needed
        bl DrawInput
        no_input_needed:

        bl _EndDrawing
        MinFuncEpilog

