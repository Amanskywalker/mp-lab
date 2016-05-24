.model small

printf macro msg
	lea dx,msg
	mov ah,9
	int 21h
	endm printf

.data
	ask db 10,13,"enter string:$"	
	original db 50 dup("$")
	reverse db 50 dup("$")
	pal db 10,13,"its palindrome$"
	npal db 10,13,"not palindrome$"

.code
	mov ax,@data
	mov ds,ax
	mov es,ax

	
	mov cx,0
	lea si,original
	lea di,reverse
	printf ask

back:mov ah,1
	int 21h
	cmp al,13
	je done
	mov [si],al
	inc si
	inc cx
	jmp back


done:
		dec si
		mov bp,cx


copy:
		mov al,[si]
		mov [di],al
		dec si
		inc di
		loop copy


lea si,original
lea di,reverse

cld
mov cx,bp
repe cmpsb
je pali
printf npal
jmp exit

pali:
		printf pal

exit:	
		mov ah,4ch
		int 21h

		end

















