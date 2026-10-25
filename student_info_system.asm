; Student Management System in 8086 Assembly (NASM syntax, runs in DOSBox)
; Menu-driven program to Add, View, and Exit
; Demonstrates registers, memory management, procedures, loops, and DOS interrupts

.MODEL SMALL
.STACK 100H

.DATA
    menu        DB 10,13,"===== STUDENT MANAGEMENT SYSTEM =====",10,13
                DB "1. Add Student",10,13
                DB "2. View Students",10,13
                DB "3. Exit",10,13
                DB "Enter choice: $"

    addMsg      DB 10,13,"Enter Student Name: $"
    idMsg       DB 10,13,"Enter Student ID: $"
    savedMsg    DB 10,13,"Student record saved!",10,13,"$"
    viewMsg     DB 10,13,"--- Student Records ---",10,13,"$"
    exitMsg     DB 10,13,"Exiting program...",10,13,"$"
    invalidMsg  DB 10,13,"Invalid choice, try again.",10,13,"$"

    studentName DB 30 DUP('$')
    studentId   DB 10 DUP('$')
    choice      DB ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

MENU_LOOP:
    ; Display menu
    LEA DX, menu
    MOV AH, 09H
    INT 21H

    ; Read choice
    MOV AH, 01H
    INT 21H
    MOV choice, AL

    CMP choice, '1'
    JE ADD_STUDENT
    CMP choice, '2'
    JE VIEW_STUDENT
    CMP choice, '3'
    JE EXIT_PROG

    LEA DX, invalidMsg
    MOV AH, 09H
    INT 21H
    JMP MENU_LOOP

ADD_STUDENT:
    LEA DX, addMsg
    MOV AH, 09H
    INT 21H

    LEA DX, studentName
    MOV AH, 0AH        ; buffered input
    INT 21H

    LEA DX, idMsg
    MOV AH, 09H
    INT 21H

    LEA DX, studentId
    MOV AH, 0AH
    INT 21H

    LEA DX, savedMsg
    MOV AH, 09H
    INT 21H

    JMP MENU_LOOP

VIEW_STUDENT:
    LEA DX, viewMsg
    MOV AH, 09H
    INT 21H

    ; Display stored name (simple single-record demo)
    LEA DX, studentName
    MOV AH, 09H
    INT 21H

    JMP MENU_LOOP

EXIT_PROG:
    LEA DX, exitMsg
    MOV AH, 09H
    INT 21H

    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
