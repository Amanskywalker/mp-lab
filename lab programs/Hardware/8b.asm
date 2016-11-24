.MODEL SMALL
INITDS MACRO
 MOV AX,@DATA ;Initialization of data segment
 MOV DS,AX (to access data)
ENDM

INIT8255 MACRO
 MOV AL,CW ;Initialization of 8255 using control word
 MOV DX,CR by passing 82h to control reg.
 OUT DX,AL (to make port A as output)
ENDM

OUTPA MACRO ; one is enough
 MOV DX,PA
 OUT DX,AL
ENDM

EXIT MACRO
 MOV AH,4CH ;Terminating the program
 INT 21H
ENDM

.DATA
 PA EQU 1190H ; one is enough
 CR EQU 1193H
 CW DB 82H
.CODE
 INITDS
 INIT8255
 MOV AL,88H ; setting value in Al 88=10001000
 MOV CX,200 ; taking count as 200

ROTATE: OUTPA ; perform rotation on port A
 CALL DELAY ; have some delay in between the steps.
 ROR AL,01 ;CLOCKWISE DIRECTION- rotate right contents of AL i.e.
 DEC CX 10001000 is rotated towards right by 1 bit. This
 JNZ ROTATE makes the stepper motor to rotate clock wise direction.
 This loop repeats until step size becomes 00
 EXIT ; once the count becomes 0, call exit macro
DELAY PROC
 PUSH AX ; save AX as we change in next lines
 PUSH CX ; save CX as we change in next lines
 MOV AX,0CFFH ; speed of the stepper motor can be controlled by
OUTER: MOV CX,0FFFFH changing count value
INNER: DEC CX
 JNZ INNER
 DEC AX
 JNZ OUTER
 POP CX
 POP AX
 RET
DELAY ENDP
END 
