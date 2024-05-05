; Monroe Gordon
; April, 23, 2024
; Eliza
; keyword.asm - Contains functions and data for finding keywords in the user's input and using keywords to generate a reply.

.386P
.model flat	

; Library calls
extern	_StrContains: near							; Check if stringA contains stringB
extern	_StrLen: near								; Count number of characters in a string

; Program data
.data
keyword				dword	36			DUP(00h)	; Keyword array

; Keywords
kw1					byte	"CAN YOU ", 0
kw2					byte	"CAN I ", 0
kw3					byte	"YOU ARE ", 0
kw4					byte	"YOU'RE ", 0
kw5					byte	"I DON'T ", 0
kw6					byte	"I FEEL ", 0
kw7					byte	"WHY DON'T YOU ", 0
kw8					byte	"WHY CAN'T I ", 0
kw9					byte	"ARE YOU ", 0
kw10				byte	"I CAN'T ", 0
kw11				byte	"I AM ", 0
kw12				byte	"I'M ", 0
kw13				byte	"YOU ", 0
kw14				byte	"I WANT ", 0
kw15				byte	"WHAT ", 0
kw16				byte	"HOW ", 0
kw17				byte	"WHO ", 0
kw18				byte	"WHERE ", 0
kw19				byte	"WHEN ", 0
kw20				byte	"WHY ", 0
kw21				byte	"NAME ", 0
kw22				byte	"CAUSE ", 0
kw23				byte	"SORRY ", 0
kw24				byte	"DREAM ", 0
kw25				byte	"HELLO ", 0
kw26				byte	"HI ", 0
kw27				byte	"MAYBE ", 0
kw28				byte	"NO ", 0
kw29				byte	"YOUR ", 0
kw30				byte	"ALWAYS ", 0
kw31				byte	"THINK ", 0
kw32				byte	"ALIKE ", 0
kw33				byte	"YES ", 0
kw34				byte	"FRIEND ", 0
kw35				byte	"COMPUTER ", 0
kw36				byte	"NOKEYFOUND", 0

; Program code
.code
; Initialize keyword array
InitKeyword PROC C
_InitKeyword:
	mov		ebx, offset keyword						; Store address of keyword array in ebx
	mov		[ebx], offset kw1						; Store kw1 in keyword array
	mov		[ebx + 4], offset kw2					; Store kw2 in keyword array
	mov		[ebx + 2 * 4], offset kw3				; Store kw3 in keyword array
	mov		[ebx + 3 * 4], offset kw4				; Store kw4 in keyword array
	mov		[ebx + 4 * 4], offset kw5				; Store kw5 in keyword array
	mov		[ebx + 5 * 4], offset kw6				; Store kw6 in keyword array
	mov		[ebx + 6 * 4], offset kw7				; Store kw7 in keyword array
	mov		[ebx + 7 * 4], offset kw8				; Store kw8 in keyword array
	mov		[ebx + 8 * 4], offset kw9				; Store kw9 in keyword array
	mov		[ebx + 9 * 4], offset kw10				; Store kw10 in keyword array
	mov		[ebx + 10 * 4], offset kw11				; Store kw11 in keyword array
	mov		[ebx + 11 * 4], offset kw12				; Store kw12 in keyword array
	mov		[ebx + 12 * 4], offset kw13				; Store kw13 in keyword array
	mov		[ebx + 13 * 4], offset kw14				; Store kw14 in keyword array
	mov		[ebx + 14 * 4], offset kw15				; Store kw15 in keyword array
	mov		[ebx + 15 * 4], offset kw16				; Store kw16 in keyword array
	mov		[ebx + 16 * 4], offset kw17				; Store kw17 in keyword array
	mov		[ebx + 17 * 4], offset kw18				; Store kw18 in keyword array
	mov		[ebx + 18 * 4], offset kw19				; Store kw19 in keyword array
	mov		[ebx + 19 * 4], offset kw20				; Store kw20 in keyword array
	mov		[ebx + 20 * 4], offset kw21				; Store kw21 in keyword array
	mov		[ebx + 21 * 4], offset kw22				; Store kw22 in keyword array
	mov		[ebx + 22 * 4], offset kw23				; Store kw23 in keyword array
	mov		[ebx + 23 * 4], offset kw24				; Store kw24 in keyword array
	mov		[ebx + 24 * 4], offset kw25				; Store kw25 in keyword array
	mov		[ebx + 25 * 4], offset kw26				; Store kw26 in keyword array
	mov		[ebx + 26 * 4], offset kw27				; Store kw27 in keyword array
	mov		[ebx + 27 * 4], offset kw28				; Store kw28 in keyword array
	mov		[ebx + 28 * 4], offset kw29				; Store kw29 in keyword array
	mov		[ebx + 29 * 4], offset kw30				; Store kw30 in keyword array
	mov		[ebx + 30 * 4], offset kw31				; Store kw31 in keyword array
	mov		[ebx + 31 * 4], offset kw32				; Store kw32 in keyword array
	mov		[ebx + 32 * 4], offset kw33				; Store kw33 in keyword array
	mov		[ebx + 33 * 4], offset kw34				; Store kw34 in keyword array
	mov		[ebx + 34 * 4], offset kw35				; Store kw35 in keyword array
	mov		[ebx + 35 * 4], offset kw36				; Store kw36 in keyword array
	
	ret												; Return from function, no return value
InitKeyword ENDP ; End of InitKeyword

; Find keyword in user's input
FindKeyword PROC C
_FindKeyword:
	pop		eax										; Save return address
	pop		esi										; Pop first input parameter of FindKeyword
	push	eax										; Restore return address

	; Set findLoop counter
	mov		ecx, 0									; Set loop counter to 0
	mov		edx, offset keyword						; Move address of keyword array to edx

	; Try to find a keyword in the user's input (esi)
_findLoop:											; Check each keyword in the keyword array to see if the user's input (esi) contains it
	cmp		ecx, 35									; Compare ecx to 35 (keyword array length - 1)
	je		_nokey									; Jump to nokey if all keywords (except the last) has been checked
	push	ecx										; Save ecx (loop counter) value
	push	edx										; Save edx (keyword index) value
	mov		edi, [edx]								; Move contents of edx (keyword index) to edi
	push	edi										; Last input parameter to StrContains specifying the address of stringB (the keyword)
	push	esi										; First input parameter to StrContains specifying the address of stringA
	call	_StrContains							; Call StrContains to see if stringA contains stringB
	pop		edx										; Restore edx (keyword index) value
	pop		ecx										; Restore ecx (loop counter) value
	cmp		eax, 1									; Compare StrContains return value at eax to 1 (true)
	je		_return									; If stringA contains stringB (eax == 1), return from function
	inc		ecx										; Increment ecx (loop counter)
	add		edx, 4									; Move edx to next keyword index
	jmp		_findLoop								; Restart findLoop

	; If no keyword was found in the user's input (esi), set edi to keyword[35] = "NOKEYFOUND"
_nokey:
	mov		edx, offset keyword						; Move address of keyword array to edx
	add		edx, 35 * 4								; Move edx to index 35 of the keyword array (pointer to "NOKEYFOUND")
	mov		edi, [edx]								; Move contents of edx (keyword index) to edi

_return:											; Return from function
	mov		eax, edi								; Set return value (eax) to keyword pointer at edi's address
	ret												; Return from function with eax containing return value
FindKeyword ENDP ; End of FindKeyword

; Generate a reply from keywords.
KeywordReply PROC C
_KeywordReply:

KeywordReply ENDP ; End of KeywordReply
end