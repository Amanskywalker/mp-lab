; program code

.model small
.data
  ;typedef
  ;defining few c word to feel like c language
  byte typedef db
  char typedef byte
  pchar typedef ptr char    ; pointer to char


  ipmsg char 10,13,"Enter your the review about the product :$"
  rop char 10,13,"User review is :$"
  uip char 100h dup(0)  ;user input is stored in it
  tstr char 100h dup(0)   ;temp string to hold the words for comparison

  ; defining the words for positive review
  g1 char "awesome"
  g2 char "good"
  g3 char "excellent"

  ; defining words for negative review
  b1 char "bad"
  b2 char "worst"

  ;pointer to the arrays
  gptr pchar g1,g2,g3
  bptr pchar b1,b2

  ;number of words for positive and negative review
  gw db 03h
  bw db 02h

  ; counter to count the score
  gc db 00h
  bc db 00h

  ;size of user input
  n db 00h

  ;some temp vars to store temp values all of integer types (alternate stack can be used)
  t1 db 00h
  t2 db 00h

  ; including the macros
  include read.mac
  include strcmp.mac     ;macro for comparing the stings


.code
  mov ax,@data
  mov ds,ax
  mov es,ax       ; required for string comparison

  read uip n      ;macro to read from user

  mov si,00h

; process to read from user input string using space as delimiter

lp1:
    cmp uip[si],20h
    je compare
    mov ax,uip[si]
    mov tstr[si],ax
    mov ax,n
    cmp si,ax
    je exit
clp:
    inc si
    jmp lp1

bclp:
    mov si,t1
    jmp clp

;using strcmp to find wether give word matches or not and increment the appropriate counter

compare:
    mov ax,t1
    dec ax
    mov t1,si
    sub ax,si
    mov si,00h

cpg:
    strcmp tstr gptr[si] ax t2
    mov ax,t2
    cmp ax,00h    ; if result is true
    je loc1
    mov ax,gw
    cmp si,gw
    je bclp
    inc si
    jmp cpg

cpb:
    strcmp tstr bptr[si] ax t2
    mov ax,t2
    cmp ax,00h    ; if result is true
    je loc2
    mov ax,bw
    cmp si,bw
    je bclp
    inc si
    jmp cpb

loc1:
    inc gc
    jmp bclp

loc2:
    inc bc
    jmp bclp

;at last printing the result

stop:
    mov ax,gc
    mov bx,bc
    sub ax,bx
    lea dx,rop
    mov ah,09h
    int 21h
    mov dx,ax
    mov ah,09h
    int 21h

    mov ah,4ch
    int 21h

end
; end of program
