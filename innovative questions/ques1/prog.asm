; program code

.model small
.data
  ;typedef
  ;defining few c word the feel like c language
  char typedef byte
  pchar typedef ptr byte    ; pointer to char


  ipmsg char 10,13,"Enter your the review about the product :$"
  uip char 100h dup(0)  ;user input is stored in it
  tstr char 100h dup(0)   ;temp string to hold the words for comparison

  ; defining the words for positive review
  g1 char "awesome"
  g2 char "good"
  g3 char "excellent"

  ; defining words for negative review
  b1 char "bad"
  b2 char "worst"

  ;number of words for positive and negative review
  gw db 00h
  bw db 00h

  ; counter to count the score
  gc db 00h
  bc db 00h

  ;size of user input
  n db 00h

  ; including the macros
  include read.mac
  include strcmp.mac     ;macro for comparing the stings


.code
  mov ax,@data
  mov ds,ax
  mov es,ax       ; required for string comparison

  read uip n      ;macro to read from user

lp1 :
  ; process to read from user input string using space as delimiter
  ;and using strcmp to find wether give word matches or not and increment the appropriate counter
  ;at last printing the result
