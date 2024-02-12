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
