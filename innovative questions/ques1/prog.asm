; program code

.model small
.data
  ipmsg db 10,13,"Enter your the review about the product :$"
  uip db 100h dup(?)  ;user input is stored in it

  ; defining the words for positive review
  g1 db "awesome"
  g2 db "good"
  g3 db "excellent"

  ; defining words for negative review
  b1 db "bad"
  b2 db "worst"

  ; counter to count the score
  gc db 00h
  bc db 00h

  ;size of user input

.code
  mov ax,@data
  mov ds,ax

  read uip n      ;macro to read from user

  
