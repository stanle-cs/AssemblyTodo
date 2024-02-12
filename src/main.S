.include "raylib.h"
.include "define.h"
.include "data.h"

.extern ScreenDraw
//.extern LogicUpdate

.text
    .global _main
    .p2align 2
    _main:
        FuncProlog
        // x19 is isTextInputActive
        mov isTextInputActive, 0
        // x20 is elementCount
        mov elementCount, 0
        // x21 is the ptr to current char* malloced
        mov currentStrPtr, 0
        ldr x0, =1024
        bl _malloc
        mov currentStrPtr, x0
        // x22 is isEdit
        mov isEdit, 0

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
            //bl LogicUpdate
            bl ScreenDraw
            b main_loop
        exit:
        /* program ends here */

        // return 0
        mov w0, 0
        FuncEpilog
