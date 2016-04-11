; program code

.model small
.data
  ipmsg db 10,13,"Enter your the review about the product :$"
  uip db 100h dup(0)  ;user input is stored in it
  tstr db 100h dup(0)   ;temp string to hold the words for comparison

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
  n db 00h

  ; including the macros
  include read.mac
  include write.mac
  include strcmp.mac     ;macro for comparing the stings


.code
  mov ax,@data
  mov ds,ax
  mov es,ax       ; required for string comparison

  read uip n      ;macro to read from user

  ; process to read from user input string using space as delimiter
  ;and using strcmp to find wether give word matches or not and increment the appropriate counter
  ;at last printing the result    
