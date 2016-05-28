; ncr program

.model small
.stack
.data
    n dw 5
    r dw 3
    ncr dw 0

.code
	mov ax,@data
	mov ds,ax

    mov ax,n
    mov bx,r
    call ncrpro

    mov ax,ncr
    call convdisp

    mov ah,4ch
    int 21h


ncrpro proc
    cmp bx,ax
    je r1
    cmp bx,0
    je r1
    cmp bx,1
    je rn
    dec ax
    cmp bx,ax
    je r2
    push ax
    push bx
    call ncrpro
    pop bx
    pop ax
    dec bx
    push ax
    push bx
    call ncrpro
    pop bx
    pop ax
    ret

r1: inc ncr
    ret
r2: inc ncr
rn: add ncr,ax
    ret

ncrpro endp

; here goes the procedure to display the the optput
convdisp proc

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

convdisp endp


    end
