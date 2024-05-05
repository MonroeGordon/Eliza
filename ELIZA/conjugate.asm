; Monroe Gordon
; April, 23, 2024
; Eliza
; conjugate.asm - Contains functions and data for conjugating strings together to form a correct wordin.

.386P
.model flat	

; Program data
.data
wordin				dword	7			DUP(00h)	; WordIn array
wordout				dword	7			DUP(00h)	; WordOut array

; WordIns
wi1					byte	" ARE ", 0
wi2					byte	" WERE ", 0
wi3					byte	" YOU ", 0
wi4					byte	" YOUR ", 0
wi5					byte	" I'VE ", 0
wi6					byte	" I'M ", 0
wi7					byte	" ME ", 0

; WordOuts
wo1					byte	" AM ", 0
wo2					byte	" WAS ", 0
wo3					byte	" I ", 0
wo4					byte	" MY ", 0
wo5					byte	" YOU'VE ", 0
wo6					byte	" YOU'RE ", 0
wo7					byte	" YOU ", 0

; Program code
.code
; Initialize WordIn and WordOut arrays
InitConjugates PROC C
_InitConjugates:
	mov		ebx, offset wordin						; Store address of wordin array in ebx
	mov		[ebx], offset wi1						; Store wi1 in wordin array
	mov		[ebx + 4], offset wi2					; Store wi2 in wordin array
	mov		[ebx + 2 * 4], offset wi3				; Store wi3 in wordin array
	mov		[ebx + 3 * 4], offset wi4				; Store wi4 in wordin array
	mov		[ebx + 4 * 4], offset wi5				; Store wi5 in wordin array
	mov		[ebx + 5 * 4], offset wi6				; Store wi6 in wordin array
	mov		[ebx + 6 * 4], offset wi7				; Store wi7 in wordin array

	mov		ebx, offset wordout						; Store address of wordout array in ebx
	mov		[ebx], offset wo1						; Store wo1 in wordout array
	mov		[ebx + 4], offset wo2					; Store wo2 in wordout array
	mov		[ebx + 2 * 4], offset wo3				; Store wo3 in wordout array
	mov		[ebx + 3 * 4], offset wo4				; Store wo4 in wordout array
	mov		[ebx + 4 * 4], offset wo5				; Store wo5 in wordout array
	mov		[ebx + 5 * 4], offset wo6				; Store wo6 in wordout array
	mov		[ebx + 6 * 4], offset wo7				; Store wo7 in wordout array

	ret												; Return from function, no return value
InitConjugates ENDP ; End of InitConjugates

; Conjugate the string using the conjugation string pairs.
Conjugate PROC C
_Conjugate:
	
Conjugate ENDP ; End of Conjugate
end