; display the name at specified location

.model small
.data
    msg db 10,13,"what is your name? $"
    str db 10 dup('$')

.code
	mov ax,@data
	mov ds,ax


    lea dx,msg
    mov ah,09h
    int 21h

    xor cx,cx   ; as cx is default counter
    lea si,str
read:
    mov ah,01h
    int 21h
    cmp al,0dh
    je next
    mov [si],al
    inc si
    jmp read

next:
    mov [si],'$'

    mov dh,10
    mov dl,28
    mov ah,02h
    int 10h

    lea dx,str
    mov ah,09h
    int 21h
    mov ah,4ch
    int 21h

end
  
