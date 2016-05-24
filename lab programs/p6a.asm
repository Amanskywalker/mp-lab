.model small
scanf macro l
	mov ah,10
	lea dx,l
	int 21h
	endm

printf macro l
	mov ah,9
	lea dx,l
	int 21h
	endm

putchar macro l
	mov ah,2
	mov dl,l
	int 21h
	endm

.data
	m1 db 10,13,"First:$"
	m2 db 10,13,"second:$"
	equal db 10,13,"strings equal$"
	nequal db 10,13,"strings not  equal$"
	len1 db 10,13,"length1:$"
	len2 db 10,13,"length2:$"

	str1 db 10
	c1 db ?
	as1 db 10 dup(?)

	str2 db 10
	c2 db ?
	as2 db 10 dup(?)

.code
	mov ax,@data
	mov ds,ax
	mov es,ax

	printf m1
	scanf str1

	printf m2
	scanf str2

	mov al,c1
	cmp al,c2

	je l1

	printf nequal
	jmp l3



l1:
	lea si,as1
	lea di,as2
	cld
	mov cl,c1
	repe cmpsb

	je l2

	printf nequal

	jmp l3

l2:printf equal
l3:
	printf len1
	add c1,30h
	putchar c1

	printf len2
	add c2,30h
	putchar c2

	mov ah,4ch 
	int 21h


	end	