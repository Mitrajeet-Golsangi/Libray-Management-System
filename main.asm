; Program to manage a library system
.model large
.stack 100h
.data
	               include  ..\include\file.inc
	               include  ..\include\gen.inc

	books          db       'D:\db\books.txt', 0
	fp             dw       ?
	
	choice         db       1
	cont           db       1
	nl             db       10, 13
	pos            db       -1

	               newBook  label 	byte
	maxLen         db       20
	len            db       0
	bk             db       20  dup('$')
	
	               searchBk label 	byte
	maxLenS        db       20
	lenSearch      dw       0
	bkSearch       db       20  dup('$')
	
	availableBooks db       100 dup('$')
	
	hr             db       10, 13, "=====================================================$"
	welc           db       10, 13, "Welcome to the library !$"

	q              db       10, 13, "What do you want to do ?$"
	c1             db       10, 13, "1 : Get books$"
	c2             db       10, 13, "2 : Update books$"
	c3             db       10, 13, "3 : Find$"
	c4             db       10, 13, "4 : Exit$"
	res            db       10, 13, "Enter your choice: $"
	
	creationMsg    db       10, 13, "File created Successfully!$"
	booksMsg       db       10, 13, "The books are : $"
	contMsg        db       10, 13, "Press any key to continue... $"
	searchMsg      db       10, 13, "Enter the book name you want : $"
	updateMsg      db       10, 13, "The Books have been updated successfully! New Books are : $"

	sucSearch      db       10, 13, "The Book is present :)"
	failSearch     db       10, 13, "The Book was not found :/", 13, 10, "But You can add it :)"
.code

	START:      
	            mov        ax, @data
	            mov        ds, ax
	;----------------------------------- Clearing the screen
	lp:         cls
	;----------------------------------- Printing the welcome message
	            print      hr
	            print      welc
	            print      hr
	            newline
	;----------------------------------- Printing the choice message
	            print      q
	            print      c1
	            print      c2
	            print      c3
	            print      c4
				print	   res
	            newline
	;----------------------------------- Get the choice from the user
	            userInp    choice
	;----------------------------------- check if the choice is 1 or 2 and go to the required code
	            cmp        choice, 1
	            jz         op1
	            cmp        choice, 2
	            jz         op2
	            cmp        choice, 3
	            jz         op3
	            jmp        exit
	;----------------------------------- Actions to perform if option 1 is selected
	op1:        cls
	            print      c1
	            newline
	            call       getBook
	            print      availableBooks
		
	            print      contMsg
	            userInp    cont
		
	            jmp        lp
	;----------------------------------- Actions to perform if option 2 is selected
	op2:        cls
	            print      c2
	            newline
	            inpString  newBook
		
	            call       updateBooks

	            print      contMsg
	            userInp    cont

	            jmp        lp

	;----------------------------------- Actions to perform if option 3 is selected
	op3:        cls
	            print      c3
	            newline

	            call       getBook

	            print      searchMsg
	            inpString  searchBk
		

	            call       findBook

	            print      contMsg
	            userInp    cont
	            jmp        lp

	;----------------------------------- Exiting the code
	exit:       mov        ah, 4ch           	; Getting the output
	            int        21h

	;==================================
getBook proc near
	;---------------------------------- Opening the books file
	            openFile   books, 0
	;---------------------------------- Reading the books file
	            mov        ah, 3fh
	            mov        bx, fp
	            lea        dx, availableBooks
	            mov        cx, 100
	            int        21h
		
	            closeFile  fp

	            ret

getBook endp

updateBooks proc near
	;---------------------------------- Opening the books file
	            openFile   books, 1
	;---------------------------------- Appending in the file
	            appendFile fp                	; Set the file pointer to end of the file

	            writeFile  nl, fp, 2         	; Set the file pointer to a newline in the file
	            writeFile  bk, fp, 5         	; write the inputed msg from the user to the file

	            closeFile  fp                	; close the file
	
	            print      updateMsg         	; print the success message
	            newline                      	; newline
	            call       getBook           	; update the avaiableBooks array for the new books
	            print      availableBooks    	; print the updated books
	            ret
updateBooks endp

findBook proc near
	            lea        si, availableBooks
		
	            LEA        DI,	bk
	NXT2:       CMP        [DI],'$'
	            JE         DONE2
	            INC        len
	            INC        DI
	            JMP        NXT2
	DONE2:      LEA        SI, availableBooks
	            MOV        AL, 100
	            SUB        AL, len
	            MOV        CL, AL
	            MOV        CH, 0
	FIRST:      INC        pos
	            MOV        AL,[SI]
	            CMP        AL,bk[0]
	            JE         CMPR
	            INC        SI
	            LOOP       FIRST
	CMPR:       INC        SI
	            MOV        AL,[SI]
	            CMP        AL,bk[1]
	            JNE        neq
	            INC        SI
	            MOV        AL,[SI]
	            CMP        AL,bk[2]
	            JE         EQUAL
	neq:        MOV        pos,-1
	            print      failSearch
	            JMP        ex
	EQUAL:      print      sucSearch

	ex:         ret
findBook endp
END START

; ------------------- Doubts ------------------- ;
; 1. String length problem
; 2. string search problem