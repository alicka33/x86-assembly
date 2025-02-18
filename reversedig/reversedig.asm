;-------------------------------------------------------------------------------
; EBX, EDI, ESI, EBP - have to be saved in fuction!!!
;-------------------------------------------------------------------------------

section .text
global reversedig

reversedig:
    ; eax - text
    ; edx - answer
    ; ecx - numbers
    ; bl - read char
    ; bh - helper

    push ebp
    mov ebp, esp

    push ebx

    mov eax, [ebp+8]
    mov edx, eax
    mov ecx, eax

find_num:
    mov bl, [eax]
    inc eax

    cmp bl, 0
    jz prepare_store_num

    cmp bl, '0'
    jl find_num
    cmp bl, '9'
    jg find_num

    mov [ecx], bl
    inc ecx
    jmp find_num

prepare_store_num:
    mov bh, 0
    mov [ecx], bh
    dec ecx
    mov eax, edx

store_num:
    mov bl, [eax]
    inc eax              ; popraw to zwiększanie 

    cmp bl, 0
    jz end
    
    cmp bl, '0'
    jl store_num
    cmp bl, '9'
    jg store_num

    mov bh, [ecx]
    mov [edx], bh
    dec ecx
    jmp store_num

end:
    mov eax, edx        ;wyróbowuje 
    pop ebx
    pop ebp
    ret