;=====================================================================
; ARKO - example Intel x86 assembly program
;
; author:      Rajmund Kozuszek
; date:        2023.03.31
; description: x86 (32-bit) - function modifying the input string 
;					int removerng(char* nts_buffer, char low, char high);
;				removes all characters in range <low, high> from 
;				the input string
;				returns the pointer to the input buffer
;-------------------------------------------------------------------------------
; EBX, EDI, ESI, EBP - have to be saved in fuction!!!
;-------------------------------------------------------------------------------

section	.text
global  removerng

removerng:
; eax - wskazanie (adres) odczytu
; edx - wskazanie (adres) zapisu
; cl - znak dolny (low)
; ch - znak górny (high)
; bl - znak odczytany z ciągu

	push	ebp			; wskaźnik ramki zawsze musi zostać zapamiętany --> nie możę się zmienić w wyniku działania funckji wewnętrznych
	mov	ebp, esp		; przeniesienie do ebp aktualnego wskaźnika stosu 

	push ebx			; jest to jeden z tych rejestrów, których jak chcemy używać w funkcji to musimy zapisać na stosie (polecenie push)

	mov	eax, [ebp+8]	; address of character buffer to eax
	mov edx, eax
	mov cl, [ebp+12]	; read low parameter
	mov ch, [ebp+16]	; read high parameter

remove_loop:
	mov bl, [eax]		; załadowanie do bl pierwszego znaku ciagu eax (wczytywanego słowa)
	inc eax				; eax++ --> równoznaczny z add eax, 1

	; jump if lower then
	; jl bl, cl, save_char  --> nie wykona się, potrzebujemy flag i jl save_char
	cmp bl, cl			; ustawnienie flag (będzie porównywał bl do cl)
	jl save_char
	
	cmp bl, ch
	jle remove_loop

; taki niekonwencjonalny sposób (skoro dwa poprzednie się nie wykonały to przejdziemy automatyzcnie do save_char --> dla tych większych od high)
save_char:
	mov [edx], bl
	inc edx
	;jmp remove_loop 	; jmp skok bezwarunkowy
	test bl, bl			; test liczy iloczyn bitowy argumentów 0 tylko gdy oba są 0
	jnz remove_loop

	mov	eax, [ebp+8]	; return character buffer address
	pop ebx				; jak coś pushujemy to musimy to też popować --> wróić do właściwego miejsca na stosie 
	pop	ebp
	ret


;
;============================================
; THE STACK - thanks to Zbigniew Szymanski
;============================================
;
; larger addresses
; 
;  |                               |
;  | ...                           |
;  ---------------------------------
;  | function parameter - char high| EBP+16
;  ---------------------------------
;  | function parameter - char low | EBP+12
;  ---------------------------------
;  | function parameter - char *nts| EBP+8
;  ---------------------------------
;  | return address                | EBP+4
;  ---------------------------------
;  | saved ebp                     | EBP, ESP
;  ---------------------------------
;  | ... here local variables      | EBP-x
;  |     when needed               |
;
; \/                              \/
; \/ the stack grows in this      \/
; \/ direction                    \/
;
; lower addresses
;
;
;============================================
