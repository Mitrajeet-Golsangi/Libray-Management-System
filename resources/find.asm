.model small
.stack 100h
.data
    text db 'Hello World!'
    count dw 13
    search db 'e'
    found db 10, 13, "String found $"
    notFound db 10, 13, "String not found $"
.code
start:  mov ax, @data
        mov ds, ax
        mov es, ax
        
        mov cx, count
        
        mov di, offset text

        mov al, search
        repne scasb
        jnz no

yes:    mov ah, 09h
        lea dx, found
        int 21h
        jmp exit
no:     mov ah, 09h		; Printing the data
        lea dx, notFound
        int 21h
exit:   mov ah, 4ch
        int 21h
end start
