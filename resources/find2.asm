.model small
.stack 100h
.data
    text        db 'Hello World!$'
    wrd         db 'Hellx World$'

    notfound    db 10, 13, "Not Found$"
    found    db 10, 13, "Found$"

    include    ..\..\include\gen.inc

.code
start:  mov ax, @data
        mov ds, ax
        mov es, ax

        print text
        newline
        print wrd

        ;To check if the length of substring is shorter than the main string
        mov cl, [si+1]
        mov ch, 0
        add si, cx
        mov bl, [di+1]
        mov bh, 0
        cmp bx, cx

        mov     bp, cx      ;CX is length string (long)
        sub     bp, bx      ;BX is length word  (short)
        inc     bp

        cld
        lea     si, [text + 2]
        lea     di, [wrd + 2]
        matching:
        mov     al, [si]    ;Next character from the string
        cmp     al, [di]    ;Always the first character from the word
        je      check
        continue:  
        inc     si          ;DI remains at start of the word
        dec     bp
        jnz     matching    ;More tries to do
        jmp     notfound_display

        check:
        push    si
        push    di
        mov     cx, bx     ;BX is length of word
        repe cmpsb
        pop     di
        pop     si
        jne     continue
        jmp     found_display

        notfound_display: print notfound
        found_display: print found
exit:   mov ah, 4ch
        int 21h
end start
