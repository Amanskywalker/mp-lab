INITDS MACRO
 MOV AX,@DATA ;Initialization of data segment
 MOV DS,AX ;(to access data)
 ENDM
INIT8255 MACRO
 MOV AL,CW ;Initialization of 8255 using control word
 MOV DX,CR ; by passing 82h to control reg.
 OUT DX,AL ;(to make port A as output)
ENDM

OUTPA MACRO ; one is enough
 MOV DX,PA
 OUT DX,AL
ENDM

EXIT MACRO
 MOV AH,4CH ;Terminating the program
 INT 21H
ENDM

.MODEL SMALL
.STACK
.DATA
 PA EQU 1190H ;one is enough
 CR EQU 1193H
 CW DB 82H
 TABLE DB 80H,96H,0ABH,0C0H,0D2H,0E2H,0EEH,0F8H,0FEH,0FFH ;+ve 1st half
 DB 0FEH,0F8H,0EEH,0E2H,0D2H,0C0H,0ABH,96H,80H ;+ve 2nd half
 DB 96H,0ABH,0C0H,0D2H,0E2H,0EEH,0F8H,0FEH,0FFH ;+ve 1st half
 DB 0FEH,0F8H,0EEH,0E2H,0D2H,0C0H,0ABH,96H,80H ;+ve 2nd half
 MSG DB 10,13,"PRESS ANY KEY TO EXIT $"

.CODE
 INITDS
 INIT8255
 LEA DX,MSG
 MOV AH,9
 INT 21H ; or MOV CX,25H
START: MOV CX,37 ;count value is taken 37 bcz the table contains 37 values
 LEA SI,TABLE ; table address is loaded to SI
BACK: MOV AL,[SI] ; the contents of SI is moved to AL i.e. single value of table is moved
 OUTPA ;moved value is sent to hardware module through PORT A
 CALL DELAY
 INC SI ; SI is pointed to the next value of table
 LOOP BACK ; loop repeats until all the contents of table is moved (till CX becomes 0)
 MOV AH,1
 INT 16H ; checks if any key is pressed in keyboard. If you
 JZ START haven’t, then go to START
 EXIT ; if you press any key, just call exit macro
DELAY PROC
 MOV BX,0FFFH ; NOTE: single loop delay is enough
L2: DEC BX
 JNZ L2
 RET
DELAY ENDP
END 
