# Tetris Duel

A multiplayer Tetris game written in bare metal assembly for Raspberry Pi. This project is completed in 3 weeks as an extension to Imperial College London's first year computing project.

Our source code features,

* 4000 lines of documented ARM assembly code
* Optimized driver for a NES controller connected via GPIO
* Asynchronous networking for two Pis connected via GPIO
* Doubly buffered rendering logic for HDMI output

Watch our game demo here:

# Setup Guide
## Prerequisites
### Single Player

1. Male - Male jumper wires x5
2. Female - Male jumper wires x5
3. 260 ohm resistors x3
5. Breadboard x1
4. NES controller x1
6. Raspberry Pi, SD card, power cable x1
7. Screen and HDMI cable x1

### Multiplayer

1. Single player prerequisites x2
8. Female - Male jumper wires x14
8. 10k ohm resistors x6
8. Breadboard x1

## Software Setup

1. Format your SD card with [Raspbian OS](http://www.raspberrypi.org/downloads/) following the [image installation guide](http://www.raspberrypi.org/documentation/installation/installing-images/README.md)
1. Assemble the game with the provided assembler (or the [official ARM assembler](https://launchpad.net/gcc-arm-embedded))

		./assemble tetris.s kernel.img

2. Copy the generated `kernel.img` to your SD card, replacing existing file
3. (Optional) Repeat step 1-3 on second Pi for multiplayer gameplay
4. Follow the Hardware Setup Guide

## Hardware Setup
### NES Controller

Connect your NES controller to the GPIO pins as shown in the following table.

	          +----> Power  (white)
	          |
	5 +---------+  7    
	  | x  x  o   \     
	  | o  o  o  o |    
	4 +------------+ 1  
	    |  |  |  |
	    |  |  |  +-> Ground (brown)
	    |  |  +----> Clock  (red)
	    |  +-------> Latch  (orange)
	    +----------> Data   (yellow)

| NES Controller Pin | GPIO Pin |
|--------------------|----------|
| Power              | 1        |
| Latch              | 11       |
| Clock              | 12       |
| Data               | 13       |
| Ground             | 14       |

**Note:** latch, clock, and data pins should be connected using 260 ohm resistors as shown in our demo setup:

![NES controller](doc/NES\ controller.jpg)

### Networking (Multiplayer)

Connect a second Pi running the same kernel using the following GPIO pins.

| P1 Pin Name | P1 Pin No. | P2 Pin No. | P2 Pin Name |
|-------------|------------|------------|-------------|
| Data in     | 15         | 16         | Data out    |
| Data out    | 16         | 15         | Data in     |
| Status in   | 18         | 22         | Status out  |
| Status out  | 22         | 18         | Status in   |
| Game in     | 21         | 23         | Game out    |
| Game out    | 23         | 21         | Game in     |
| Ground      | 20         | 20         | Ground      |

**Note:** All pins (except ground) should be connected using 10k ohm resistors as shown in our demo setup:

![Networking](doc/Networking\ and\ controllers.jpg)

# FAQ

1. Where is tetrisToProcess.s?

  We have removed our custom preprocessor (as described in our final report) from github release for a cleaner repository. tetris.s contains all code in tetrisToProcess.s with only variable names replaced by actual values.

# Team

* Han Qiao
  * Github - [@sweatybridge](https://github.com/sweatybridge)
* Piotr Chabierski
  * Github - [@piotrchabierski](https://github.com/piotrchabierski)
* Michał Sienkiewicz
  * GitHub - [@michsien](https://github.com/michsien)
* Utsav Tiwary
  * GitHub - [@utsavtiwary](https://github.com/utsavtiwary)

# Acknowledgement

This is a university project intended for educational purposes and not for commercial use. The tile images were taken from Tetris Battle, which also inspired our game logic.
