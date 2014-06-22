Tetris Duel
===========

Multiplayer Tetris for Raspberry Pi, written in bare metal ARM assembly.

Prerequisites
-----

1. Male - Male jumper wires x5
2. Female - Male jumper wires x5
3. 260 ohm resistors x3
4. NES controller x1
5. Raspberry Pi x1
6. Screen and HDMI cable x1
7. Breadboard x1
8. (Multiplayer) Female - Male jumper wires x6
8. (Multiplayer) 10k ohm resistors x6

Hardware Setup
-----

Connect your NES controller according the following diagram

| Pin Name | Pin No. |
|----------|---------|
| Power    | 1       |
| Latch    | 11      |
| Clock    | 12      |
| Data     | 13      |
| Ground   | 14      |

(Multiplayer) Connect a second Pi running the same kernel with the following GPIO pins

| P1 Pin Name | P1 Pin No. | P2 Pin No. | P2 Pin Name |
|-------------|------------|------------|-------------|
| Data in     | 15         | 16         | Data out    |
| Data out    | 16         | 15         | Data in     |
| Status in   | 18         | 22         | Status out  |
| Status out  | 22         | 18         | Status in   |
| Game in     | 21         | 23         | Game out    |
| Game out    | 23         | 21         | Game in     |

Software Setup
-----

1. Assemble the game with the provided assembler (or the official ARM assembler)

		./assemble tetris.s kernel.img

2. Replace kernel.img on your SD card with the generated kernel.img
3. (Optional) Repeat step 1-2 on second Pi for multiplayer gameplay
4. Press Start

Acknolwedgement
-----

This is a first year university project not intended for commercial use. The tile images were taken from Tetris Battle which also inspired our game logic.
