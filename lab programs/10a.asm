; decimal up counter
.model small
.stack
.data
    temp dw 00
.code
	mov ax,@data
	mov ds,ax

    mov cx,0063d
    mov ax,0000h
lp3:mov temp,ax
    mov ah,0fh      ; clearing the screen every time
    int 10h
    mov ah,00h
    int 10h

    mov ax,temp
    call disp
    call delay
    mov ax,temp
    inc ax
    loop lp3

    mov ah,4ch
    int 21h


delay proc
    push dx
    mov dx,0000fh
up2:dec dx
    jnz up2
    pop dx
    ret

disp proc

  aam
	add ax,3030h
	mov bx,ax
	mov dl,ah
	mov ah,02h
	int 21h
	mov dl,bl
	mov ah,02h
	int 21h
	ret

disp endp

    end
