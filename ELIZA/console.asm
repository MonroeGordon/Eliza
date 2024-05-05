; Monroe Gordon
; April, 23, 2024
; Eliza
; console.asm - Contains functions and data for handling console input/output.

.386P
.model flat	

; Library calls
extern	_StrLen: near								; Count number of characters in a string
extern  _GetStdHandle@4:near						; Function for getting handle pointers
extern  _WriteConsoleA@20:near						; Writes to the console
extern  _ReadConsoleA@20:near						; Reads user input from the console

; Program data
.data
; WriteOut data
outputHandle		dword   ?						; The uninitialized handle for output
written				dword   ?						; Number of characters written

; ReadIn data
readBuffer			byte	1024		DUP(00h)	; The buffer holding the characters read from the users console input
numCharsToRead		dword	1024					; Maximum number of characters to try to read
numCharsRead		dword	?						; Number of characters read from the users console input
inputHandle			dword   ?						; The uninitialized handle for input

; Program code
.code
; Write console output
WriteOut PROC C
_WriteOut:
		pop		eax									; Save the return address
		pop		esi									; Pop first input parameter of WriteOut
		push	eax									; Restore the return address

		; outputHandle = GetStdHandle(-11)
        push    -11									; First input parameter to GetStdHandle specifying to return an output handle
        call    _GetStdHandle@4						; Call to GetStdHandle
        mov     outputHandle, eax					; Store return value from GetStdHandle into register EAX and move it into outputHandle

		; CharCount(&string)
		push	esi									; First and only input parameter of CharCount specifying the characters to count
		call	_StrLen								; Call StrLen

        ; WriteConsole(handle, &msg[0], numCharsToWrite, &written, 0)
        push    0									; Last input parameter of WriteConsole
        push    offset written						; Fourth input parameter to WriteConsole specifying address of written that stores number of written characters
        push    eax									; Push return of WriteCount as thrird parameter of WriteConsole specifying number of characters to write
        push    esi									; Push first input parameter of writeline as second parameter of WriteConsole specifying the characters to write
        push    outputHandle						; First input parameter of WriteConsole that is the output handle
        call    _WriteConsoleA@20					; Call to WriteConsole
		ret											; Return from function, no return value
WriteOut ENDP ; End of WriteOut

; Read console input
ReadIn PROC C
_ReadIn:
		; inputHandle = GetStdHandle(-10)
		push	-10									; First input to GetStdHandle specifying to return an input handle
		call	_GetStdHandle@4						; Call to GetStdHandle
		mov		inputHandle, eax					; Store return value from GetStdHandle into register EAX and move it into inputHandle

		; ReadConsole(inputHandle, &readBuffer, numCharsToRead, &numCharsRead, 0)
		push	0									; Last input parameter of ReadConsole
		push	offset numCharsRead					; Fourth input parameter of ReadConsole specifying address of numCharsRead that stores number of read characters
		push	numCharsToRead						; Third input parameter of ReadConsole specifying the number of characters to try to read
		push	offset readBuffer					; Second input parameter of ReadConsole specifying the buffer to store the read characters into
		push	inputHandle							; First input parameter of ReadConsole that is the input handle
		call	_ReadConsoleA@20					; Call to ReadConsole
		mov		eax, offset readBuffer				; Store the address of the buffer of read characters into the return address (eax)
		ret											; Return from function with eax holding readBuffer's address
ReadIn ENDP ; End of ReadIn
end