---
title: Mainframe Setup
date: 2018-03-11 20:36:50
tags: mainframe
---

s
a
## Installing the Mainframe Emulator

I have created a Docker image that starts up a Hercules 3270 emulator and a terminal session. Please note that the purpose of putting this in a Docker container was NOT for production K8s purposes, but as a nice way of getting the emulating running with a single command on any of my machines (inc. Raspberry Pi).

That command is...

```
docker run -it seanchickenninja/mainframe
```

## Moving around the Mainframe

## Setting up a user

<script src="https://asciinema.org/a/I1QGU8BPtZb3R3t7HXJy7HzCi.js" id="asciicast-I1QGU8BPtZb3R3t7HXJy7HzCi" async></script>

## Hello world in COBOL

JCL

```
//COB001	JOB (001), 'COB HELLO WORLD',
//				CLASS=A,MSGCLASS=A,MSGLEVEL(1,1)
//HLLOWRLD	EXEC COBUCLG,REGION=1024K
//COB.SYSIN		DD DSNAME=SEAN.HELLO.COBOL(COB001),DISP=SHR
//LKED.SYSLIB	DD DSNAME=SYS1.COBLIB,DISP=SHR
//				DD DSNAME=SYS1.LINKLIB,DISP=SHR
//GO.SYSPRINT	DD SYSOUT=A
```

COBOL

```
001000 IDENTIFICATION DIVISION.
002000 PROGRAM-ID. 'HELLO'.
003000 ENVIRONMENT DIVISION.
004000 CONFIGURATION SECTION.
005000 SOURCE-COMPUTER. IBM-360.
006000 OBJECT-COMPUTER. IBM-360.
007000 SPECIAL-NAMES.
008000		CONSOLE IS CNSL.
009000 DATA DIVISION.
010000 WORKING-STORAGE SECTION.
011000 77	HELLO-CONST	PIC X(12) VALUE 'HELLO WORLD'.
012000 PROCEDURE DIVISION.
013000 000-DISPLAY.
014000		DISPLAY HELLO-CONST UPON CNSL.
015000		STOP RUN.
```

