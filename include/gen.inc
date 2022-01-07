; Clear's the console
cls macro
	mov ah, 00h
	mov al, 02h
	int 10h
endm

userInp macro var
    mov ah, 01h
    int 21h

    mov bl, al
    sub bl, 30h

    mov var, bl
endm

print macro msg
    mov ah, 09h		; Printing the data
    lea dx, msg
    int 21h
endm

newline macro
    mov dl, 10
    mov ah, 02h
    int 21h
endm

inpString macro var
    mov ah, 0ah
    mov dx, offset var
    int 21h
endm
