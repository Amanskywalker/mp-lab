; check wether given string is palindrome or not

.model small
.stack
.data
    str db 40 dup('$')
    rev db 40 dup('$')
    msg db 10,13,"Enter the string : $"
	  msgr db 10,13,"Reverse of the ginen string is:$"
	  pal db 10,13,"the string is palindrome $"
	  npal db 10,13,"the string is not palindrome $"

.code
	  mov ax,@data
	  mov ds,ax
	  mov es,ax

	  ; reading the string from keybaord

	  lea dx,msg
	  mov ah,09h
	  int 21h

	  xor cx,cx   ; as cx is default counter
	  lea si,str

read:
    mov ah,01h
    int 21h
    cmp al,0dh  ; comparing the entered character with \n
    je next     ; if true break the loop
    mov [si],al
    inc cx
    inc si
    jmp read

next:
    lea di,rev
    mov bp,cx   ; storing the cx value in bp

revstr:
    dec si
    mov al,[si]
    mov [di],al
    inc di
    loop revstr ; here the cx value is automatically decreased

    lea dx,msgr
    mov ah,09h
    int 21h
    lea dx,rev
    mov ah,09h
    int 21h

    lea si,str
    lea di,rev
    mov cx,bp
    repe cmpsb
    jnz fail
    lea dx,pal
    jmp exit

fail:
    lea dx,npal

exit:
    mov ah,09h
    int 21h
    mov ah,4ch
    int 21h

end
