.model small
printf macro msg
	lea dx,msg
	mov ah,9
	int 21h
endm printf

.data
	askrow db 10,13,"enter row:$"
	askcol db 10,13,"enter col:$"
	see db 10,13,"press any key to quit$"
	row db ?
	col db ?
.code
	mov ax,@data
	mov ds,ax

	printf askrow
	call read
	mov row,al
	printf askcol
	call read
	mov col,al
	
	mov ah,0fh
	int 10h
	mov ah,00h
	int 10h

	printf see



	mov dh,row
	mov dl,col
	mov bx,00
	mov ah,2
	int 10h

	mov ah,1
	int 21h
	mov ah,4ch
	int 21h

read proc
	mov ah,1
	int 21h
	and al,0fh
	mov bl,al
	mov ah,1
	int 21h
	and al,0fh
	mov ah,bl
	aad
	ret
	read endp

end