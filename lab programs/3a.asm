; bubble sort

; logic in c or c++ program
;  n is the size of array

; for(int i=n;i<0;i--)
;   for(int j=0;j<n;++j)
;	    if (a[i]>a[j])
;		    SWAP(a[i],a[j]);

; this program uses array a (as a in above logic) to hold the some random number to perform sorting on.
; lng to hold the length of the array (as n in above logic ) (i.e number of elements)

.model small
.data
    org 0000h                           ; for easy debugging
    a db 05h, 01h, 08h, 07h, 09h, 03h   ; array on which sorting to be done
    lng equ 06h                         ; lng variable to hold the length of array


.code
	mov ax,@data                          ; accessing the data segment
	mov ds,ax
    mov dx,lng-1                        ; copying lng into register dx which act as number of passes in the program

outter:                                 ; outter loop (i loop)
    mov cx,dx
    mov si,offset a                     ; si acting as i here

inner:                                  ; inner loop (j loop)
    mov al,[si]                         ; moving element pointing by si into al as [si] and [si+1] can't be compared
    cmp al,[si+1]                       ; comparing al,[si+1] aka [si],[si+1]
    jbe nochange                        ; jbe(al > [si+1]) for ascending order jae(al < [si+1]) for descinding order
    ;if true
    xchg [si+1],al
    mov [si],al
    ;endif

nochange:
    inc si
    loop inner                          ; loop to inner
    dec dx                              ; decrement the count
    jnz outter                          ; jump to outter loop

    mov ah,4ch
    int 21h

end

;By
;Aman
