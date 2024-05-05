; Monroe Gordon
; April, 23, 2024
; Eliza
; string.asm - Contains functions and data for manipulating strings.

.386P
.model flat

extern	_WriteOut: near	

; Program data
.data
; Shared data
addrA				dword	0						; Address of stringA
addrB				dword	0						; Address of stringB
lenA				dword	0						; The length of stringA
lenB				dword	0						; The length of stringB
charA				byte	0						; Character from stringA
charB				byte	0						; Character from stringB
index				dword	0						; Index value of the subBuffer
maxCount			dword	256						; Maximum number of characters allowed in a string (protects from non-terminated strings cauing infinite loop)

; StrConcat data
concatBuffer		byte	256			DUP(00h)	; Concatenated string buffer (256 character limit)

; StrContains data
outer				dword	0						; The outer loop counter
inner				dword	0						; The inner loop counter

; StrLen data
charOffset			dword	0						; Address offset of the next character in the buffer being written
nextChar			byte	?						; The next character in the buffer being written

; StrRemoveAt data
rmvBuffer			byte	256			DUP(00h)	; Remove string buffer (256 character limit)

; StrReplace data
repBuffer			byte	256			DUP(00h)	; Replacement string buffer (256 character limit)

; StrSub data
len					dword	0						; The length of the input string
subBuffer			byte	256			DUP(00h)	; Substring buffer (256 character limit)

; Program code
.code
; Concatenate two strings
StrConcat PROC C
_StrConcat:
		pop		eax									; Save the return address
		pop		esi									; Pop first input parameter of StrConcat specifying the address of the first string
		pop		edi									; Pop second input parameter of StrConcat specifying the address of the second string
		push	eax									; Restore the return address

		; Save other registers' current values
		push	ebx
		push	ecx
		push	edx

		; StrLen(&stringA)
		push	esi									; First and only input parameter of StrLen specifying the characters to count
		call	StrLen								; Call StrLen
		mov		lenA, eax							; Store return value into lenA

		; Swap esi and edi
		mov		ebx, esi							; Move esi to ebx
		mov		esi, edi							; Move edi to esi
		mov		edi, ebx							; Move ebx to edi

		; StrLen(&stringB)
		push	esi									; First and only input parameter of StrLen specifying the characters to count
		call	StrLen								; Call StrLen
		mov		lenB, eax							; Store return value into lenB

		; Swap esi and edi back
		mov		ebx, esi							; Move esi to ebx
		mov		esi, edi							; Move edi to esi
		mov		edi, ebx							; Move ebx to edi

		; Save current string addresses
		mov		addrA, esi							; Move esi to addrA
		mov		addrB, edi							; Move edi to addrB

		; Initialize index and loop counter (ecx)
		mov		index, 0							; Set index to 0
		mov		ecx, 0								; Set ecx to 0

		; Loop from 0 to lenA
_strALoop:											; Loop over characters in stringA
		; Set first part of concatBuffer to stringA
		mov		edi, offset concatBuffer			; Set edi to address of concatBuffer
		add		edi, index							; Add index to edi to move to index of concatBuffer
		mov		ebx, esi							; Set edx to esi (input string address)
		add		ebx, ecx							; Add ecx (current index) to ebx (input string address)
		mov		eax, [ebx]							; Move contents of address ebx to eax
		mov		[edi], eax							; Move eax to address of edi

		; Update and check index
		inc		index								; Increment index
		mov		edx, index							; Set edx to index
		cmp		edx, maxCount						; Compare edx to maxCount (max character length)
		je		_return								; Jump to return and return the current contents of concatBuffer, if max character length is reached

		; Update loop counter (ecx)
		inc		ecx									; Increment ecx (index value/loop counter)
		cmp		ecx, lenA							; Compare ecx (index value/loop counter) and lenA
		jl		_strALoop							; Restart strALoop if ecx < lenA 

		; Reset loop counter (ecx)
		mov		ecx, 0								; Set ecx to 0

		; Switch esi to stringB
		mov		esi, addrB							; Set esi to addrB

		; Loop from 0 to lenB
_strBLoop:											; Loop over characters in stringB
		; Set second part of concatBuffer to stringB
		mov		edi, offset concatBuffer			; Set edi to address of concatBuffer
		add		edi, index							; Add index to edi to move to index of concatBuffer
		mov		ebx, esi							; Set edx to esi (input string address)
		add		ebx, ecx							; Add ecx (current index) to ebx (input string address)
		mov		eax, [ebx]							; Move contents of address ebx to eax
		mov		[edi], eax							; Move eax to address of edi

		; Update and check index
		inc		index								; Increment index
		mov		edx, index							; Set edx to index
		cmp		edx, maxCount						; Compare edx to maxCount (max character length)
		je		_return								; Jump to return and return the current contents of concatBuffer, if max character length is reached

		; Update loop counter (ecx)
		inc		ecx									; Increment ecx (index value/loop counter)
		cmp		ecx, lenB							; Compare ecx (index value/loop counter) and lenB
		jl		_strBLoop							; Restart strBLoop if ecx < lenB

_return:
		; Add string terminator to concatBuffer
		mov		edi, offset concatBuffer			; Set edi to address of concatBuffer
		add		edi, index							; Add index to edi to move to index of concatBuffer
		mov		eax, 0								; Set eax to 0 (string terminator)
		mov		[edi], eax							; Set value at address of edi to eax

		; Restore esi and edi to original address values
		mov		esi, addrA							; Set esi to addrA
		mov		edi, addrB							; Set edi to addrB

		; Set return value to address of concatBuffer
		mov		eax, offset concatBuffer			; Set eax to address of concatBuffer

		; Restore other registers' original values
		pop		edx
		pop		ecx
		pop		ebx

		ret											; Return from function with eax holding the address of concatBuffer (the buffer containing the concatenated string)
StrConcat ENDP ; End of StrConcat

; Check if stringA contains stringB
StrContains PROC C
_StrContains:
		pop		eax									; Save the return address
		pop		esi									; Pop first input parameter of StrContains specifying the address of the first string
		pop		edi									; Pop second input parameter of StrContains specifying the address of the second string
		push	eax									; Restore the return address

		; Save other registers' current values
		push	ebx
		push	ecx
		push	edx

		; StrLen(&stringA)
		push	esi									; First and only input parameter of StrLen specifying the characters to count
		call	StrLen								; Call StrLen
		mov		lenA, eax							; Store return value into lenA

		; Swap esi and edi
		mov		ebx, esi							; Move esi to ebx
		mov		esi, edi							; Move edi to esi
		mov		edi, ebx							; Move ebx to edi

		; StrLen(&stringB)
		push	esi									; First and only input parameter of StrLen specifying the characters to count
		call	StrLen								; Call StrLen
		mov		lenB, eax							; Store return value into lenB

		; Swap esi and edi back
		mov		ebx, esi							; Move esi to ebx
		mov		esi, edi							; Move edi to esi
		mov		edi, ebx							; Move ebx to edi

		; Save current string addresses
		mov		addrA, esi							; Move esi to addrA
		mov		addrB, edi							; Move edi to addrB

		; Compare lenA and lenB
		mov		edx, lenA							; Move lenA to edx
		cmp		edx, lenB							; Compare edx to lenB
		jl		_return								; Jump to return (returning 0 (false)) if lenA is less than lenB

		; Prepare return value and loop counters
		mov		eax, 0								; Set eax to 0 (false)
		mov		outer, 0							; Set outer to 0
		mov		inner, 0							; Set inner to 0

		; Get next section of stringA that is the length of stringB
_outerLoop:											; Loop while outer loop count is less than lenA - lenB
		mov		edx, lenA							; Move lenA to edx
		sub		edx, lenB							; Subtract lenB from edx
		cmp		edx, outer							; Compare outer to edx
		je		_return								; Jump to return if lenA == edx (stringA does not contain stringB)

		; Reset esi and edi (the string pointers) to their original values
		sub		esi, inner							; Reset esi to point to the current index value of stringA by subtracting inner loop count's value
		sub		edi, inner							; Reset edi to point to the beginning of stringB by subtracting inner loop count's value
		add		esi, 1								; Move to the next index of stringA

		; Update loop counts
		inc		outer								; Increment outer loop count
		mov		inner, 0							; Reset inner loop count
		
		; Check section of stringA and stringB for equality
_innerLoop:											; Compare section of stringA to stringB for equality
		mov		edx, inner							; Move inner loop count to edx
		cmp		edx, lenB							; Compare edx to character count of stringB
		je		_contains							; Jump to contains if loop count == character count
		mov		dl, [edi]							; Move value at edx address to dl
		mov		charB, dl							; Move bl to charB
		mov		dl, [esi]							; Move value at ecx address to dl
		cmp		dl, charB							; Compare charA (dl) to charB
		jne		_outerLoop							; Jump to outerLoop if characters are not equal
		add		edi, 1								; Move to next character in stringB
		add		esi, 1								; Move to next character in stringA
		inc		inner								; Increment inner loop count
		jmp		_innerLoop							; Restart loop
		
		; Set return value to 1 (true) if loops completed successfully
_contains:			
		mov		eax, 1								; set eax to 1 (true)

_return:
		; Restore original string addresses
		mov		esi, addrA							; Move addrA to esi
		mov		edi, addrB							; Move addrB to edi

		; Restore other registers' original values
		pop		edx
		pop		ecx
		pop		ebx

		ret											; Return from function with eax holding if stringA contains stringB (0 (false)/1 (true))
StrContains ENDP ; End of StrContains

; Returns the index in stringA where stringB starts, or -1 if stringB is not in stringA
StrIndexOf PROC C
_StrIndexOf:
		pop		eax									; Save the return address
		pop		esi									; Pop first input parameter of StrIndexOf specifying the address of the first string
		pop		edi									; Pop second input parameter of StrIndexOf specifying the address of the second string
		push	eax									; Restore the return address

		; Save other registers' current values
		push	ebx
		push	ecx
		push	edx

		; StrLen(&stringA)
		push	esi									; First and only input parameter of StrLen specifying the characters to count
		call	StrLen								; Call StrLen
		mov		lenA, eax							; Store return value into lenA

		; Swap esi and edi
		mov		ebx, esi							; Move esi to ebx
		mov		esi, edi							; Move edi to esi
		mov		edi, ebx							; Move ebx to edi

		; StrLen(&stringB)
		push	esi									; First and only input parameter of StrLen specifying the characters to count
		call	StrLen								; Call StrLen
		mov		lenB, eax							; Store return value into lenB

		; Swap esi and edi back
		mov		ebx, esi							; Move esi to ebx
		mov		esi, edi							; Move edi to esi
		mov		edi, ebx							; Move ebx to edi

		; Save current string addresses
		mov		addrA, esi							; Move esi to addrA
		mov		addrB, edi							; Move edi to addrB

		; Compare lenA and lenB
		mov		edx, lenA							; Move lenA to edx
		cmp		edx, lenB							; Compare edx to lenB
		jl		_return								; Jump to return (returning 0 (false)) if lenA is less than lenB

		; Prepare return value and loop counters
		mov		eax, -1								; Set eax to -1 (does not contain stringB)
		mov		outer, 0							; Set outer to 0
		mov		inner, 0							; Set inner to 0

		; Get next section of stringA that is the length of stringB
_outerLoop:											; Loop while outer loop count is less than lenA - lenB
		mov		edx, lenA							; Move lenA to edx
		sub		edx, lenB							; Subtract lenB from edx
		cmp		edx, outer							; Compare outer to edx
		je		_return								; Jump to return if lenA == edx (stringA does not contain stringB)

		; Reset esi and edi (the string pointers) to their original values
		sub		esi, inner							; Reset esi to point to the current index value of stringA by subtracting inner loop count's value
		sub		edi, inner							; Reset edi to point to the beginning of stringB by subtracting inner loop count's value
		inc		esi									; Increment esi to move to the next index of stringA

		; Update loop counts
		inc		outer								; Increment outer loop count
		mov		inner, 0							; Reset inner loop count
		
		; Check section of stringA and stringB for equality
_innerLoop:											; Compare section of stringA to stringB for equality
		mov		edx, inner							; Move inner loop count to edx
		cmp		edx, lenB							; Compare edx to character count of stringB
		je		_contains							; Jump to contains if loop count == character count
		mov		dl, [edi]							; Move value at edx address to dl
		mov		charB, dl							; Move bl to charB
		mov		dl, [esi]							; Move value at ecx address to dl
		cmp		dl, charB							; Compare charA (dl) to charB
		jne		_outerLoop							; Jump to outerLoop if characters are not equal
		inc		edi									; Move to next character in stringB
		inc		esi									; Move to next character in stringA
		inc		inner								; Increment inner loop count
		jmp		_innerLoop							; Restart loop
		
		; Set return value to outer (index in stringA where stringB starts) if loops completed successfully
_contains:			
		mov		eax, outer							; set eax to outer (index in stringA where stringB starts)

_return:											; Return from function
		; Restore original string addresses
		mov		esi, addrA							; Move addrA to esi
		mov		edi, addrB							; Move addrB to edi

		; Restore other registers' original values
		pop		edx
		pop		ecx
		pop		ebx

		ret											; Return from function with eax holding the index where stringA contains stringB, or -1 if stringB is not in stringA
StrIndexOf ENDP ; End of StrIndexOf

; Count the number of characters in a string
StrLen PROC C
_StrLen:
		pop		eax									; Save the return address
		pop		esi									; Pop first input parameter of WriteCount specifying the address of the buffer being written
		push	eax									; Restore the return address

		; Save other registers' current values
		push	ebx
		push	ecx
		push	edx
		push	edi

		mov		eax, 0								; Set eax to 0 to start character count

_countLoop:											; Start of character counting loop
		cmp		byte ptr [esi + eax], 0				; Check character at esi[eax] for string terminator
		je		_return								; Jump to return if character at esi[eax] is the string terminator
		inc		eax									; Increment character count
		cmp		eax, maxCount						; Compare eax to maxCount
		je		_return								; Jump to return if character count has reached maxCount
		jmp		_countLoop							; Restart the loop

_return:
		; Restore other registers' original values
		pop		edi
		pop		edx
		pop		ecx
		pop		ebx

		ret											; Return from function with eax holding string length
StrLen ENDP ; End of StrLen

; Remove the character at the specified index from a string
StrRemoveAt PROC C
_StrRemoveAt:
		pop		eax									; Save the return address
		pop		esi									; Pop the first input parameter of StrRemoveAt specifying the address of the string
		pop		edx									; Pop the second input parameter of StrRemoveAt specifying the index of the character to remove
		push	eax									; Restore the return address

		; Save other registers' current values
		push	ebx
		push	ecx
		push	edx

		; Store length of the string in edi
		push	esi									; First and only input parameter of StrLen specifying the characters to count
		call	StrLen								; Call StrLen
		mov		edi, eax							; Move eax (return value) into edi

		; Copy everything before index of the string into rmvBuffer
		mov		ecx, 0								; Set ecx to 0 (loop counter/index value)

_beforeLoop:										; Copy up to index of the string into rmvBuffer
		cmp		ecx, edx							; Compare current index (ecx) to index (edx)
		je		_skipIndex							; Jump to skipIndex to copy everything after the index into rmvBuffer
		mov		ebx, [esi + ecx]					; Set ebx to contents of esi[ecx] address
		mov		eax, offset rmvBuffer				; Set eax to rmvBuffer's address
		add		eax, ecx							; Add ecx to eax to move to the current index
		mov		[eax], ebx							; Set contents at eax address to ebx (esi[ecx] address contents)
		
		; Update and check loop counter/index value (ecx)
		inc		ecx									; Increment ecx
		cmp		ecx, maxCount						; Compare ecx to maxCount (max character length)
		je		_return								; Jump to return and return current contents of rmvBuffer, if max character length is reached

		jmp		_beforeLoop							; Restart the beforeLoop

_skipIndex:
		; Skip the removed index
		inc		ecx									; Increment ecx

		; Copy everything after index of the string into rmvBuffer
_afterLoop:											; Copy everything after index of the string into rmvBuffer
		cmp		ecx, edi							; Compare ecx to edi (string length)
		je		_return								; Jump to return if current index equals the string's length
		mov		ebx, [esi + ecx]					; Set ebx to contents of esi[ecx] address
		mov		eax, offset rmvBuffer				; Set eax to rmvBuffer's address
		dec		ecx									; Decrement ecx (to move to proper index of rmvBuffer (skips the removed index))
		add		eax, ecx							; Add ecx to eax to move to the current index
		inc		ecx									; Increment ecx (to return to string's current index)
		mov		[eax], ebx							; Set contents at eax address to ebx (esi[ecx] address contents)
		
		; Update and check loop counter/index value (ecx)
		inc		ecx									; Increment ecx
		cmp		ecx, maxCount						; Compare ecx to maxCount (max character length)
		je		_return								; Jump to return and return current contents of rmvBuffer, if max character length is reached

		jmp		_afterLoop							; Restart afterLoop

_return:

		; Add string terminator in rmvBuffer
		mov		ebx, offset rmvBuffer				; Set ebx to address of rmvBuffer
		add		ebx, ecx							; Add ecx (loop counter/index value) to ebx to move to rmvBuffer[ecx]
		mov		eax, 0								; Set eax to 0 (string terminator)
		mov		[ebx], eax							; Set value at address of ebx to eax

		; Set return value to address of rmvBuffer
		mov		eax, offset rmvBuffer				; Set eax to rmvBuffer's address

		; Restore other registers' original values
		pop		edx
		pop		ecx
		pop		ebx

		ret											; Return from function with eax holding the address to rmvBuffer (the buffer containing string with the specified index removed)
StrRemoveAt ENDP ; End of StrRemoveAt

; Replace the first occurrence of stringA with stringB, if it's found in stringC
StrReplace PROC C
_StrReplace:
		pop		eax									; Save the return address
		pop		edi									; Pop the first input parameter of StrReplace specifying the string that will be replaced
		pop		edx									; Pop the second input parameter of StrReplace specifying the string that will replace the string to be replaced
		pop		esi									; Pop the third input parameter of StrReplace specifying the string containing the string that will be replaced
		push	eax									; Restore the return address

		; Save other registers' current values
		push	ebx
		push	ecx

		; Find starting index of stringA within stringC
		push	edi									; Last input parameter of StrIndexOf specifying the string to search
		push	esi									; First input parameter of StrIndexOf specifying the string to find
		call	StrIndexOf							; Call StrIndexOf
		mov		index, eax							; Store eax (returned index value) in index

		; Save esi string address
		push	esi									; Save the esi string address

		; StrLen(&stringA)
		mov		esi, edi							; Move edi to esi
		push	esi									; First and only input parameter of StrLen specifying the characters to count
		call	StrLen								; Call StrLen
		mov		lenA, eax							; Store return value into lenA

		; StrLen(&stringB)
		mov		esi, edx							; Move edx to esi
		push	esi									; First and only input parameter of StrLen specifying the characters to count
		call	StrLen								; Call StrLen
		mov		lenB, eax							; Store return value into lenB

		; Restore esi string address
		pop		esi									; Restore the esi string address

		; Check the returned index
		mov		eax, index							; Set eax to index
		cmp		eax, -1								; Compare eax (the returned index value) to -1 (string not found return value)
		je		_notfound							; Jump to notfound if the returned index was -1

		; Store stringC (esi) into repBuffer, up to the returned index value
		mov		ecx, 0								; Set ecx to 0 (loop counter/index value)

_beforeLoop:										; Copy up to index of stringC into repBuffer
		cmp		ecx, eax							; Compare current index (ecx) to returned index (eax)
		je		_replace							; Jump to relace to begin replacing stringA with stringB, if ecx == eax (current index == returned index)
		push	eax									; Save returned index (eax)
		mov		ebx, [esi + ecx]					; Set ebx to contents of esi[ecx] address
		mov		eax, offset repBuffer				; Set eax to repBuffer's address
		add		eax, ecx							; Add ecx to eax to move to the current index
		mov		[eax], ebx							; Set contents at eax address to ebx (esi[ecx] address contents)
		pop		eax									; Restore returned index (eax)

		; Update and check loop counter/index value (ecx)
		inc		ecx									; Increment ecx
		cmp		ecx, maxCount						; Compare ecx to maxCount (max character length)
		je		_return								; Jump to return and return current contents of repBuffer, if max character length is reached

		jmp		_beforeLoop							; Restart the beforeLoop

_replace:
		; Store stringB (edx) into repBuffer
		mov		ecx, 0								; Set ecx to 0 (loop counter/index value)

_repLoop:											; Store stringB in repBuffer, replacing stringA that's in stringC at this index
		cmp		ecx, lenB							; Compare current index (ecx) to stringB length
		je		_remaining							; Jump to remaining to store everything after stringA in stringC into repBuffer, if ecx == lenB (current index == stringB length)
		push	eax									; Save returned index (eax)
		mov		ebx, [edx + ecx]					; Set ebx to contents of edx[ecx] address
		mov		eax, offset repBuffer				; Set eax to repBuffer's address
		add		eax, index							; Add index to eax to move to the index to the start of stringA in stringC
		add		eax, ecx							; Add ecx to eax to move to the current index
		mov		[eax], ebx							; Set contents at eax address to ebx (edx[ecx] address contents)
		pop		eax									; Restore returned index (eax)

		; Update and check current index value (index + ecx)
		inc		ecx									; Increment ecx
		mov		ebx, ecx							; Set ebx to ecx
		add		ebx, index							; Add index to ebx
		cmp		ebx, maxCount						; Compare ebx to maxCount (max character length)
		je		_return								; Jump to return and return current contents of repBuffer, if max character length is reached	

		jmp		_repLoop							; Restart the repLoop

_remaining:
		; Store the rest of stringC (after stringA) into repBuffer
		mov		ecx, index							; Set ecx to index (loop counter/index value)
		add		ecx, lenB							; Add stringB's length to ecx (ecx holds repBuffer's current index value, where stringA has been replaced by stringB)

		; Calculate actual current index of stringC (index + lenA)
		mov		ebx, index							; Set ebx to index
		add		ebx, lenA							; Add stringA's length to ebx (since stringA is still in stringC)
		mov		index, ebx							; Set index to ebx

_afterLoop:
		mov		ebx, 0								; Set ebx to 0 (string terminator)
		cmp		ebx, [esi + index]					; Compare contents of current stringC index to ebx
		je		_return								; Jump to return if the end of stringC has been reached
		mov		ebx, [esi + index]					; Set ebx to contents of esi[index] address
		mov		eax, offset repBuffer				; Set eax to repBuffer's address
		add		eax, ecx							; Add ecx to eax to move to the current index of repBuffer
		mov		[eax], ebx							; Set contents at eax address to ebx (esi[index] address contents)

		; Update and check current index values (index + lenB + ecx)
		inc		ecx									; Increment ecx
		inc		index								; Increment index
		mov		ebx, ecx							; Set ebx to ecx
		add		ebx, index							; Add index to ebx
		cmp		ebx, maxCount						; Compare ebx to maxCount (max character length)
		je		_return								; Jump to return and return current contents of repBuffer, if max character length is reached	

		jmp		_afterLoop							; Restart the afterLoop

_notfound:											; If stringA was not found in stringC
		; Store all of esi in repBuffer
		mov		ecx, 0								; Set ecx to 0 (loop counter/index value)

_copyLoop:											; Copy contents of address esi to repBuffer
		; Copy unchanged stringC (esi) to repBuffer
		cmp		byte ptr [esi + ecx], 0				; Check character at edi[ecx] for string terminator
		je		_return								; Jump to return if character at esi[ecx] is the string terminator
		mov		ebx, [esi + ecx]					; Set ebx to contents of esi[ecx] address
		mov		eax, offset repBuffer				; Set eax to repBuffer's address
		add		eax, ecx							; Add ecx to eax to move to the current index
		mov		[eax], ebx							; Set contents at eax address to ebx (esi[ecx] address contents)

		; Update and check loop counter/index value (ecx)
		inc		ecx									; Increment ecx
		cmp		ecx, maxCount						; Compare ecx to maxCount (max character length)
		je		_return								; Jump to return and return current contents of repBuffer, if max character length is reached

		jmp		_copyLoop							; Restart the copyLoop
		
_return:
		; Add string terminator in repBuffer
		mov		ebx, offset repBuffer				; Set ebx to address of subBuffer
		add		ebx, ecx							; Add ecx (loop counter/index value) to ebx to move to repBuffer[ecx]
		mov		eax, 0								; Set eax to 0 (string terminator)
		mov		[ebx], eax							; Set value at address of ebx to eax

		; Set return value to address of repBuffer
		mov		eax, offset repBuffer				; Set eax to repBuffer's address

		; Restore other registers' original values
		pop		ecx
		pop		ebx

		ret											; Return from function with eax holding the address to repBuffer (the buffer containing stringC with stringA replaced by stringB)
StrReplace ENDP ; End of StrReplace

; Return a substring of the specified string from the specified start index to the specified end index
StrSub PROC C
_StrSub:
		pop		eax									; Save the return address
		pop		edx									; Pop the first input parameter of StrSub specifying the start index value (inclusive)
		pop		ecx									; Pop the second input parameter of StrSub specifying the end index value (exclusive)
		pop		esi									; Pop the third input parameter of StrSub specifying the address of the string
		push	eax									; Restore the return address

		; Save other registers' current values
		push	ebx
		push	edi

		; Get length of input string
		push	esi									; First and only input parameter of StrLen specifying the characters to count
		call	StrLen								; Call StrLen
		mov		len, eax							; Store return value into len

		; Initialize index and return value
		mov		index, 0							; Set index to 0
		mov		eax, 0								; Set eax to 0 (null memory address)

		; Check start and end indices
		cmp		edx, ecx							; Compare edx (start index) and ecx (end index)
		jge		_return								; Jump to return if edx >= ecx (returns null memory address)
		cmp		edx, len							; Compare edx (start index) and len
		jge		_return								; Jump to return if edx >= len (return null memory address)
		cmp		ecx, len							; Compare ecx (end index) and len
		jg		_return								; Jump to return if ecx > len (return null memory address)

		; Loop from start index to end index - 1
_subLoop:											; Loop over specified indices
		; Set subBuffer to input string[start..end)
		mov		edi, offset subBuffer				; Set edi to address of subBuffer
		add		edi, index							; Add index to edi to move to index of subBuffer
		mov		ebx, esi							; Set edx to esi (input string address)
		add		ebx, edx							; Add edx (start index address offset) to ebx (input string address)
		mov		eax, [ebx]							; Move contents of address ebx to eax
		mov		[edi], eax							; Move eax to address of edi

		; Update and check index
		inc		index								; Increment index
		mov		ebx, index							; Set ebx to index
		cmp		ebx, maxCount						; Compare ebx to maxCount (max character length)
		je		_endLoop							; Jump to endLoop and return current contents of subBuffer

		; Update loop counter/start index (edx)
		inc		edx									; Increment edx (start index)
		cmp		edx, ecx							; Compare edx (start index) and ecx (end index)
		jl		_subLoop							; Restart subLoop if edx < ecx 

_endLoop:
		; Add string terminator to subBuffer
		mov		edi, offset subBuffer				; Set edi to address of subBuffer
		add		edi, index							; Add index to edi to move to index of subBuffer
		mov		eax, 0								; Set eax to 0 (string terminator)
		mov		[edi], eax							; Set value at address of edi to eax

		; Set return value to address of subBuffer
		mov		eax, offset subBuffer				; Set eax to address of subBuffer

_return:
		; Restore other registers' original values
		pop		edi
		pop		ebx

		ret											; Return from function with eax holding the address to subBuffer (the buffer containing the substring)
StrSub ENDP ; End of StrSub
end