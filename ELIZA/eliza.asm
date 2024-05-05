; Monroe Gordon
; April, 23, 2024
; Eliza
; eliza.asm - Contains the main program entry point function that processes the program loop.

.386P
.model flat	

; Library calls
extern	_StrReplace: near
extern	_WriteOut: near								; Write out to console
extern	_ReadIn: near								; Read in from console
extern	_InitKeyword: near							; Initialize keyword array
extern	_InitReply: near							; Initialize reply array
extern	_InitConjugates: near						; Initialize conjugate arrays
extern	_GetReply: near								; Get the reply at the specified index
extern	_ExitProcess@4: near						; Exit program

; Program data
.data
; Program header strings
separator			byte	"**************************", 10, 0
program				byte	"ELIZA", 10, 0
company				byte	"CREATIVE COMPUTING", 10, 0
location			byte	"MORRISTOWN, NEW JERSEY", 10, 10, 0
info				byte	"ADAPTED FOR IBM BY", 10, 0
authors				byte	"PATRICIA DANIELSON AND PAUL HASHFIELD", 10, 0
note1				byte	"BE SURE THAT THE CAPS LOCK IS ON", 10, 0
note2				byte	"PLEASE DON'T USE COMMAS OR PERIODS IN YOUR INPUTS", 10, 0

user				byte	"?: ", 0				; User prompt string
eliza				byte	"Eliza: ", 0			; Eliza prompt string
newline				byte	10, 0					; Newline string

test1				byte	"LIZ", 0
test2				byte	"ZL", 0

; Eliza's intro statement
intro				byte	"HI! I'M ELIZA. WHAT'S YOUR PROBLEM?", 0

userBuffer			byte	1024		DUP(00h)	; The buffer holding the characters read from the users console input
elizaBuffer			byte	1024		DUP(00h)	; The buffer holding the characters of Eliza's response

; Program code
.code
; Main entry point function
main PROC near
_main:
	; Write program header info to console
	mov		esi, offset separator
	push	esi
	call	_WriteOut
	mov		esi, offset program
	push	esi
	call	_WriteOut
	mov		esi, offset company
	push	esi
	call	_WriteOut
	mov		esi, offset location
	push	esi
	call	_WriteOut
	mov		esi, offset info
	push	esi
	call	_WriteOut
	mov		esi, offset authors
	push	esi
	call	_WriteOut
	mov		esi, offset note1
	push	esi
	call	_WriteOut
	mov		esi, offset note2
	push	esi
	call	_WriteOut
	mov		esi, offset separator
	push	esi
	call	_WriteOut

	; Initialize keyword array
	call	_InitKeyword

	; Initialize reply array
	call	_InitReply

	; Initialize conjugate arrays
	call	_InitConjugates

	; Write intro statement
	mov		esi, offset newline
	push	esi
	call	_WriteOut

	mov		esi, offset intro
	push	esi
	call	_WriteOut

	mov		esi, offset newline
	push	esi
	call	_WriteOut

	mov		esi, offset	program
	mov		edx, offset test2
	mov		edi, offset test1
	push	esi
	push	edx
	push	edi
	call	_StrReplace

	mov		esi, eax
	push	esi
	call	_WriteOut

	; Exit program with code 0
	push	0
	call	_ExitProcess@4

main ENDP ; End of main
end