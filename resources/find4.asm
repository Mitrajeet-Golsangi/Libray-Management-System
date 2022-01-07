; Program to to find the position of the substring
.model small

.stack 100h
.data

    include ..\..\include\gen.inc

    len         db 0
    ; string      db 30 			; max characters
	; 			db 0  			; user entered characters
	; 			db 30 dup('$')	; storing user input characters

    string      db "testing$"
    subString   db "ing$"
    
    subLen      db 0
    ; subString   db 29			;  max characters
	; 			db 0			; characters entered by user
	; 			db 29 dup('$')	; storing user input characters


    inpStrMsg   db 10, 13, "Enter a String : $"
    inpSubMsg   db 10, 13, "Enter a substring : $"

    stringMsg   db 10,13,'String is : $'
    subStrMsg   db 10,13,'Substring is : $'
    foundMsg    db 10,13,'Substring found$'
    notFoundMsg db 10,13,'Substring not found$'
    pos         db -1
    
.code
    START:
    main proc					    ; Main Procedure
        mov ax, @data
        mov ds, ax
;---------------------------------- Taking the string from the user
        ; print inpStrMsg
        ; inpString string
		print string
		newline
		print subString

        ; print inpSubMsg
        ; inpString subString
;---------------------------------- calculating length of string
        lea si, string              ; Moving index of string in si
lp1:    cmp [si], "$"
        je done1
        inc len
        inc si
        jmp lp1
;---------------------------------- calculating length of substring
done1:  lea di, subString			; moving index of substring in si
lp2:    cmp [di], "$"
        je done2 					;<====== Logic Break
        inc subLen
        inc di
        jmp lp2
;---------------------------------- Setting the counter as the difference between string and substring
done2:  lea si, string				; move the first index of the string to si
        mov al, len					; move len to al
        mov cl, al					; mov value of al to cl
        mov al, subLen				; mov sublen to al
		mov bl, al					; moving counter to bl
        mov ch, 0					; make ch null
;---------------------------------- 
        ; mov bl, subLen - 1          ; setting the counter as substring length - 1
        lea di, substring			; Moving the substring index to di register
first:  inc pos						; increamenting the position
        mov al, [si]				
        cmp al, [di]				; comparing the first character of string with the first character of substring
        je cmpr						; goto cmpr if they are equal
        inc si						; increament si
        loop first					; repeat the above process until string ends
;---------------------------------- 
neq:    mov pos, -1					; redefine the pos as -1
        print notFoundMsg			; display the string not found message
        jmp exit					; exit the code
;---------------------------------- 
cmpr:   inc di						; take second character of the subtring
        inc si						; take the next character of the string
        mov al, [si]				
        cmp al, [di]				; compare the characters
        jne neq						; goto neq i they are not equal
        dec bl						; decrement counter
        jnz cmpr					; repeat until the counter is not zero
;---------------------------------- 
equal:  print foundMsg				; print the stirng found message
        jmp exit					; exit the code
;---------------------------------- 
exit:   mov ah, 4ch				    ; Getting the output
        int 21h
main endp

END START

; testing$
; ing$

; bl = 2

; si = t 
; di = i --> 0
; si ==? di

; si = e 
; di = i --> 0
; si ==? di

; si = s
; di = i --> 0
; si ==? di

; si = t 
; di = i --> 0
; si ==? di

; si = i 
; di = i --> 0
; si ==? di

; si = n
; di = n --> 1
; si ==? di
; bl = 1

; si = g
; di = g --> 2
; si ==? di
; bl == 0

; stop