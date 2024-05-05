; Monroe Gordon
; April, 23, 2024
; Eliza
; reply.asm - Contains functions and data for replying to a user's input.

.386P
.model flat	

; Program data
.data
reply				dword	112			DUP(00h)	; Reply array

; Replies
r1					byte	"DON'T YOU BELIEVE THAT I CAN*", 0
r2					byte	"PERHAPS YOU WOULD LIKE TO BE LIKE ME*", 0
r3					byte	"YOU WANT ME TO BE ABLE TO*", 0
r4					byte	"PERHAPS YOU DON'T WANT TO*", 0
r5					byte	"DO YOU WANT TO BE ABLE TO*", 0
r6					byte	"WHAT MAKES YOU THINK I AM*", 0
r7					byte	"DOES IT PLEASE YOU TO BELIEVE I AM*", 0
r8					byte	"PERHAPS YOU WOULD LIKE TO BE*", 0
r9					byte	"DO YOU SOMETIMES WISH YOU WERE*", 0
r10					byte	"DON'T YOU REALLY*", 0
r11					byte	"WHY DON'T YOU*", 0
r12					byte	"DO YOU WISH TO BE ABLE TO*", 0
r13					byte	"DOES THAT TROUBLE YOU*", 0
r14					byte	"DO YOU OFTEN FEEL*", 0
r15					byte	"DO YOU OFTEN FEEL*", 0
r16					byte	"DO YOU ENJOY FEELING*", 0
r17					byte	"DO YOU REALLY BELIEVE I DON'T*", 0
r18					byte	"PERHAPS IN GOOD TIME I WILL*", 0
r19					byte	"DO YOU WANT ME TO*", 0
r20					byte	"DO YOU THINK YOU SHOULD BE ABLE TO*", 0
r21					byte	"WHY CAN'T YOU*", 0
r22					byte	"WHY ARE YOU INTERESTED IN WHETHER OR NOT I AM*", 0
r23					byte	"WOULD YOU PREFER IF I WERE NOT*", 0
r24					byte	"PERHAPS IN YOUR FANTASIES I AM*", 0
r25					byte	"HOW DO YOU KNOW YOU CAN'T*", 0
r26					byte	"HAVE YOU TRIED?", 0
r27					byte	"PERHAPS YOU CAN NOW*", 0
r28					byte	"DID YOU COME TO ME BECAUSE YOU ARE*", 0
r29					byte	"HOW LONG HAVE YOU BEEN*", 0
r30					byte	"DO YOU BELIEVE IT IS NORMAL TO BE*", 0
r31					byte	"DO YOU ENJOY BEING*", 0
r32					byte	"WE WERE DISCUSSING YOU--NOT ME.", 0
r33					byte	"OH, I*", 0
r34					byte	"YOU'RE NOT REALLY TALKING ABOUT ME, ARE YOU?", 0
r35					byte	"WHAT WOULD IT MEAN TO YOU IF YOU GOT*", 0
r36					byte	"WHY DO YOU WANT*", 0
r37					byte	"SUPPOSE YOU SOON GOT*", 0
r38					byte	"WHAT IF YOU NEVER GOT*", 0
r39					byte	"I SOMETIMES ALSO WANT*", 0
r40					byte	"WHY DO YOU ASK?", 0
r41					byte	"DOES THAT QUESTION INTEREST YOU?", 0
r42					byte	"WHAT ANSWER WOULD PLEASE YOU THE MOST?", 0
r43					byte	"WHAT DO YOU THINK?", 0
r44					byte	"ARE SUCH QUESTIONS ON YOUR MIND OFTEN?", 0
r45					byte	"WHAT IS IT THAT YOU REALLY WANT TO KNOW?", 0
r46					byte	"HAVE YOU ASKED ANYONE ELSE?", 0
r47					byte	"HAVE YOU ASKED SUCH QUESTIONS BEFORE?", 0
r48					byte	"WHAT ELSE COMES TO MIND WHEN YOU ASK THAT?", 0
r49					byte	"NAMES DON'T INTEREST ME.", 0
r50					byte	"I DON'T CARE ABOUT NAMES--PLEASE GO ON.", 0
r51					byte	"IS THAT THE REAL REASON?", 0
r52					byte	"DON'T ANY OTHER REASONS COME TO MIND?", 0
r53					byte	"DOES THAT REASON EXPLAIN ANYTHING ELSE?", 0
r54					byte	"WHAT OTHER REASONS MIGHT THERE BE?", 0
r55					byte	"PLEASE DON'T APOLOGIZE!", 0
r56					byte	"APOLOGIES ARE NOT NECESSARY.", 0
r57					byte	"WHAT FEELINGS DO YOU HAVE WHEN YOU APOLOGIZE?", 0
r58					byte	"DON'T BE SO DEFENSIVE!", 0
r59					byte	"WHAT DOES THAT DREAM SUGGEST TO YOU?", 0
r60					byte	"DO YOU DREAM OFTEN?", 0
r61					byte	"WHAT PERSONS APPEAR IN YOUR DREAMS?", 0
r62					byte	"ARE YOU DISTURBED BY YOUR DREAMS?", 0
r63					byte	"HOW DO YOU DO...PLEASE STATE YOUR PROBLEM.", 0
r64					byte	"YOU DON'T SEEM QUITE CERTAIN.", 0
r65					byte	"WHY THE UNCERTAIN TONE?", 0
r66					byte	"CAN'T YOU BE MORE POSITIVE?", 0
r67					byte	"YOU AREN'T SURE?", 0
r68					byte	"DON'T YOU KNOW?", 0
r69					byte	"ARE YOU SAYING NO JUST TO BE NEGATIVE?", 0
r70					byte	"YOU ARE BEING A BIT NEGATIVE.", 0
r71					byte	"WHY NOT?", 0
r72					byte	"ARE YOU SURE?", 0
r73					byte	"WHY NO?", 0
r74					byte	"WHY ARE YOU CONCERNED ABOUT MY*", 0
r75					byte	"WHAT ABOUT YOUR OWN*", 0
r76					byte	"CAN YOU THINK OF A SPECIFIC EXAMPLE?", 0
r77					byte	"WHEN?", 0
r78					byte	"WHAT ARE YOU THINKING OF?", 0
r79					byte	"REALLY, ALWAYS?", 0
r80					byte	"DO YOU REALLY THINK SO?", 0
r81					byte	"BUT YOU ARE NOT SURE YOU*", 0
r82					byte	"DO YOU DOUBT YOU*", 0
r83					byte	"IN WHAT WAY?", 0
r84					byte	"WHAT RESEMBLANCE DO YOU SEE?", 0
r85					byte	"WHAT DOES THE SIMILARITY SUGGEST TO YOU?", 0
r86					byte	"WHAT OTHER CONNECTIONS DO YOU SEE?", 0
r87					byte	"COULD THERE REALLY BE SOME CONNECTION?", 0
r88					byte	"HOW?", 0
r89					byte	"YOU SEEM QUITE POSITIVE.", 0
r90					byte	"ARE YOU SURE?", 0
r91					byte	"I SEE.", 0
r92					byte	"I UNDERSTAND.", 0
r93					byte	"WHY DO YOU BRING UP THE TOPIC OF FRIENDS?", 0
r94					byte	"DO YOUR FRIENDS WORRY YOU?", 0
r95					byte	"DO YOUR FRIENDS PICK ON YOU?", 0
r96					byte	"ARE YOU SURE YOU HAVE ANY FRIENDS?", 0
r97					byte	"DO YOU IMPOSE ON YOUR FRIENDS?", 0
r98					byte	"PERHAPS YOUR LOVE FOR FRIENDS WORRIES YOU.", 0
r99 				byte	"DO COMPUTERS WORRY YOU?", 0
r100				byte	"ARE YOU TALKING ABOUT ME IN PARTICULAR?", 0
r101				byte	"ARE YOU FRIGHTENED BY MACHINES?", 0
r102				byte	"WHY DO YOU MENTION COMPUTERS?", 0
r103				byte	"WHAT DO YOU THINK MACHINES HAVE TO DO WITH YOUR PROBLEM?", 0
r104				byte	"DON'T YOU THINK COMPUTERS CAN HELP PEOPLE?", 0
r105				byte	"WHAT IS IT ABOUT MACHINES THAT WORRIES YOU?", 0
r106				byte	"SAY, DO YOU HAVE ANY PSYCHOLOGICAL PROBLEMS?", 0
r107				byte	"WHAT DOES THAT SUGGEST TO YOU?", 0
r108				byte	"I SEE.", 0
r109				byte	"I'M NOT SURE I UNDERSTAND YOU FULLY.", 0
r110				byte	"COME COME ELUCIDATE YOUR THOUGHTS.", 0
r111				byte	"CAN YOU ELABORATE ON THAT?", 0
r112				byte	"THAT IS QUITE INTERESTING.", 0

; Program code
.code
; Initialize reply array
InitReply PROC C
_InitReply:
	mov		ebx, offset reply						; Store address of reply array in ebx
	mov		[ebx], offset r1						; Store r1 in reply array
	mov		[ebx + 4], offset r2					; Store r2 in reply array
	mov		[ebx + 2 * 4], offset r3				; Store r3 in reply array
	mov		[ebx + 3 * 4], offset r4				; Store r4 in reply array
	mov		[ebx + 4 * 4], offset r5				; Store r5 in reply array
	mov		[ebx + 5 * 4], offset r6				; Store r6 in reply array
	mov		[ebx + 6 * 4], offset r7				; Store r7 in reply array
	mov		[ebx + 7 * 4], offset r8				; Store r8 in reply array
	mov		[ebx + 8 * 4], offset r9				; Store r9 in reply array
	mov		[ebx + 9 * 4], offset r10				; Store r10 in reply array
	mov		[ebx + 10 * 4], offset r11				; Store r11 in reply array
	mov		[ebx + 11 * 4], offset r12				; Store r12 in reply array
	mov		[ebx + 12 * 4], offset r13				; Store r13 in reply array
	mov		[ebx + 13 * 4], offset r14				; Store r14 in reply array
	mov		[ebx + 14 * 4], offset r15				; Store r15 in reply array
	mov		[ebx + 15 * 4], offset r16				; Store r16 in reply array
	mov		[ebx + 16 * 4], offset r17				; Store r17 in reply array
	mov		[ebx + 17 * 4], offset r18				; Store r18 in reply array
	mov		[ebx + 18 * 4], offset r19				; Store r19 in reply array
	mov		[ebx + 19 * 4], offset r20				; Store r20 in reply array
	mov		[ebx + 20 * 4], offset r21				; Store r21 in reply array
	mov		[ebx + 21 * 4], offset r22				; Store r22 in reply array
	mov		[ebx + 22 * 4], offset r23				; Store r23 in reply array
	mov		[ebx + 23 * 4], offset r24				; Store r24 in reply array
	mov		[ebx + 24 * 4], offset r25				; Store r25 in reply array
	mov		[ebx + 25 * 4], offset r26				; Store r26 in reply array
	mov		[ebx + 26 * 4], offset r27				; Store r27 in reply array
	mov		[ebx + 27 * 4], offset r28				; Store r28 in reply array
	mov		[ebx + 28 * 4], offset r29				; Store r29 in reply array
	mov		[ebx + 29 * 4], offset r30				; Store r30 in reply array
	mov		[ebx + 30 * 4], offset r31				; Store r31 in reply array
	mov		[ebx + 31 * 4], offset r32				; Store r32 in reply array
	mov		[ebx + 32 * 4], offset r33				; Store r33 in reply array
	mov		[ebx + 33 * 4], offset r34				; Store r34 in reply array
	mov		[ebx + 34 * 4], offset r35				; Store r35 in reply array
	mov		[ebx + 35 * 4], offset r36				; Store r36 in reply array
	mov		[ebx + 36 * 4], offset r37				; Store r37 in reply array
	mov		[ebx + 37 * 4], offset r38				; Store r38 in reply array
	mov		[ebx + 38 * 4], offset r39				; Store r39 in reply array
	mov		[ebx + 39 * 4], offset r40				; Store r40 in reply array
	mov		[ebx + 40 * 4], offset r41				; Store r41 in reply array
	mov		[ebx + 41 * 4], offset r42				; Store r42 in reply array
	mov		[ebx + 42 * 4], offset r43				; Store r43 in reply array
	mov		[ebx + 43 * 4], offset r44				; Store r44 in reply array
	mov		[ebx + 44 * 4], offset r45				; Store r45 in reply array
	mov		[ebx + 45 * 4], offset r46				; Store r46 in reply array
	mov		[ebx + 46 * 4], offset r47				; Store r47 in reply array
	mov		[ebx + 47 * 4], offset r48				; Store r48 in reply array
	mov		[ebx + 48 * 4], offset r49				; Store r49 in reply array
	mov		[ebx + 49 * 4], offset r50				; Store r50 in reply array
	mov		[ebx + 50 * 4], offset r51				; Store r51 in reply array
	mov		[ebx + 51 * 4], offset r52				; Store r52 in reply array
	mov		[ebx + 52 * 4], offset r53				; Store r53 in reply array
	mov		[ebx + 53 * 4], offset r54				; Store r54 in reply array
	mov		[ebx + 54 * 4], offset r55				; Store r55 in reply array
	mov		[ebx + 55 * 4], offset r56				; Store r56 in reply array
	mov		[ebx + 56 * 4], offset r57				; Store r57 in reply array
	mov		[ebx + 57 * 4], offset r58				; Store r58 in reply array
	mov		[ebx + 58 * 4], offset r59				; Store r59 in reply array
	mov		[ebx + 59 * 4], offset r60				; Store r60 in reply array
	mov		[ebx + 60 * 4], offset r61				; Store r61 in reply array
	mov		[ebx + 61 * 4], offset r62				; Store r62 in reply array
	mov		[ebx + 62 * 4], offset r63				; Store r63 in reply array
	mov		[ebx + 63 * 4], offset r64				; Store r64 in reply array
	mov		[ebx + 64 * 4], offset r65				; Store r65 in reply array
	mov		[ebx + 65 * 4], offset r66				; Store r66 in reply array
	mov		[ebx + 66 * 4], offset r67				; Store r67 in reply array
	mov		[ebx + 67 * 4], offset r68				; Store r68 in reply array
	mov		[ebx + 68 * 4], offset r69				; Store r69 in reply array
	mov		[ebx + 69 * 4], offset r70				; Store r70 in reply array
	mov		[ebx + 70 * 4], offset r71				; Store r71 in reply array
	mov		[ebx + 71 * 4], offset r72				; Store r72 in reply array
	mov		[ebx + 72 * 4], offset r73				; Store r73 in reply array
	mov		[ebx + 73 * 4], offset r74				; Store r74 in reply array
	mov		[ebx + 74 * 4], offset r75				; Store r75 in reply array
	mov		[ebx + 75 * 4], offset r76				; Store r76 in reply array
	mov		[ebx + 76 * 4], offset r77				; Store r77 in reply array
	mov		[ebx + 77 * 4], offset r78				; Store r78 in reply array
	mov		[ebx + 78 * 4], offset r79				; Store r79 in reply array
	mov		[ebx + 79 * 4], offset r80				; Store r80 in reply array
	mov		[ebx + 80 * 4], offset r81				; Store r81 in reply array
	mov		[ebx + 81 * 4], offset r82				; Store r82 in reply array
	mov		[ebx + 82 * 4], offset r83				; Store r83 in reply array
	mov		[ebx + 83 * 4], offset r84				; Store r84 in reply array
	mov		[ebx + 84 * 4], offset r85				; Store r85 in reply array
	mov		[ebx + 85 * 4], offset r86				; Store r86 in reply array
	mov		[ebx + 86 * 4], offset r87				; Store r87 in reply array
	mov		[ebx + 87 * 4], offset r88				; Store r88 in reply array
	mov		[ebx + 88 * 4], offset r89				; Store r89 in reply array
	mov		[ebx + 89 * 4], offset r90				; Store r90 in reply array
	mov		[ebx + 90 * 4], offset r91				; Store r91 in reply array
	mov		[ebx + 91 * 4], offset r92				; Store r92 in reply array
	mov		[ebx + 92 * 4], offset r93				; Store r93 in reply array
	mov		[ebx + 93 * 4], offset r94				; Store r94 in reply array
	mov		[ebx + 94 * 4], offset r95				; Store r95 in reply array
	mov		[ebx + 95 * 4], offset r96				; Store r96 in reply array
	mov		[ebx + 96 * 4], offset r97				; Store r97 in reply array
	mov		[ebx + 97 * 4], offset r98				; Store r98 in reply array
	mov		[ebx + 98 * 4], offset r99				; Store r99 in reply array
	mov		[ebx + 99 * 4], offset r100				; Store r100 in reply array
	mov		[ebx + 100 * 4], offset r101			; Store r101 in reply array
	mov		[ebx + 101 * 4], offset r102			; Store r102 in reply array
	mov		[ebx + 102 * 4], offset r103			; Store r103 in reply array
	mov		[ebx + 103 * 4], offset r104			; Store r104 in reply array
	mov		[ebx + 104 * 4], offset r105			; Store r105 in reply array
	mov		[ebx + 105 * 4], offset r106			; Store r106 in reply array
	mov		[ebx + 106 * 4], offset r107			; Store r107 in reply array
	mov		[ebx + 107 * 4], offset r108			; Store r108 in reply array
	mov		[ebx + 108 * 4], offset r109			; Store r109 in reply array
	mov		[ebx + 109 * 4], offset r110			; Store r110 in reply array
	mov		[ebx + 110 * 4], offset r111			; Store r111 in reply array
	mov		[ebx + 111 * 4], offset r112			; Store r112 in reply array

	ret												; Return from function, no return value
InitReply ENDP ; End of InitReply

; Get the reply string at the specified index value
GetReply PROC C
_GetReply:
	pop		eax										; Save return address
	pop		edx										; Pop first input parameter of GetReply
	push	eax										; Restore return address

	mov		ebx, offset reply						; Store the address of the reply array in ebx
	mov		eax, 4									; Set eax to 4
	mul		edx										; Multiply edx (index value) by eax (4) and store in eax
	add		eax, ebx								; Add ebx (reply array address) to eax (index offset value) to obtain address of requested index

	ret												; Return from function with eax holding the address to the requested reply array index
GetReply ENDP ; End of GetReply
end