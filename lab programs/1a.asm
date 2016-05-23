;binary serach
.model small
.data
    array dw 1234h,3456h,5678h,7894h,8965h
    leng dw ($-array)/2
    schkey dw 1234h
    msg db 10,13,"key found at the position : $"
    result db 0
    msgf db 10,13,"Key not found $"

.code
    mov ax,@data
    mov ds,ax

    mov bx,1
    mov dx,leng
    mov cx,schkey

again:
    cmp bx,dx
    je failure
    mov ax,bx
    add ax,dx
    shr ax,1
    mov si,ax
    dec si
    add si,si
    cmp cx,array[si]
    jae bigger
    dec ax
    mov dx,ax
    jmp again

bigger:
    je sucess
    inc ax
    mov bx,ax
    jmp again

failure:
    lea dx,msgf
    mov ah,09h
    int 21h
    jmp exit

sucess:
    add al,'0'
    mov result,al
    lea dx,msg
    mov ah,09h
    int 21h
    mov dl,result
    mov ah,02h
    int 21h
    jmp exit

exit:
    mov ah,4ch
    int 21h
        
