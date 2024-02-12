.include "macros.h"

.data
.p2align 2
LIGHTGRAY:
    .byte 200
    .byte 200
    .byte 200
    .byte 255
GRAY:
    .byte 130
    .byte 130
    .byte 130
    .byte 255
DARKGRAY:
    .byte 80
    .byte 80
    .byte 80
    .byte 255
YELLOW:
    .byte 253
    .byte 249
    .byte 0
    .byte 255
GOLD:
    .byte 255
    .byte 203
    .byte 0
    .byte 255
ORANGE:
    .byte 255
    .byte 161
    .byte 0
    .byte 255
PINK:
    .byte 255
    .byte 109
    .byte 194
    .byte 255
RED:
    .byte 230
    .byte 41
    .byte 55
    .byte 255
MAROON:
    .byte 190
    .byte 33
    .byte 55
    .byte 255
GREEN:
    .byte 0
    .byte 228
    .byte 48
    .byte 255
LIME:
    .byte 0
    .byte 158
    .byte 47
    .byte 255
DARKGREEN:
    .byte 0
    .byte 117
    .byte 44
    .byte 255
SKYBLUE:
    .byte 102
    .byte 191
    .byte 255
    .byte 255
BLUE:
    .byte 0
    .byte 121
    .byte 241
    .byte 255
DARKBLUE:
    .byte 0
    .byte 82
    .byte 172
    .byte 255
PURPLE:
    .byte 200
    .byte 122
    .byte 255
    .byte 255
VIOLET:
    .byte 135
    .byte 60
    .byte 190
    .byte 255
DARKPURPLE:
    .byte 112
    .byte 31
    .byte 126
    .byte 255
BEIGE:
    .byte 211
    .byte 176
    .byte 131
    .byte 255
BROWN:
    .byte 127
    .byte 106
    .byte 79
    .byte 255
DARKBROWN:
    .byte 76
    .byte 63
    .byte 47
    .byte 255

WHITE:
    .byte 255
    .byte 255
    .byte 255
    .byte 255
BLACK:
    .byte 0
    .byte 0
    .byte 0
    .byte 255
BLANK:
    .byte 0
    .byte 0
    .byte 0
    .byte 0
MAGENTA:
    .byte 255
    .byte 0
    .byte 255
    .byte 255
RAYWHITE:
    .byte 245
    .byte 245
    .byte 245
    .byte 255

/*
KeyboardKey enums
*/

KEY_NULL            = 0        // Key: NULL, used for no key pressed
// Alphanumeric keys
KEY_APOSTROPHE      = 39       // Key: '
KEY_COMMA           = 44       // Key: ,
KEY_MINUS           = 45       // Key: -
KEY_PERIOD          = 46       // Key: .
KEY_SLASH           = 47       // Key: /
KEY_ZERO            = 48       // Key: 0
KEY_ONE             = 49       // Key: 1
KEY_TWO             = 50       // Key: 2
KEY_THREE           = 51       // Key: 3
KEY_FOUR            = 52       // Key: 4
KEY_FIVE            = 53       // Key: 5
KEY_SIX             = 54       // Key: 6
KEY_SEVEN           = 55       // Key: 7
KEY_EIGHT           = 56       // Key: 8
KEY_NINE            = 57       // Key: 9
KEY_SEMICOLON       = 59       // Key: ;
KEY_EQUAL           = 61       // Key: =
KEY_A               = 65       // Key: A | a
KEY_B               = 66       // Key: B | b
KEY_C               = 67       // Key: C | c
KEY_D               = 68       // Key: D | d
KEY_E               = 69       // Key: E | e
KEY_F               = 70       // Key: F | f
KEY_G               = 71       // Key: G | g
KEY_H               = 72       // Key: H | h
KEY_I               = 73       // Key: I | i
KEY_J               = 74       // Key: J | j
KEY_K               = 75       // Key: K | k
KEY_L               = 76       // Key: L | l
KEY_M               = 77       // Key: M | m
KEY_N               = 78       // Key: N | n
KEY_O               = 79       // Key: O | o
KEY_P               = 80       // Key: P | p
KEY_Q               = 81       // Key: Q | q
KEY_R               = 82       // Key: R | r
KEY_S               = 83       // Key: S | s
KEY_T               = 84       // Key: T | t
KEY_U               = 85       // Key: U | u
KEY_V               = 86       // Key: V | v
KEY_W               = 87       // Key: W | w
KEY_X               = 88       // Key: X | x
KEY_Y               = 89       // Key: Y | y
KEY_Z               = 90       // Key: Z | z
KEY_LEFT_BRACKET    = 91       // Key: [
KEY_BACKSLASH       = 92       // Key: '\'
KEY_RIGHT_BRACKET   = 93       // Key: ]
KEY_GRAVE           = 96       // Key: `
// Function keys
KEY_SPACE           = 32       // Key: Space
KEY_ESCAPE          = 256      // Key: Esc
KEY_ENTER           = 257      // Key: Enter
KEY_TAB             = 258      // Key: Tab
KEY_BACKSPACE       = 259      // Key: Backspace
KEY_INSERT          = 260      // Key: Ins
KEY_DELETE          = 261      // Key: Del
KEY_RIGHT           = 262      // Key: Cursor right
KEY_LEFT            = 263      // Key: Cursor left
KEY_DOWN            = 264      // Key: Cursor down
KEY_UP              = 265      // Key: Cursor up
KEY_PAGE_UP         = 266      // Key: Page up
KEY_PAGE_DOWN       = 267      // Key: Page down
KEY_HOME            = 268      // Key: Home
KEY_END             = 269      // Key: End
KEY_CAPS_LOCK       = 280      // Key: Caps lock
KEY_SCROLL_LOCK     = 281      // Key: Scroll down
KEY_NUM_LOCK        = 282      // Key: Num lock
KEY_PRINT_SCREEN    = 283      // Key: Print screen
KEY_PAUSE           = 284      // Key: Pause
KEY_F1              = 290      // Key: F1
KEY_F2              = 291      // Key: F2
KEY_F3              = 292      // Key: F3
KEY_F4              = 293      // Key: F4
KEY_F5              = 294      // Key: F5
KEY_F6              = 295      // Key: F6
KEY_F7              = 296      // Key: F7
KEY_F8              = 297      // Key: F8
KEY_F9              = 298      // Key: F9
KEY_F10             = 299      // Key: F10
KEY_F11             = 300      // Key: F11
KEY_F12             = 301      // Key: F12
KEY_LEFT_SHIFT      = 340      // Key: Shift left
KEY_LEFT_CONTROL    = 341      // Key: Control left
KEY_LEFT_ALT        = 342      // Key: Alt left
KEY_LEFT_SUPER      = 343      // Key: Super left
KEY_RIGHT_SHIFT     = 344      // Key: Shift right
KEY_RIGHT_CONTROL   = 345      // Key: Control right
KEY_RIGHT_ALT       = 346      // Key: Alt right
KEY_RIGHT_SUPER     = 347      // Key: Super right
KEY_KB_MENU         = 348      // Key: KB menu
// Keypad keys
KEY_KP_0            = 320      // Key: Keypad 0
KEY_KP_1            = 321      // Key: Keypad 1
KEY_KP_2            = 322      // Key: Keypad 2
KEY_KP_3            = 323      // Key: Keypad 3
KEY_KP_4            = 324      // Key: Keypad 4
KEY_KP_5            = 325      // Key: Keypad 5
KEY_KP_6            = 326      // Key: Keypad 6
KEY_KP_7            = 327      // Key: Keypad 7
KEY_KP_8            = 328      // Key: Keypad 8
KEY_KP_9            = 329      // Key: Keypad 9
KEY_KP_DECIMAL      = 330      // Key: Keypad .
KEY_KP_DIVIDE       = 331      // Key: Keypad /
KEY_KP_MULTIPLY     = 332      // Key: Keypad *
KEY_KP_SUBTRACT     = 333      // Key: Keypad -
KEY_KP_ADD          = 334      // Key: Keypad +
KEY_KP_ENTER        = 335      // Key: Keypad Enter
KEY_KP_EQUAL        = 336      // Key: Keypad =
// Android key buttons
KEY_BACK            = 4        // Key: Android back button
KEY_MENU            = 82       // Key: Android menu button
KEY_VOLUME_UP       = 24       // Key: Android volume up button
KEY_VOLUME_DOWN     = 25       // Key: Android volume down button
