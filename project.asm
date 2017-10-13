
;             Program to repeat a string.
; Input: User enters a string, up to 30 characters
; Output: We store the string in memory and display it
;

.ORIG x3000 ;Add a line here to start your program at address x3000

;***************************************
;Part I: Initialize
;***************************************
;We allocated memory for the string already.
second LEA r1,  str1       ; addr of array to store string
             ;Why are we using LEA here and not LD or LDI? we need to load the adress of the string not its value

             AND r3, r3, #0    ; to store the size of the string/array
             AND r2, r2, #0
             ;Prompt user to enter the string
             LEA r0, prompt1
             ;PUTS  writes a string of ASCII characters to the console display
             ;from the address specified in R0.
             ;Writing terminates with the occurrence of x0000
             PUTS

             ;***************************************
             ;Part II: Read / Store the string
             ;***************************************
             ;
             ; Start reading characters
             ;
;GETC is same as TRAP x20: Reads a char and stores its ASCII code in R0 loop GETC
; Read a character.
;ASCII for newline/carriage return is LF and it is stored at #10
loop      GETC ;check if new char is carage return
             ADD r5,r0,#-10
             BRZ done
             out                                    ; echo character
             STR r0, r1, #0
             ADD r1, r1, #1                  ; advance ptr to array
             ADD r3, r3, #1  ;Add a line here to increment size of the array
             LD  r6, EOL
             ADD r4, r3, r6                 ; check if we reached max length
             BRNZ loop

             ;***************************************
             ;Part III: Display the string
             ;***************************************
done     AND r0, r0, #0 ;Add a line here to append NULL at the end of string
                                          ;Keep the label done. What is the ASCII char for NULL? 0000
                                          ;Why are we adding NULL to the end of our string?
             ADD r0, r0, #10 ;Add a line here to add a carriage return to your string/array
             out


             AND R4, R4, #0
shrink  ADD R5, R3, -4
             BRz k
             ADD R5, R3, -3
             BRz c
             ADD R5, R3, -2
             BRz t
             ADD R5, R3, -1
             BRz o

k            LEA R5, str1
             LDR R0, R5, x0
             LD R2, NEGASCII
             ADD R0, R0, R2
             AND R1, R1, #0
             LD R1, THOUSAND
             JSR multiply
             ADD R4, R2, R4
             ADD R5, R5, #1
             BR c2

c             LEA R5, str1
c2          LDR R0, R5, x0
             LD R2, NEGASCII
             ADD R0, R0, R2
             AND R1, R1, #0
             LD R1, H
             JSR multiply
             ADD R4, R2, R4
             ADD R5, R5, #1
             BR t2

t             LEA R5, str1
t2           LDR R0, R5, x0
             LD R2, NEGASCII
             ADD R0, R0, R2
             AND R1, R1, #0
             ADD R1, R1, #10
             JSR multiply
             ADD R4, R2, R4
             ADD R5, R5, #1
             BR o2

o            LEA R5, str1
o2          LDR R0, R5, x0
             LD R2, NEGASCII
             ADD R0, R0, R2
             AND R1, R1, #0
             ADD R1, R1, #1
             JSR multiply
             ADD R4, R2, R4
             LD R1, PASS
             ADD R1, R1, #1
             BRz stnum1
             BRp stnum2

stnum1 ST R1, PASS
             ST R4, num1
             LD R0, ENDL
             OUT
             BR second

stnum2 ST R4, num2


             ;GETC
             AND R2, R2, 0
             LEA R0, WHATOP
             PUTS
             GETC
             OUT
             ADD R4, R0, #0
             LD R0, num1
             LD R1, num2
             LD R3, ADDS
             ADD R2, R2, 0
             BRnp output
             ADD r5,r4,R3
             BRZ addition
             LD R3, SUBS
             ADD R5, R4, R3
             BRZ subtract
             LD R3, MULTIS
             ADD r5,r4,R3
             BRZ multiply
             LD R3, DEVS
             ADD r5,r4,R3
             BRZ divide


output AND R0, R0, 0
             ADD R0, R0, xA
             out
             lea R0, outp
             puts

             HALT
;in R0, R1
;out R2
addition AND R2, R2, 0
             ADD R2, R0, R1
        RET;

;in r0,r1
;out r2
subtract AND R2,R2,0
             NOT R1, R1
             ADD R1, R1, #1
             ADD R2, R0, R1
             RET;

;in R0, R1
;out R2 (dividend), R3 (remainder)
divide AND R2, R2,0
             AND R3, R3, 0
      ADD R1, R1, 0
             BRZ RZERO
             NOT R1,R1
             ADD R1, R1, #1
devloop ADD R2, R2, #1
             ADD R0, R0, R1
             BRp devloop
             ADD R3, R0, #0
             RET;


         kdiv            LEA R5, str1
                         LDR R0, R5, x0
                         LD R2, NEGASCII
                         ADD R0, R0, R2
                         AND R1, R1, #0
                         LD R1, THOUSAND
                         JSR divide
                         ADD R4, R2, R4
                         ADD R5, R5, #1
                         BR c2

cDIV                    LEA R5, str1
c2DIV               LDR R0, R5, x0
                         LD R2, NEGASCII
                         ADD R0, R0, R2
                         AND R1, R1, #0
                         LD R1, H
                         JSR divide
                         ADD R4, R2, R4
                         ADD R5, R5, #1
                         BR t2

            tDIV             LEA R5, str1
            t2DIV           LDR R0, R5, x0
                         LD R2, NEGASCII
                         ADD R0, R0, R2
                         AND R1, R1, #0
                         ADD R1, R1, #10
                         JSR divide
                         ADD R4, R2, R4
                         ADD R5, R5, #1
                         BR o2

            oDIV          LEA R5, str1
            o2DIV        LDR R0, R5, x0
                         LD R2, NEGASCII
                         ADD R0, R0, R2
                         AND R1, R1, #0
                         ADD R1, R1, #1
                         JSR divide
                         ADD R4, R2, R4
                         LD R1, PASS
                         ADD R1, R1, #1
                         BRz stnum1
                         BRp stnum2






;Multiply two numbers: R0 * R1.
;not optimal wrt R0&R1 ordering
;Assuming that both inputs are positive
;Assuming that both inputs are single digit
;In: R1 and R0
;Out: R2
;Trashed: N/A
multiply AND R2, R2, 0
ADD R1, R1, #0
BRz RZERO; handle the case that r1 is 0
ADD R0, R0, #0
BRz RZERO; handle the case that r0 is 0
MULTLOOP ADD R2, R2, R1; start multplication
ADD R0, R0, #-1
BRp MULTLOOP
RET;
;Hello, i am only here because R1 = 0;
RZERO AND R2, R2, #0; return 0
RET;


;output ADD R4, R2, #0
             ;LD R5, result


EOL       .fill         #-3 ; Limit of chars
str1       .BLKW 5 ; Allocate memory for chars to be stored
prompt1             .STRINGZ "enter a 4 digit number "
WHATOP  .STRINGZ "choose your operation ( +, -, x, /)"
outp    .STRINGZ "Your result is in R2"
str2       .BLKW 5 ; Allocate memory for chars to be stored
num1    .BLKW 2
num2    .BLKW 2
result  .BLKW 5
PASS    .FILL #-1
ADDS    .FILL #-43
SUBS    .FILL #-45
MULTIS  .FILL #-120
DEVS    .FILL #-47
ENDL    .fill xA
THOUSAND .FILL #1000
H .FILL #100
NEGASCII .FILL x-30
             .end
