;stings program

.model small
.data
    s1in db 10,13,"input string 1: $"
    s2in db 10,13,"input string 2: $"
    l1 db 10,13,"Length of string 1: $"
    l2 db 10,13,"Lenght of string 2: $"
    seq db 10,13,"strings are equal $"
    sneq db 10,13,"strings are not equal $"

    str1 db 50 dup('$')
    str2 db 50 dup('$')

    ls1 db 0
    ls2 db 2

.code
	mov ax,@data
	mov ds,ax
	mov es,ax

	lea dx,s1in
	mov ah,09h
	int 21h
	lea si,str1
	call read       ;reading string 1
	mov ls1,bl
	lea dx,s2in
	mov ah,09h
	int 21h
	lea si,str2
	call read       ;reading string 2
	mov ls2,bl

	;displaying the length of the strings
	lea dx,l1
	mov ah,09h
	int 21h
	xor ax,ax
	mov al,ls1
	call disp
	lea dx,l2
	mov ah,09h
	int 21h
	xor ax,ax
	mov al,ls2
	call disp

	; checking wether both string are same or not
	mov al,ls1
	mov bl,ls2
	cmp al,bl
	je equal
	lea dx,sneq
	mov ah,09h
	int 21h
	jmp stop

equal:
    lea dx,seq
    mov ah,09h
    int 21h

stop:
    mov ah,4ch
    int 21h

	; procedures

read proc
    mov bl,00h
again:
    mov ah,01h
 	int 21h
	cmp al,0dh
	je stopr
	mov [si],al
	inc si
	inc bl
	jmp again

stopr:
    ret
read endp

disp proc
    mov cl,10h
    div cl
    add ax,3030h
    mov bx,ax
    mov dl,bl
    mov ah,02h
    int 21h
    mov dl,bh
    mov ah,02h
    int 21h
    ret

disp endp

end
