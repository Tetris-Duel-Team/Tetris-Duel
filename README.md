Tetris Duel
===========
Video with the game demo:

Multiplayer Tetris for Raspberry Pi, written in bare metal ARM assembly.
Can be assembled with our own assembler coded in C (binary provided), as we aimed for 100% only our code.
Completed in 2 weeks as an extension of an Imperial College London first year project.
* 4000 lines of ARM Assembly
* Driver for the NES controllers
* Networking between Pis using custom protocol
* Own assembler (no linking)



Remark - all code now available in tetris.s (not tetrisToProcess.s as stated in Report - we removed our custom prepocessor for ease of use)

Team
-----
Piotr Chabierski:	Github - [@piotrchabierski](https://github.com/piotrchabierski)

Han Qiao: 		Github - [@sweatybridge](https://github.com/sweatybridge)

Michał Sienkiewicz:	GitHub - [@michsien](https://github.com/michsien)

Utsav Tiwary:		GitHub - [@utsavtiwary](https://github.com/utsavtiwary)

Prerequisites
-----

1. Male - Male jumper wires x5
2. Female - Male jumper wires x5
3. 260 ohm resistors x3
5. Breadboard x1
4. NES controller x1
6. Raspberry Pi, SD card, power cable x1
7. Screen and HDMI cable x1
8. (Multiplayer) Female - Male jumper wires x14
8. (Multiplayer) 10k ohm resistors x6
8. (Multiplayer) Breadboard x1
8. (Multiplayer) 1 - 7 for the second user 

Software Setup
-----

1. Assemble the game with the provided assembler (or the official ARM assembler)

		./assemble tetris.s kernel.img

2. Replace kernel.img on your SD card with the generated kernel.img
3. (Optional) Repeat step 1-2 on second Pi for multiplayer gameplay
4. Press Start

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

Latch, Clock, Data should not be directly connected - use 260 ohm resistors as visible here:

![NES controller](setup_images/NES\ controller.jpg)

(Multiplayer) Connect a second Pi running the same kernel with the following GPIO pins

| P1 Pin Name | P1 Pin No. | P2 Pin No. | P2 Pin Name |
|-------------|------------|------------|-------------|
| Data in     | 15         | 16         | Data out    |
| Data out    | 16         | 15         | Data in     |
| Status in   | 18         | 22         | Status out  |
| Status out  | 22         | 18         | Status in   |
| Game in     | 21         | 23         | Game out    |
| Game out    | 23         | 21         | Game in     |

Also, remember about connecting grounds of the two Pis to each other

All the pins should not be directly connected (except ground pins) - use 10k ohm resistors as visible here:

![Networking](setup_images/Networking\ and\ controllers.jpg)

Acknowledgement
-----

This is a first year university project not intended for commercial use. The tile images were taken from Tetris Battle, which also inspired our game logic.
