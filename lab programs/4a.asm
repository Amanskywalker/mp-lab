;Read an Alphanumeric character and display its equivalent ASCII code
.model small
.data
    msg db 10,13,"Enter any character: $"
    key db 00h
    tmp1 db 00h
    tmp2 db 00h

.code
	mov ax,@data
	mov ds,ax

    mov ah,0fh  ; to get current video mode
    int 10h
    mov ah,00h  ; to clear the screen
    int 10h
    lea dx,msg  ; to display message
    mov ah,09h
    int 21h

    mov ah,01h  ; reads the charecter
    int 21h     ; al holds the character

    mov ah,02h  ; clearing screen for better view
    mov dh,15
    mov dl,40
    int 10h

    mov key,al

    xor ax,ax
    mov cl,10h
    mov al,key
    div cl
    add ax,3030h
    mov dh,ah
    mov dl,al
    mov ah,02h
    int 21h
    mov dl,dh
    mov ah,02h
    int 21h


    mov ah,01h  ; waiting for any key to press to exit
    int 21h

    mov ah,0fh
    int 10h
    mov ah,00h
    int 10h

    mov ah,4ch
    int 21h

disp proc
    mov dl,al
    cmp dl,09h
    jle addrec
    sub dl,0ah
    add dl,41h
    jmp prntno

addrec:
    add dl,30h

prntno:
    mov ah,02h
    int 21h
    ret
disp endp

end

;By-
; Aman
