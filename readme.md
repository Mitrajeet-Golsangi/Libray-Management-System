# 1. Library management System

*note : The project is still under development and some features may not work*

## 1.1. Introduction

This is a simple library management system which uses the x86 TASM assembler.

---

## 1.2. Setup

1. Pull the github repo using

    ```
    cd <your_folder>
    git init
    git pull https://github.com/Mitrajeet-Golsangi/Libray-Management-System.git
    ```

2. Install the MASM/TASM assembler for vscode [this link]()
3. In Settings search for `masmtasm.mode` and then set the settings to workspace
4. Run the assembly code using `alt + n` or right-click and run-ASM

---

## 1.3. Features

1. File handling : The db folder contains the BOOKS.TXT file holding all the books in the library

### 1.3.1. file.inc

The file.inc header file contains macros related to the file handling concepts

1. File creation
2. Opening a File
3. Closing a File
4. File reading
5. File Writing
6. Setting the file pointer at EOF

### 1.3.2. gen.inc

The gen.inc header file contains macros of general operations needed in the program

1. Clearing the console window
2. Getting the user input
3. Printing a message to the console
4. Printing a newline
5. Taking a string input from the user

### main.asm

The main.asm file contains all the main code and procedures for

1. Getting the books from the file
2. Appending new book to the file
3. Searching for a specific book in a file (in dev)
