; Closing the file
closeFile macro filePtr
	mov ah, 3eh
	mov dx, fp
	int 21h
endm

; Creating a file
createFile macro file

	mov ah, 3ch
	mov al, 00h
	lea dx, file
	mov cx, 0000h
	int 21h
	mov fp, ax

	mov ah, 09h		; Printing the data
	lea dx, creationMsg
	int 21h
endm

; Opening the file
openFile macro file, readMode
	mov ah, 3dh
	lea dx, file
	mov al, readMode
	int 21h
	mov fp, ax
endm

appendFile macro filePtr
	mov bx, filePtr
	mov ah, 42h
	mov al, 02h
	mov cx, 0
	int 21h
endm

writeFile macro msg, filePtr, len
	mov ah, 40h						; Write to the file
	mov bx, filePtr
	mov cx, len
	lea dx, msg
	int 21h
endm
