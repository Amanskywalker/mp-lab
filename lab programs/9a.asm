; time program
.model small
.data

    msg dw 10,13,"Current system time is : $"
    h db 00
    m db 00
    s db 00


.code
	mov ax,@data
	mov ds,ax

    mov ah,2ch
    int 21h

    mov h,ch
    mov m,cl
    mov s,dh

    mov dx,msg
    mov ah,09h
    int 21h

    mov al,h
    call disp

    mov dl,':'
    mov al,02h
    int 21h

    mov al,m
    call disp

    mov dl,':'
    mov al,02h
    int 21h

    mov al,s
    call disp

    mov ah,4ch
    int 21h

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
