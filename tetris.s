# INFO ABOUT ALLOCATION OF GLOBAL VARIABLES
# 0x08000000  - address of the beginning of the statically allocated memory,
#               stored in r12
# r12 + 0x20  - address of the pointer to the frame buffer
# r12 + 0x40  - address of the x coordinate of the top left corner of the
#               currently falling piece
# r12 + 0x44  - address of the y coordinate of the top left corner of the
#               currently falling piece
# r12 + 0x48  - address of the shape of the currently falling piece
# r12 + 0x4c  - address of the rotation of the currently falling piece
# r12 + 0x50  - address of the shape of the next piece
# r12 + 0x54  - address of the x coordinate of the top left corner of the game
#               board including sentinel values
# r12 + 0x58  - address of the y coordinate of the top left corner of the game
#               board including sentinel values
# r12 + 0x5c  - address of the x coordinate of the bottom right corner of the
#               game board including sentinel values
# r12 + 0x60  - address of the y coordinate of the bottom right corner of the
#               game board including sentinel values
# r12 + 0x64  - address of the x coordinate of the top-left corner of tested
#               next position of the falling piece
# r12 + 0x68  - address of the y coordinate of the top-left corner of tested
#               next position of the falling piece
# r12 + 0x6c  - address of the tested rotation of the falling piece
# r12 + 0x70  - address of the number of last available row to the user
#               (needed for adding line in multi-player)
# r12 + 0x74  - address of the seed of the generator of pseudo random numbers
# r12 + 0x78  - address of the number of lines to send
# r12 + 0x7c  - address of the number of lines received
# r12 + 0x80  - address of the beginning of the array in which the rotations
#               are encoded
# r12 + 0x800 - address of the beginning of the game board array 
# r12 + 0xe00 - address of the beginning of the character encoding
# r12 + 0x1600 - address of the second buffer

b main

# load game assets
assets:
	.incbin "welcome_screen.bin"
	.incbin "gamelost.bin"
	.incbin "gamewon.bin"
	.incbin "welcome_start.bin"

	.incbin "O_yellow.bin"
	.incbin "I_cyan.bin"
	.incbin "S_green.bin"
	.incbin "Z_red.bin"
	.incbin "L_orange.bin"
	.incbin "J_blue.bin"
	.incbin "T_purple.bin"
	.incbin "filled_grey.bin"

	.incbin "text_next.bin"

LoadScreenWelcome:
	push {lr}
	mov r0, #assets
	add r0, r0, #0x8000
	pop {pc}

LoadScreenLost:
	push {lr}
	bl LoadScreenWelcome
	add r0, r0, #0x12c000
	pop {pc}

LoadScreenWon:
	push {lr}
	bl LoadScreenWelcome
	add r0, r0, #0x258000
	pop {pc}

LoadScreenStart:
	push {lr}
	bl LoadScreenWelcome
	add r0, r0, #0x384000
	pop {pc}

LoadPieces:
	push {lr}
	bl LoadScreenWelcome
	add r0, r0, #0x4B0000
	pop {pc}

LoadTextNext:
	push {lr}
	bl LoadPieces
	add r0, r0, #0x8000
	pop {pc}

main:

# --------------Initialisation of r12 and the stack pointer-------------------

	# Initialise pointer to static memory
	mov r12, #0x08000000

	# Initialise value of the stack pointer
	mov sp, #0x08000000
	sub sp, sp, #4


# --------------Initialisation of pieces and rotations in static memory region-
# each integer at memory location represents 32bit RGBa value of the piece
# variable naming convention: OFFSET_PIECE_ROTATION
# PIECE: {O, I, S, Z, L, J, T}
# ROTATION: {0, 1, 2, 3}
# Initialisation of the rotations array.

	# Set the offset from the global memory pointer
	mov r2, #0x80

	#Set the offset from the global memory pointer.
	mov r3, #0
	#Store colour 0 (unoccupied field) in register r3.
#---------------Rotations of the shape O---------------
	mov r4, #1
	#Set colour of the current shape
	#-----Rotation 0
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#-----Rotation 1
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#-----Rotation 2
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#-----Rotation 3
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#---------------Rotations of the shape I---------------
	mov r4, #2
	#Set colour of the current shape
	#-----Rotation 0
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#-----Rotation 1
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#-----Rotation 2
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#-----Rotation 3
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#---------------Rotations of the shape S---------------
	mov r4, #3
	#Set colour of the current shape
	#-----Rotation 0
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#-----Rotation 1
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#-----Rotation 2
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#-----Rotation 3
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#---------------Rotations of the shape Z---------------
	mov r4, #4
	#Set colour of the current shape
	#-----Rotation 0
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#-----Rotation 1
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#-----Rotation 2
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#-----Rotation 3
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#---------------Rotations of the shape L---------------
	mov r4, #5
	#Set colour of the current shape
	#-----Rotation 0
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#-----Rotation 1
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#-----Rotation 2
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#-----Rotation 3
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#---------------Rotations of the shape J---------------
	mov r4, #6
	#Set colour of the current shape
	#-----Rotation 0
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#-----Rotation 1
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#-----Rotation 2
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#-----Rotation 3
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#---------------Rotations of the shape T---------------
	mov r4, #7
	#Set colour of the current shape
	#-----Rotation 0
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#-----Rotation 1
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#-----Rotation 2
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#-----Rotation 3
	#Row 0
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4

#---------------End of initialisation of pieces and rotations------------------

#---------------Initialise frame buffer info-----------------------------------

	#getting address of frame buffer info
	mov r0, r12

	#physical width - 1920
	mov r1, #0x780
	str r1, [r0]
	add r0, r0, #4
	#physical height - 1080
	mov r1, #0x430
	add r1, r1, #0x8
	str r1, [r0]
	add r0, r0, #4
	#virtual width - 480
	mov r1, #0x1e0
	str r1, [r0]
	add r0, r0, #4
	#virtual height - 640
	mov r1, #0x280
	str r1, [r0]
	add r0, r0, #8
	#bit depth - 32
	mov r1, #32
	str r1, [r0]

#---------------End of initialisation of frame buffer info---------------------

#---------------Negotiation of frame buffer------------------------------------

	# write mailbox base number to r0
	mov r0, #0x20000000
	add r0, r0, #0x0000B800
	add r0, r0, #0x00000080


check_status_31:
	#check if status says "you can send"
	ldr r1, [r0, #0x00000018]
	tst r1, #0x80000000
	bne check_status_31

	#generating our message
	mov r1, r12
	add r1, r1, #0x00000001
	add r1, r1, #0x40000000
	#sending our message (to mailbox channel 1)
	str r1, [r0, #0x00000020]

check_status_30:
	ldr r1, [r0, #0x00000018]
	tst r1, #0x40000000
	bne check_status_30

read_result:
	#reading from read field (checking if last four bits are 0001)
	ldr r2, [r0]
	and r3, r2, #0x0000000f
	cmp r3, #0x00000001
	bne read_result

#---------------End of negotiations------------------------------------------

#---------------NES Controller Initialisation--------------------------------

	# setup clock and latch for reading from GPIO
	# Pin       - shift
	# data pin  - 2, 27, 8, 21
	# clock pin - 1, 18, 4, 24
	# latch pin - 0, 17, 4, 21
	# gpio set address - 7 for 0-31, 8 for 32-63
	# gpio clear address - 10 for 0-31, 11 for 32-63
	# r3 - 0x20200000

	# get gpio base address
	bl GetGpioBase
	mov r3, r0

	# clear latch and clock pin
	mov r1, #3
	lsl r1, #17
	str r1, [r3, #40]

	# set pin mode of latch to output
	# *(gpio + fSel) = (*(gpio + fSel) & ~(7 << shift)) | (1 << shift)
	mov r0, #21
	bl CreateMask

	# load original value
	ldr r1, [r3, #4]

	# clear bits
	and r1, r1, r0

	# set output bit
	mov r0, #1
	lsl r0, #21
	orr r1, r1, r0

	# store value
	str r1, [r3, #4]

	# set pin mode of clock to output
	mov r0, #24
	bl CreateMask

	# load original value
	ldr r1, [r3, #4]

	# clear bits
	and r1, r1, r0

	# set output bit
	mov r0, #1
	lsl r0, #24
	orr r1, r1, r0

	# store value
	str r1, [r3, #4]

	# set pin mode of data to input
	# *(gpio + fSel) = (*(gpio + fSel) & ~(7 << shift))
	# (Sets bits to zero = input)
	mov r0, #21
	bl CreateMask

	# load original value
	ldr r1, [r3, #8]

	# clear bits
	and r1, r1, r0

	# store value
	str r1, [r3, #8]

#---------------End of NES Controler Initialisation----------------------------

#---------------Networking Initialisation--------------------------------------

	# Send Line Pin  - 22, 6
	# Receive Line   - 23, 9
	# Send Status    - 24, 12
	# Receive Status - 25, 15

	# get gpio base address
	bl GetGpioBase
	mov r3, r0

	# clear send line pin
	mov r1, #1
	lsl r1, #22
	str r1, [r3, #40]

	# set pin mode of send line to output
	mov r0, #6
	bl CreateMask

	# load original value
	ldr r1, [r3, #8]

	# clear bits
	and r1, r1, r0

	# set output bit
	mov r0, #1
	lsl r0, #6
	orr r1, r1, r0

	# store value
	str r1, [r3, #8]



	# clear send status pin
	mov r1, #1
	lsl r1, #24
	str r1, [r3, #40]

	# set pin mode of send line to output
	mov r0, #12
	bl CreateMask

	# load original value
	ldr r1, [r3, #8]

	# clear bits
	and r1, r1, r0

	# set output bit
	mov r0, #1
	lsl r0, #12
	orr r1, r1, r0

	# store value
	str r1, [r3, #8]


	# clear game over send pin
	mov r1, #1
	lsl r1, #11
	str r1, [r3, #40]

	# set pin mode of send line to output
	mov r0, #3
	bl CreateMask

	# load original value
	ldr r1, [r3, #4]

	# clear bits
	and r1, r1, r0

	# set output bit
	mov r0, #1
	lsl r0, #3
	orr r1, r1, r0

	# store value
	str r1, [r3, #4]


	# set pin mode of receive line to input
	mov r0, #9
	bl CreateMask

	# load original value
	ldr r1, [r3, #8]

	# clear bits
	and r1, r1, r0

	# store value
	str r1, [r3, #8]



	# set pin mode of receive status to input
	mov r0, #15
	bl CreateMask

	# load original value
	ldr r1, [r3, #8]

	# clear bits
	and r1, r1, r0

	# store value
	str r1, [r3, #8]


	# set pin mode of game over to input
	mov r0, #27
	bl CreateMask

	# load original value
	ldr r1, [r3]

	# clear bits
	and r1, r1, r0

	# store value
	str r1, [r3]

#---------------End of Networking Initialisation-------------------------------



#---------------START OF THE GAME----------------------------------------------

start_game:
	bl LoadScreenWelcome
	bl DrawFullScreen

	#Clearing of the game board.
	mov r2, #0x00000800
	#Store colour 0 (unoccupied field) in register r3.
	mov r3, #0
	#Store sentinel value 8 in r4.
	mov r4, #8
	#Row 0
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 1
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 2
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 3
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 5
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 6
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 7
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 8
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 9
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 10
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 11
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 12
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 13
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 14
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 15
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 16
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 17
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 18
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 19
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 20
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r3, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 21
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 22
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	#Row 23
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	str r4, [r12, r2]
	add r2, r2, #4
	
# ---------------Initialisation of the global variables------------------------

	# Initialise the seed of the generator of random numbers
	bl GetTimeStamp
	str r0, [r12, #0x74]

	# Initialise the x coordinate of the top left corner of the
	# falling piece
	mov r1, #6
	str r1, [r12, #0x40]

	# Initialise the y coordinate of the top left corner of the
	# falling piece
	mov r1, #0
	str r1, [r12, #0x44]

	# Initialise the shape of the falling piece
	bl RandomGenerator
	str r0, [r12, #0x48]

	# Initialise the rotation of the falling piece
	mov r1, #0
	str r1, [r12, #0x4c]

	# Initialise the shape of the next piece
	bl RandomGenerator
	str r0, [r12, #0x50]

	# Initialise the x coordinate of the top left corner of the game board
	# including sentinel values
	mov r1, #3
	str r1, [r12, #0x54]

	# Initialise the y coordinate of the top left corner of the game board
	# including sentinel values
	mov r1, #1
	str r1, [r12, #0x58]

	# Initialise the x coordinate of the bottom right corner of the game
	# board including sentinel values
	mov r1, #12
	str r1, [r12, #0x5c]

	# Initialise the y coordinate of the bottom right corner of the game
	# board including sentinel values
	mov r1, #20
	str r1, [r12, #0x60]

	# Initialise the x coordinate of the next position of the piece
	mov r1, #6
	str r1, [r12, #0x64]

	# Initialise the y coordinate of the next position of the piece
	mov r1, #0
	str r1, [r12, #0x68]

	# Initialise the next rotation of the piece
	mov r1, #0
	str r1, [r12, #0x6c]

	# Initialise the number of last available row to the user
	mov r1, #20
	str r1, [r12, #0x70]

	# Initialise send and recieve line counter
	mov r1, #0
	str r1, [r12, #0x78]
	str r1, [r12, #0x7c]

#---------------Waiting for the player-----------------------------------------

	bl GetTimeStamp

flash_start:
	add r4, r0, #0x100000
	bl LoadScreenStart
	bl DrawFullScreen
	mov r5, #1

wait_player:

	bl PollController

	# if start pressed, then send signal to opponent, start game
	cmp r0, #0x10
	beq signal_opponent
	
	#check if opponent started a game - i.e. sent you a line
	bl ReceiveLine
	ldr r0, [r12, #0x7c]
	cmp r0, #0
	bne opponent_started_game
	
	bl GetTimeStamp
	cmp r0, r4
	blt wait_player

	# check if currently drawn screen is blank
	cmp r5, #0
	beq flash_start

	add r4, r0, #0xB0000
	bl LoadScreenWelcome
	bl DrawFullScreen
	mov r5, #0

b wait_player

signal_opponent:
	# increase send line counter
	ldr r3, [r12, #0x78]
	add r3, r3, #1
	str r3, [r12, #0x78]
	# send line to opponent to signal start of a game
	bl SendLine
	b next_fall

opponent_started_game:
	# decrement the number of lines received
	ldr r0, [r12, #0x7c]
	sub r0, r0, #1
	str r0, [r12, #0x7c]
	

#---------------Main game logic------------------------------------------------

next_fall:
	# draw falling piece to game board
	bl UpdateBoard
	bl RenderBoard

	# r4 - stores next fall timestamp, about 1 second
	bl GetTimeStamp
	mov r4, r0
	add r4, r4, #0xF0000

get_input:
	# Check if you won the game
	bl GetGpioBase
	mov r3, r0
	# load input
	ldr r0, [r3, #52]
	# check if pin set to high
	mov r1, #1
	lsl r1, #9
	tst r0, r1
	bne game_won

	bl ReceiveLine
	bl SendLine
	bl PollController
	
	bl ClearBoard
	
	check_right:
		cmp r0, #0x01
		bne check_left
		
		#check if FitsShape(x+1, y)
		ldr r1, [r12, #0x40]
		add r1, r1, #1
		str r1, [r12, #0x64]
		ldr r1, [r12, #0x44]
		str r1, [r12, #0x68]
		ldr r1, [r12, #0x4c]
		str r1, [r12, #0x6c]
		bl FitsShape
		
		cmp r0, #0
		beq check_right_failed
		ldr r1, [r12, #0x40]
		add r1, r1, #1
		str r1, [r12, #0x40]
		
		check_right_failed:
			b finish_move
	
	check_left:
		cmp r0, #0x02
		bne check_rotations
		
		#check if FitsShape(x-1, y)
		ldr r1, [r12, #0x40]
		sub r1, r1, #1
		str r1, [r12, #0x64]
		ldr r1, [r12, #0x44]
		str r1, [r12, #0x68]
		ldr r1, [r12, #0x4c]
		str r1, [r12, #0x6c]
		bl FitsShape
		
		cmp r0, #0
		beq check_left_failed
		ldr r1, [r12, #0x40]
		sub r1, r1, #1
		str r1, [r12, #0x40]
		
		check_left_failed:
			b finish_move
	
	check_rotations:
		cmp r0, #0x40
		bne check_hard_drop

		#newRotation will be returned in r0 and then stored in r2
		bl GetNextRotation
		mov r2, r0
		
		#check if FitsShape(x, y, newRotation)
		ldr r1, [r12, #0x40]
		str r1, [r12, #0x64]
		ldr r1, [r12, #0x44]
		str r1, [r12, #0x68]
		str r2, [r12, #0x6c]
		bl FitsShape
		
		cmp r0, #0
		beq check_rotations_failed
		str r2, [r12, #0x4c]
		#delay so that rotations are not too sensitive
		mov r0, #0xB000
		bl Wait
		
		check_rotations_failed:
			b finish_move
	
	check_hard_drop:
		cmp r0, #0x80
		bne check_down
		
		loop_moving_down:
			#check if FitsShape(x, y + 1)
			ldr r1, [r12, #0x40]
			str r1, [r12, #0x64]
			ldr r1, [r12, #0x44]
			add r1, r1, #1
			str r1, [r12, #0x68]
			ldr r1, [r12, #0x4c]
			str r1, [r12, #0x6c]
			bl FitsShape
			
			cmp r0, #0
			beq check_hard_drop_failed
			
			#update position and go to next check
			ldr r1, [r12, #0x44]
			add r1, r1, #1
			str r1, [r12, #0x44]
		b loop_moving_down
			
		check_hard_drop_failed:
			b finish_move
	
	check_down:
		cmp r0, #0x04
		bne finish_move
		
		
		#check if FitsShape(x, y + 1)
		ldr r1, [r12, #0x40]
		str r1, [r12, #0x64]
		ldr r1, [r12, #0x44]
		add r1, r1, #1
		str r1, [r12, #0x68]
		ldr r1, [r12, #0x4c]
		str r1, [r12, #0x6c]
		bl FitsShape
		
		cmp r0, #0
		beq check_down_failed
		ldr r1, [r12, #0x44]
		add r1, r1, #1
		str r1, [r12, #0x44]
		
		check_down_failed:
			b finish_move
		
		
	
	finish_move:
		bl UpdateBoard
		bl RenderBoard
	
	

	bl GetTimeStamp
	cmp r0, r4
	blt get_input

check_if_collided:
	# store result of collision test in r0, 0 = collided
	ldr r0, [r12, #0x40]
	str r0, [r12, #0x64]

	ldr r0, [r12, #0x44]
	add r0, r0, #1
	str r0, [r12, #0x68]

	ldr r0, [r12, #0x4c]
	str r0, [r12, #0x6c]

	bl ClearBoard
	bl FitsShape
	bl UpdateBoard

	cmp r0, #0
	# collided
	beq delting_full_rows

	# falls current piece
	bl ClearBoard

	# increment y coord by 1
	ldr r0, [r12, #0x44]
	add r0, r0, #1
	str r0, [r12, #0x44]

	b next_fall

delting_full_rows:
	bl DeleteRows

check_if_game_over:
	# store result of game over test in r0, 0 = game over,
	# 1 - game can be continued
	bl EndGame
	cmp r0, #0
	beq game_lost

	# transfer next piece to falling piece
	ldr r0, [r12, #0x50]
	str r0, [r12, #0x48]

	# Initialise the x coordinate of the top left corner of the
	# falling piece
	mov r1, #6
	str r1, [r12, #0x40]

	# Initialise the y coordinate of the top left corner of the
	# falling piece
	mov r1, #0
	str r1, [r12, #0x44]
	
	# Set rotation of falling piece to 0 (as next shape has such rotation
	# by default)
	mov r1, #0
	str r1, [r12, #0x4c]

	# pseudo randomly generate next piece
	bl RandomGenerator
	str r0, [r12, #0x50]

	b next_fall

game_lost:
	bl LoadScreenLost
	bl DrawFullScreen

	#send signal that game was lost (pin 23)
	mov r0, #11
	bl SetPinHigh

	mov r0, #0x00800000
	bl Wait

	mov r0, #11
	bl SetPinLow

	b start_game

game_won:
	bl LoadScreenWon
	bl DrawFullScreen

	mov r0, #0x00800000
	bl Wait

	b start_game


# --------------Rendering------------------------------------------------------

DrawFullScreen:
	# r0 - argument, memory location of image to draw
	push {lr}
	push {r1}
	push {r2}
	push {r3}
	push {r4}

	mov r4, r0

	ldr r0, [r12, #32]
	mov r1, #0x4B000
	mov r2, #0
	loop_draw:
		ldr r3, [r4]

		# skip alpha
		tst r3, #0xff000000
		beq dont_draw
		str r3, [r0]
		dont_draw:

		add r0, r0, #4
		add r4, r4, #4
		add r2, r2, #1
	cmp r1, r2
	bne loop_draw

	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	pop {pc}

RenderBoard:
	#push registers
	push {r0}
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	push {r8}
	push {r9}
	push {r10}
	push {r11}


	# Rendering the game board (grid)
	# r1, r2, r3, r4 - register used as iterators
	# Loop iterating over the rows of the game board
	mov r1, #1
	game_board_rows:
		# Loop iterating over the columns of the game board
		mov r2, #3
		game_board_cols:
			# r5 - stores the colour of the field of the gameboard
			# that is currently analysed
			mov r6, #16
			mul r7, r1, r6
			add r7, r7, r2
			lsl r7, #2
			add r7, r7, r12
			add r7, r7, #0x800
			ldr r5, [r7]

			push {lr}
			bl PrintSquare
			pop {lr}					
		add r2, r2, #1
		cmp r2, #13
		bne game_board_cols
	add r1, r1, #1
	cmp r1, #21
	bne game_board_rows

	
	# Rendering the 'next block' side window
	# r11 - address of the beginning of the shape of the next block
	add r11, r12, #0x80
	ldr r1, [r12, #0x50]
	lsl r1, #8
	add r11, r11, r1	

	# r1, r2, r3, r4 - register used as iterators
	# Loop iterating over the rows of the game board
	mov r1, #2
	next_board_rows:
		# Loop iterating over the columns of the game board
		mov r2, #14
		next_board_cols:
			# r5 - stores the colour of the field of the gameboard
			# that is currently analysed
			ldr r5, [r11]
			add r11, r11, #4
			
			push {lr}
			bl PrintSquare
			pop {lr}
		add r2, r2, #1
		cmp r2, #18
		bne next_board_cols
	add r1, r1, #1
	cmp r1, #6
	bne next_board_rows


	# printing the NEXT label
	# store in r0 the beginning of the encoding of the label
	push {lr}
	bl LoadTextNext
	pop {lr}
	# set the x coordinate of the beginning of the NEXT label
	mov r1, #11
	lsl r1, #7
	# set pointer to the pixel of the second (intermediate)buffer
	# that we are going to change
	add r5, r12, #0x1600
	add r5, r5, r1
	# set the y coordinate of the beginning of the NEXT label
	mov r2, #0
	# loop over the rows of the NEXT label
	mov r3, #0
	render_next_rows:
		# loop over the columns of the NEXT label
		mov r4, #0
		render_next_cols:
			# load to r6 the colour that we should render
			ldr r6, [r0]
			str r6, [r5]
			add r0, r0, #4
			add r5, r5, #4
		add r4, r4, #1
		# width of label
		cmp r4, #128
		bne render_next_cols
		# advance to the next line
		add r5, r5, r1
	add r3, r3, #1
	# height of label
	cmp r3, #32
	bne render_next_rows



	# Updating the frame buffer
	ldr r0, [r12, #32]
	mov r1, #0x4B000
	mov r2, #0
	add r3, r12, #0x1600
	loop_buffer:
		ldr r4, [r3]
		str r4, [r0]
		add r3, r3, #4
		add r0, r0, #4
	add r2, r2, #1
	cmp r1, r2
	bne loop_buffer


	#pop registers
	pop {r11}
	pop {r10}
	pop {r9}
	pop {r8}
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	pop {r0}

	mov pc, lr
# --------------End of rendering functions-------------------------------------


#---------------Rendering helper function - Print square-----------------------
# PRE: r1 - y coordinate of the gameboard field
#      r2 - x coordinate of the gameboard field
#      r5 - colour of the field
PrintSquare:
	# r7 - beginning of the memory space to which we write
	# the future content of the frame buffer
	add r7, r12, #0x1600
	# r8 - y coordinate of the pixel that we change
	mov r0, #0x1e0
	mul r8, r1, r0
	sub r8, r8, #0x1e0
	lsl r8, #7
	# r9 - x coordinate of the pixel that we change
	sub r9, r2, #3
	lsl r9, #7
	# r10 - pointer to the value of the frame buffer
	# currently modified
	add r10, r8, r9
	add r10, r10, r7

	cmp r5, #0
	bne print_in_colour
	# print the current square in black
	tst r1, #1
	bne render_black_second_test
	tst r2, #1
	bne render_print_darker
	b render_print_lighter

	render_black_second_test:
	tst r2, #1
	bne render_print_lighter
	b render_print_darker

	render_print_lighter:
	mov r6, #0xff000000
	add r6, r6, #0x280000
	add r6, r6, #0x2800
	add r6, r6, #0x28
        b render_print_black

	render_print_darker:
	mov r6, #0xff000000
	add r6, r6, #0x200000
	add r6, r6, #0x2000
	add r6, r6, #0x20

	render_print_black:
	mov r3, #0
	for_print_black_rows:
		mov r4, #0
		for_print_black_cols:
			str r6, [r10]
			add r10, r10, #4
			add r4, r4, #1
		cmp r4, #32
		bne for_print_black_cols
		# advance to the next row
		add r10, r10, #0x700
		add r3, r3, #1
	cmp r3, #32
	bne for_print_black_rows  
	b render_end_printing


	print_in_colour:
	# print the current square in colour
	# r6 - pointer to the current colour from the colour table
	sub r5, r5, #1
	lsl r5, #12
	push {lr}
	bl LoadPieces
	pop {lr}
	add r6, r0, r5

	mov r3, #0
	for_print_colour_rows:
		mov r4, #0
		for_print_colour_cols:
			ldr r8, [r6]
			str r8, [r10]
			add r6, r6, #4
			add r10, r10, #4
			add r4, r4, #1
		cmp r4, #32
		bne for_print_colour_cols
		# advance to the next row
		add r10, r10, #0x700
		add r3, r3, #1
	cmp r3, #32
	bne for_print_colour_rows 

	render_end_printing:	
	mov pc, lr
#---------------End of the helper function-------------------------------------


#---------------Handling of signals from opponents-----------------------------

ReceiveLine:
	# poll GPIO status from second pi
	# data pin - 52, mask - 23
	# r3 - GPIO base address
	# r4 - number of lines received
	push {lr}
	push {r3}
	push {r4}
	push {r5}
	push {r6}

	bl GetGpioBase
	mov r3, r0

	# load input
	ldr r0, [r3, #52]

	# check if send status is high
	# aka. p2 has acknolwedged receipt
	mov r1, #1
	lsl r1, #24
	tst r0, r1
	beq start_receive

	# check if send line is still set
	mov r1, #1
	lsl r1, #23
	tst r0, r1
	bne nothing_received

	# off status pin
	mov r0, #24
	bl SetPinLow
	b nothing_received

	start_receive:
		# mask receive line pin
		mov r1, #1
		lsl r1, #23
		tst r0, r1
		beq nothing_received

		# inform p2 that a line was received
		mov r0, #24
		bl SetPinHigh

		# increment the number of lines received
		ldr r0, [r12, #0x7c]
		add r0, r0, #1
		str r0, [r12, #0x7c]

	nothing_received:
		pop {r6}
		pop {r5}
		pop {r4}
		pop {r3}
		pop {pc}

SendLine:
	# data pin - 52, mask - 22
	push {lr}
	push {r3}
	push {r4}
	push {r5}
	push {r6}

	bl GetGpioBase
	mov r3, r0

	# load input
	ldr r0, [r3, #52]

	# check if p2 has received
	mov r1, #1
	lsl r1, #25
	tst r0, r1
	bne switch_off

	# load the number of lines to send
	ldr r4, [r12, #0x78]
	cmp r4, #0
	beq nothing_to_send

	# set send line pin to high
	mov r0, #22
	bl SetPinHigh

	# decrease send line counter
	sub r4, r4, #1
	str r4, [r12, #0x78]

	b nothing_to_send

	switch_off:
		mov r0, #22
		bl SetPinLow

	nothing_to_send:
		pop {r6}
		pop {r5}
		pop {r4}
		pop {r3}
		pop {pc}

#---------------End of handling of signals from opponents----------------------

#---------------Controlling hardware functions---------------------------------

PollController:
	push {lr}
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}

	# init gpio and timer address
	mov r6, #0x20000000
	add r3, r6, #0x00200000
	add r6, r6, #0x00003000

	# timestamp
	ldr r2, [r6, #4]

	# set latch and clock pin to high
	mov r1, #0x60000
	str r1, [r3, #28]

	# delay 12
	add r2, r2, #12
	delay1:
		ldr r0, [r6, #4]
	cmp r0, r2
	blt delay1
	mov r2, r0

	# set latch to low
	mov r1, #0x20000
	str r1, [r3, #40]

	# intialise return value and loop counter
	mov r4, #0
	mov r5, #8

	poll_8:
		add r2, r2, #6
		wait_6_1:
			ldr r0, [r6, #4]
		cmp r0, r2
		blt wait_6_1
		mov r2, r0

		# set clock to low
		mov r1, #0x40000
		str r1, [r3, #40]

		# read input
		ldr r0, [r3, #52]

		# mask input pin
		mov r0, r0, lsr #27
		and r0, r0, #1

		# not input
		eor r0, r0, #1

		# shift and accumulate
		add r4, r0, r4, lsl #1

		add r2, r2, #6
		wait_6_2:
			ldr r0, [r6, #4]
		cmp r0, r2
		blt wait_6_2
		mov r2, r0

		# set clock to high
		mov r1, #0x40000
		str r1, [r3, #28]

	# decrement loop counter
	sub r5, r5, #1
	cmp r5, #0
	bgt poll_8

	return:
		mov r0, r4

		pop {r6}
		pop {r5}
		pop {r4}
		pop {r3}
		pop {r2}
		pop {r1}
		pop {pc}

GetPiBase:
	push {lr}

	mov r0, #0x20000000

	pop {pc}

GetTimerBase:
	push {lr}

	bl GetPiBase
	add r0, r0, #0x00003000

	pop {pc}

GetGpioBase:
	push {lr}

	bl GetPiBase
	add r0, r0, #0x00200000

	pop {pc}

GetTimeStamp:
	push {lr}

	# only load the lower 32 bit of timer, max 1 hour
	bl GetTimerBase
	ldr r0, [r0, #4]

	pop {pc}

Wait:
	# r0 - argument, duration in microseconds
	# r4 - expiration time
	push {lr}
	push {r4}

	mov r4, r0
	bl GetTimeStamp
	add r4, r4, r0

	do_nothing:
	bl GetTimeStamp
	cmp r0, r4
	blt do_nothing

	pop {r4}
	pop {pc}

CreateMask:
	# make a mask to clear bits
	# r0 - argument shift value
	# r1 - shifted 3 bits
	# r2 - negative 1
	# r0 - return bit mask
	push {lr}
	push {r1}
	push {r2}

	mov r2, #0
	sub r2, r2, #1

	mov r1, #7
	lsl r1, r0

	eor r0, r1, r2

	pop {r2}
	pop {r1}
	pop {pc}

SetPinHigh:
	push {lr}
	push {r1}

	# r0 - BCM pin number
	mov r1, #1
	lsl r1, r0

	# set pin to High
	bl GetGpioBase
	str r1, [r0, #28]

	pop {r1}
	pop {pc}

SetPinLow:
	push {lr}
	push {r1}

	# r0 - BCM pin number
	mov r1, #1
	lsl r1, r0

	# set pin to High
	bl GetGpioBase
	str r1, [r0, #40]

	pop {r1}
	pop {pc}

#---------------End of controlling hardware functions--------------------------

#---------------Clearing game board--------------------------------------------

ClearBoard:
	#push registers
	push {r0}
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}

	#load x,y coord of the top-left corner of falling piece into r0,r1
	#(respectively)
	ldr r0, [r12, #0x40]
	ldr r1, [r12, #0x44]
	
	#load address of currently falling piece into r2
	#load start of rotations array
	add r2, r12, #0x80
	#load shape and rotation of falling piece into r3, r4 (respectively)
	ldr r3, [r12, #0x48]
	ldr r4, [r12, #0x4c]
	#number of rotations to move from array start= 4*shape + rotation
	mov r5, #4
	mla r5, r3, r5, r4
	#memory locations to move=64*rotations to move
	mov r6, #64
	mul r5, r6, r5
	#move to currently falling piece
	add r2, r2, r5
	
	#load address of first square to change in game board into r3
	#load address of gameboard into r3
	add r3, r12, #0x800
	#load number of squares to move into r4
	mov r4, #16
	mla r4, r1, r4, r0
	#load number of bytes to move into r4
	mov r5, #4
	mul r4, r5, r4
	#move to the square we want
	add r3, r3, r4
	
	
	
	
	mov r4, #0
	clear_loop_over_rows:
		
		mov r5, #0
		clear_loop_over_columns:
			#load colour of current square in falling piece into r6
			ldr r6, [r2]
			#sub colour of falling piece square from board square
			ldr r7, [r3]
			sub r7, r7, r6
			str r7, [r3]
			
			#move to next square in gameboard
			add r3, r3, #4
			#move to next square in falling piece
			add r2, r2, #4
			
		cmp r5, #3
		beq end_clear_loop_over_columns
		add r5, r5, #1
		b clear_loop_over_columns
		end_clear_loop_over_columns:
		
		#move to the next line of gameboard (need to skip some squares)
		#we need to move 12 squares (each is 4 bytes)
		add r3, r3, #48
		
	cmp r4, #3
	beq end_clear_loop_over_rows
	add r4, r4, #1
	b clear_loop_over_rows
	end_clear_loop_over_rows:
	


	#pop registers
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	pop {r0}
	
	#return
	mov pc, lr
	
#---------------End of clearing game board ------------------------------------


#---------------Updating game board--------------------------------------------

UpdateBoard:
	#push registers
	push {r0}
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}

	#load x,y coord of the top-left corner of falling piece into r0,r1
	#(respectively)
	ldr r0, [r12, #0x40]
	ldr r1, [r12, #0x44]
	
	#load address of currently falling piece into r2
	#load start of rotations array
	add r2, r12, #0x80
	#load shape and rotation of falling piece into r3, r4 (respectively)
	ldr r3, [r12, #0x48]
	ldr r4, [r12, #0x4c]
	#number of rotations to move from array start= 4*shape + rotation
	mov r5, #4
	mla r5, r3, r5, r4
	#memory locations to move=64*rotations to move
	mov r6, #64
	mul r5, r6, r5
	#move to currently falling piece
	add r2, r2, r5
	
	#load address of first square to change in game board into r3
	#load address of gameboard into r3
	add r3, r12, #0x800
	#load number of squares to move into r4
	mov r4, #16
	mla r4, r1, r4, r0
	#load number of bytes to move into r4
	mov r5, #4
	mul r4, r5, r4
	#move to the square we want
	add r3, r3, r4
	
	
	
	
	mov r4, #0
	update_loop_over_rows:
		
		mov r5, #0
		update_loop_over_columns:
			#load colour of current square in falling piece into r6
			ldr r6, [r2]
			#add colour of falling piece square to board square
			ldr r7, [r3]
			add r7, r7, r6
			str r7, [r3]
			
			#move to next square in gameboard
			add r3, r3, #4
			#move to next square in falling piece
			add r2, r2, #4
			
		cmp r5, #3
		beq end_update_loop_over_columns
		add r5, r5, #1
		b update_loop_over_columns
		end_update_loop_over_columns:
		
		#move to the next line of gameboard (need to skip some squares)
		#we need to move 12 squares (each is 4 bytes)
		add r3, r3, #48
		
	cmp r4, #3
	beq end_update_loop_over_rows
	add r4, r4, #1
	b update_loop_over_rows
	end_update_loop_over_rows:
	


	#pop registers
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	pop {r0}

	#return
	mov pc, lr

#---------------End of updating game board ------------------------------------

#---------------Testing if shape would fit-------------------------------------
# Returns 0 if collision would occur and 1 if it will not. Requires x,y coord of
# the top-left corner of tested next position of the falling piece
# (in 0x64, 0x68) and tested rotation of the falling piece in 0x6c

FitsShape:
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}

	#load x,y coord of the top-left corner of tested next position of
	#the falling piece into r0,r1 (respectively)
	ldr r0, [r12, #0x64]
	ldr r1, [r12, #0x68]
	
	#load address of currently being tested piece into r2
	#compute address of start of rotations array
	add r2, r12, #0x80
	#load shape of falling piece into r3
	ldr r3, [r12, #0x48]
	#load tested rotation of the falling piece into r4
	ldr r4, [r12, #0x6c]
	#number of rotations to move from array start= 4*shape + rotation
	mov r5, #4
	mla r5, r3, r5, r4
	#memory locations to move=64*rotations to move
	mov r6, #64
	mul r5, r6, r5
	#move to currently being tested piece
	add r2, r2, r5
	
	#load address of first square  of game board to check into r3
	#load address of gameboard into r3
	add r3, r12, #0x800
	#load number of squares to move into r4
	mov r4, #16
	mla r4, r1, r4, r0
	#load number of bytes to move into r4
	mov r5, #4
	mul r4, r5, r4
	#move to the square we want
	add r3, r3, r4
	
	
	
	
	mov r4, #0
	fits_loop_over_rows:

		mov r5, #0
		fits_loop_over_columns:

			#load colour of current square in falling piece into r6
			ldr r6, [r2]
			#empty square in falling piece means no collision
			cmp r6, #0
			beq if_no_collision
			#load colour of board square
			ldr r6, [r3]
			#now only if board square empty, then no collision
			cmp r6, #0
			beq if_no_collision
			#return 0 to signal collision
			mov r0, #0
			b return_from_fits

			if_no_collision:
				#move to next square in gameboard
				add r3, r3, #4
				#move to next square in falling piece
				add r2, r2, #4

		cmp r5, #3
		beq end_fits_loop_over_columns
		add r5, r5, #1
		b fits_loop_over_columns
		end_fits_loop_over_columns:
		
		#move to the next line of gameboard (need to skip some squares)
		#we need to move 12 squares (each is 4 bytes)
		add r3, r3, #48
		
	cmp r4, #3
	beq end_fits_loop_over_rows
	add r4, r4, #1
	b fits_loop_over_rows
	end_fits_loop_over_rows:



	#return 1 to signal no collision
	mov r0, #1

	return_from_fits:
		#pop registers
		pop {r6}
		pop {r5}
		pop {r4}
		pop {r3}
		pop {r2}
		pop {r1}

		mov pc, lr

#---------------End of testing if shape would fit -----------------------------

#---------------Generator of pseudo - random numbers---------------------------

RandomGenerator:

	push {r1}
	push {r2}

	generator_loop:
		#load previous value (x_n)
		ldr r0, [r12, #0x74]
		#generate new value
		#get a*x_n*x_n
		mov r1, #0xef00
		mul r2, r1, r0
		mul r1, r2, r0
		#add b*x_n (b=1 = a + 1 mod 4)
		add r1, r1, r0
		#add c,move result to r0, store it as "previous value"
		add r0, r1, #73
		str r0, [r12, #0x74]


		#take 3 bits from result to get value in range 0-7
		#(if 7 then repeat as our shapes are 0-6)
		mov r2, #0

		and r1, r0, #0x10
		mov r1, r1, lsr #4
		add r2, r2, r1

		and r1, r0, #0x1000
		mov r1, r1, lsr #11
		add r2, r2, r1

		and r1, r0, #0x400000
		mov r1, r1, lsr #20
		add r2, r2, r1

		mov r0, r2
	cmp r0, #7
	beq generator_loop

	pop {r2}
	pop {r1}

	#return
	mov pc, lr

#---------------End of the generator of pseudo - random numbers----------------

#---------------Getting next rotation------------------------------------------

GetNextRotation:
	#push registers
	push {r1}
	push {r2}

	#load current rotation
	ldr r2, [r12, #0x4c]


	#check if it is a special case of "last rotation"
	cmp r2, #0
	bne not_last_rotation

	mov r0, #3
	b return_from_get_rotation

	not_last_rotation:
	sub r0, r2, #1


	return_from_get_rotation:
	#pop registers
	pop {r2}
	pop {r1}

	mov pc, lr

#---------------End of getting next rotation-----------------------------------

#---------------Determination if the game is over------------------------------
# PRE:  the currently falling piece cannot fall any further (lower)
# POST: r0 = 1 - game can be continued, 0 - game is over

EndGame:
	push {r1}
	push {r2}
	push {r3}

		#add lines sent by opponent, if r0 holds 0, then game was lost
		push {lr}
		bl AddLines
		pop {lr}
		cmp r0, #0
		beq end_of_end_game
		
		# assume that the game can be continued
		mov r0, #1

		# set r1 to a pointer to the first element of the row above the
		# game board
		add r1, r12, #0x800
		add r1, r1, #12

		# loop checking whether any field in the row above gameboard
		# has a colour/is occupied
		# (possible if piece rotated and then instant collision),
		# r2 - iterator
		mov r2, #0
		end_game_check_first_row:
			# r3 stores the value (colour) of the currently analysed
			# field
			ldr r3, [r1]
			# check if the currently analysed field is occupied
			cmp r3, #0
			beq end_game_next_iter
			# if the currently analysed field is occupied then set
			# r0 to 0 and exit the subroutine
			mov r0, #0
			b end_of_end_game
			# if the currently analysed field is unoccupied (zero),
			# got to the next iteration
			end_game_next_iter:
				add r1, r1, #4
		add r2, r2, #1
		cmp r2, #10
		bne end_game_check_first_row

		# if the top row is unoccupied, check whether we can fit the
		# next piece to the starting position
		# set the tested position of the piece to the starting position
		mov r1, #6
		str r1, [r12, #0x64]
		mov r1, #0
		str r1, [r12, #0x68]
		# set current shape to the value of the next shape
		ldr r1, [r12, #0x50]
		str r1, [r12, #0x48]
		# set the tested rotation to 0
		mov r1, #0
		str r1, [r12, #0x6c]

		push {lr}
		bl FitsShape
		pop {lr}
		# according to the POST of FitsShape, r0=0 if collision occurs

	end_of_end_game:
		pop {r3}
		pop {r2}
		pop {r1}

		#return
		mov pc, lr

#---------------End of checking if the game has finished-----------------------

#---------------Deleting rows--------------------------------------------------
DeleteRows:
	# r1 holds the y parameter for DeleteOneRow
	# r3 holds currX which is initialised to current block's X
	# r4 holds currY which is initialised to current block's Y
	# r5 holds the offset from beginnning of gameboard to block being
	# processed
	# r6 holds the block at the location [gameboard_address + offset]

	push {r1}
	push {r3}
	push {r4}
	push {r5}
	push {r6}


	# x = 3
	mov r3, #3
	# y = 1
	mov r4, #1
	
	loop1:
        # while (y <= (last available row to user))
        ldr r5, [r12, #0x70]
	cmp r4, r5
	bgt endLoop1

		loop2:
		# while (x <= 12)
		cmp r3, #12
		bgt endLoop2

			# offset = 4 * (x + 16 * y)
			mov r5, r3
			add r5, r5, r4, lsl #4
			lsl r5, #2

			# hold gameboard address in r6
			add r6, r12, #0x800
			# then add offset to r6 to get the address of the block
			# to process.
			add r6, r6, r5

			# move the block to process into r6
			ldr r6, [r6]


			startIf:
				# if (block is empty), end loop 2, else continue
				cmp r6, #0
				bne endIf
				b endLoop2
			endIf:

		# x = x + 1
		add r3, r3, #1
		b loop2
		endLoop2:

		# if at the end of loop 2, x > 12, deleteRow
		cmp r3, #12
		ble notFull

		# use r1 as input register, to send DeleteOneRow the current
		# y value
		mov r1, r4
		str lr, [sp]
		sub sp, sp, #4
		bl DeleteOneRow
		add sp, sp, #4
		ldr lr, [sp]

		# increase send line counter
		ldr r3, [r12, #0x78]
		add r3, r3, #1
		str r3, [r12, #0x78]

		notFull:
			# x = 3, we need to go back to the first column
			mov r3, #3

	#increment y
	add r4, r4, #1
	b loop1

	endLoop1:
		pop {r6}
		pop {r5}
		pop {r4}
		pop {r3}
		pop {r1}

		mov pc, lr

DeleteOneRow:
	# r1 holds the number of row which is to be deleted
	# r3 holds x variable
	# r4 holds offset from start of gameboard to the block
	# r5 holds the gameboard address
	# r6 holds the constant, 0
	# r7 holds the address to the block at x,y
	# r8 holds the block at x,y

	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	push {r8}

	# r5 = gameboard_address (used in both loops)
	add r5, r12, #0x800

	# initialise x to 3
	mov r3, #3

	
	#for all rows above y, excluding sentinal rows, move them down.
	sub r1, r1, #1
	loopP_1:
        # while (y >= 1)
	cmp r1, #1
	blt endLoopP_1

		# r4 = offset = 4 * (x + 16 * y)
		mov r4, r3
		add r4, r4, r1, lsl #4
		lsl r4, #2

		# load r7 with gameboard_address + offset and r8 with the block
		# at that address
		# (r5 has board address)
		add r7, r4, r5
		ldr r8, [r7]

		# store the block one row below
		add r4, r4, #64
		add r7, r4, r5
		str r8, [r7]

		# increment x
		add r3, r3, #1

		# if x > 12, decrement y and set x to 3, re-enter loop
		ifP_1:
			cmp r3, #12
			ble endIfP

			mov r3, #3
			sub r1, r1, #1
		endIfP:

	b loopP_1
	
	endLoopP_1:


	# set x to 3, enter loop 2.
	mov r3, #3
	#clear the top row
	mov r1, #1
	loopP_2:
        # while (x <= 12)
	cmp r3, #12
	bgt endLoopP_2

		# r4 = offset = 4 * (x + 16 * y)
		mov r4, r3
		add r4, r4, r1, lsl #4
		lsl r4, #2
		
		# load 0 into [gameboard_address + offset] (r5 has board addres)
		mov r6, #0
		add r4, r4, r5
		str r6, [r4]

	# increment x
	add r3, r3, #1
	b loopP_2

	endLoopP_2:
		pop {r8}
		pop {r7}
		pop {r6}
		pop {r5}
		pop {r4}
		pop {r3}

		mov pc, lr

#---------------End of deleting rows-------------------------------------------

#---------------Adding lines---------------------------------------------------

AddLines:
	#push registers
	push {lr}
	push {r2}
	push {r3}

	#load number of lines to add to r2
	ldr r2, [r12, #0x7c]
	mov r3, #0
	str r3, [r12, #0x7c]
	
	
	loop_add_lines:
	cmp r2, #0
	beq end_loop_add_lines

		#check if line can be added
		bl TopRowEmpty
		cmp r0, #0
		beq end_add_lines

		bl MoveRowsUp

		bl FillBottomRow

		#update last available row to user
		ldr r3, [r12, #0x70]
		sub r3, r3, #1
		str r3, [r12, #0x70]

	sub r2, r2, #1
	b loop_add_lines
	end_loop_add_lines:


	#all lines were added correctly
	mov r0, #1

	end_add_lines:
		#pop registers
		pop {r3}
		pop {r2}
		pop {pc}


TopRowEmpty:
	#push registers
	push {r1}
	push {r2}
	push {r3}

	#assume that top row empty
	mov r0, #1
	
	# set r1 to a pointer to the first element of the top row
	add r1, r12, #0x800
	add r1, r1, #76
	
	mov r2, #0
	topRowEmpty_loop:
		# r3 stores the value (colour) of the currently analysed field
		ldr r3, [r1]
		# check if the currently analysed field is occupied
		cmp r3, #0
		beq topRowEmpty_next_iter
		# if the currently analysed field is occupied then set r0 to 0
		# and exit the subroutine
		mov r0, #0
		b end_of_topRowEmpty
                # if the currently analysed field is unoccupied (zero), got to
                # the next iteration
		topRowEmpty_next_iter:
			add r1, r1, #4
	add r2, r2, #1
	cmp r2, #10
	bne topRowEmpty_loop
	
	end_of_topRowEmpty:
		#pop registers
		pop {r3}
		pop {r2}
		pop {r1}

		mov pc, lr

MoveRowsUp:
	# r1 holds number of row currently being moved
	# r2 holds number of last available row to player
	# r3 holds x variable
	# r4 holds offset from start of gameboard to the block
	# r5 holds the gameboard address
	# r6 holds the constant, 0
	# r7 holds the address to the block at x,y
	# r8 holds the block at x,y

	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	push {r8}

	# r5 = gameboard_address
	add r5, r12, #0x800

	# initialise x to 3
	mov r3, #3

	# load number of last available row
	ldr r2, [r12, #0x70]

	#move all rows (excluding top row) up - start with y=2
	mov r1, #2
	moveRowsUp_loop:
        # while (y <= last available row)
	cmp r1, r2
	bgt end_moveRowsUp_loop

		# r4 = offset = 4 * (x + 16 * y)
		mov r4, r3
		add r4, r4, r1, lsl #4
		lsl r4, #2
		
		# load r7 with gameboard_address + offset and r8 with the
		# block at that address
		# (r5 has board address)
		add r7, r4, r5
		ldr r8, [r7]

		# store the block one row above
		sub r4, r4, #64
		add r7, r4, r5
		str r8, [r7]

		# increment x
		add r3, r3, #1

		# if x > 12, increment y and set x to 3, re-enter loop
		moveRowsUp_if:
			cmp r3, #12
			ble end_moveRowsUp_if

			mov r3, #3
			add r1, r1, #1
		end_moveRowsUp_if:

	b moveRowsUp_loop
	
	end_moveRowsUp_loop:

	pop {r8}
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}

	mov pc, lr

FillBottomRow:
	#push registers
	push {r1}
	push {r2}
	push {r3}

	# set r1 to a pointer to the first element of the last available row
	add r1, r12, #0x800
	ldr r2, [r12, #0x70]
	mov r3, #64
	mul r2, r3, r2
	add r2, r2, #12
	add r1, r1, r2

	#store blocked field number in r3
	mov r3, #8

	mov r2, #0
	fillBottomRow_loop:
		# block the field
		str r3, [r1]
		#go to next field
		add r1, r1, #4
	add r2, r2, #1
	cmp r2, #10
	bne fillBottomRow_loop
	end_fillBottomRow_loop:

	#pop registers
	pop {r3}
	pop {r2}
	pop {r1}

	mov pc, lr

#---------------End of adding lines--------------------------------------------

#---------------Functions for debugging----------------------------------------

InitLED:
	push {lr}
	push {r4}

	# initialise LED
	mov r4, #1
	lsl r4, #18

	# Set the GPIO function select
	bl GetGpioBase
	str r4, [r0, #4]

	pop {r4}
	pop {pc}

SwitchOnLED:
	push {lr}

	mov r0, #16
	bl SetPinLow

	pop {pc}

SwitchOffLED:
	push {lr}

	mov r0, #16
	bl SetPinHigh

	pop {pc}


#---------------End of functions for debugging---------------------------------
game_finnished_for_good:
