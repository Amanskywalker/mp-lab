.MODEL SMALL
INITDS MACRO
 MOV AX,@DATA ;initialization of data segment
 MOV DS,AX ;(to access data)
ENDM
INIT8255 MACRO
 MOV AL,CW ;initialization of 8255 using control word
 MOV DX,CR ; by passing 90h to control reg.
 OUT DX,AL ; (to make port A as input & port C as output)
ENDM
OUTPC MACRO
 MOV DX,PC
 OUT DX,AL
ENDM
INPA MACRO
 MOV DX,PA
 IN AL,DX
ENDM
PRINTF MACRO MSG
 MOV AH,9
 LEA DX,MSG
 INT 21H
ENDM
EXIT MACRO
 MOV AH,4CH ;terminating the program
 INT 21H
ENDM

.DATA
 DISPLAYABLECHARACTER DB '0123456789.+-*/%CEK=MRSA'
 KEYPRESSEDMSG DB 'KEY PRESSED IS : ' ; no $ here
 KEY DB ? ,10,13,'$'
 ROWMSG DB 'THE ROW NO IS : ' ; no $ here
 ROW DB ? ,10,13,'$'
 COLMSG DB 'THE COLUMN NO IS : ' ; no $ here
 COL DB ? ,'$'
 CR EQU 01193H
 PC EQU 01192H
 PA EQU 01190H
 CW DB 90H

.CODE
 INITDS
 INIT8255
REPEAT: ; ACTIVATING/EXCITING 1
st COL
 MOV AL,01H ; 01(0001) for first col
 OUTPC ;checks if key is pressed in first col
 INPA ;reads the pressed input key in port A & stores it in AL
 CMP AL ,00 ;if key is not pressed, AL will be 00 in this 1 st column.
JNZ FIRSTCOL ;if key is pressed in this 1st col, then goto FIRSTCOL, else goto next line
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ; ACTIVATING/EXCITING 2nd COL
 MOV AL,02H ; 02(0010) for second col
 OUTPC ;checks if key is pressed in second col
 INPA ;reads the pressed input key in port A & stores it in AL
 CMP AL ,00 ;if key is not pressed, AL will be 00 in this 2nd column.
 JNZ SECONDCOL ;if key is pressed in this 2nd col, then goto SECONDCOL, else goto next line
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ; ACTIVATING/EXCITING 3rd COL
 MOV AL,04 ; 04(0100) for third col
 OUTPC ;checks if key is pressed in third col
 INPA ;reads the pressed input key in port A & stores it in AL
 CMP AL ,00 ;if key is not pressed AL will be 00 in this 3rd column.
 JNZ THIRDCOL ;if key is pressed in this 3rd col, then goto THIRDCOL, else goto next line
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 JMP REPEAT ; well, if you don’t press any key, then repeat the entire task
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FIRSTCOL: LEA SI,DISPLAYABLECHARACTER ;SI points to displayablecharacter array
 MOV COL,31H ;control has come here means, the key that we have pressed happens to be in first column
 MOV CL,30H ;0th row in first col
NEXT1: ; to find the corresponding row in first col.
 INC CL ; increment the value of CL to make first row in first col.
 SHR AL,01 ; shift right AL by 1 bit
 JC DISPLAY ;carry flag (CF) is set when 1 is moved to carry flag from AL
 INC SI ;else inc SI and repeat till 1 (carry - CF) is found
 JMP NEXT1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SECONDCOL: LEA SI,DISPLAYABLECHARACTER ;SI points to displayablecharacter array
 ADD SI,08 ; adding 8 to SI to make SI point to second column
 MOV COL,32H ; control has come here means, the key that we have pressed happens to be in second column
 MOV CL,30H ;0th row in second col

NEXT2: ; to find the corresponding row in second col.
 INC CL ; increment the value of CL to make first row in second col.
 SHR AL,01 ; shift right AL by 1 bit
 JC DISPLAY ; carry flag (CF) is set when 1 is moved to carry flag from AL
 INC SI ; else inc SI and repeat till 1 (carry - CF) is found
 JMP NEXT2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
THIRDCOL: LEA SI,DISPLAYABLECHARACTER ;SI points to displayablecharacter array
 ADD SI,16 ;adding 16 to SI to make SI point to third column
 MOV COL,33H ; control has come here means, the key that we have pressed happens to be in third column
 MOV CL,30H ; 0th row in third col
NEXT3: ; to find the corresponding row in third col.
 INC CL ; increment the value of CL to make first row in third col.
 SHR AL,01 ; shift right AL by 1 bit
 JC DISPLAY ; carry flag (CF) is set when 1 is moved to carry flag from AL
 INC SI ; else inc SI and repeat till 1 (carry - CF) is found
 JMP NEXT3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISPLAY:
 MOV DL,[SI] ;SI points to whatever key that we have pressed
 MOV KEY,DL ; pressed key is moved to the variable called key
 PRINTF KEYPRESSEDMSG ;keypressedmsg is displayed along with key pressed

 MOV ROW,CL ;to display row msg with its number
 PRINTF ROWMSG
 PRINTF COLMSG ;to display col msg with its number
 EXIT
END
