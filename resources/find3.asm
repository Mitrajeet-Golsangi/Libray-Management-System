; Program to find subtring in a string
.model small
.stack 100h
.data
    STR         db 'AXYBCSDEF$'
    SubStirng   db 'BCS$'
    LEN1        db 0
    LEN2        db 0
    MSG1        db 10,13,'STRING IS : $'
    MSG2        db 10,13,'SUBSTRING IS : $'
    MSG3        db 10,13,'SUBSTRING IS FOUND AT POSITION : $'
    POS         db -1
    RTN         db '-1$'

DISPLAY MACRO MSG
    MOV AH,9
    LEA DX, MSG
    INT 21H
ENDM
.code
START:  MOV AX,DATA
        MOV DS,AX
        DISPLAY MSG1
        DISPLAY STR
        DISPLAY MSG2
        DISPLAY SubStirng
        LEA SI,STR
NXT1:   CMP [SI],'$'
        JE DONE1
        INC LEN1
        INC SI
        JMP NXT1
DONE1:  LEA DI,SubStirng
NXT2:   CMP [DI],'$'
        JE DONE2
        INC LEN2
        INC DI
        JMP NXT2
DONE2:  DISPLAY MSG3
        LEA SI,STR
        MOV AL,LEN1
        SUB AL,LEN2
        MOV CL,AL
        MOV CH,0
FIRST:  INC POS
        MOV AL,[SI]
        CMP AL,SubStirng[0]
        JE CMPR
        INC SI
        LOOP FIRST
CMPR:   INC SI
        MOV AL,[SI]
        CMP AL,SubStirng[1]
        JNE neq
        INC SI
        MOV AL,[SI]
        CMP AL,SubStirng[2]
        JE EQUAL
neq:    MOV POS,-1
        DISPLAY RTN
        JMP EXIT
EQUAL:  MOV DL,POS
        ADD DL,30H
        MOV AH,2
        INT 21H
EXIT:   MOV AH,4CH
        INT 21H
END START