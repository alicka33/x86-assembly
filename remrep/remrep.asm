global remrep

section .text

remrep:
    push ebp
    mov ebp, esp
    push ebx       ; konwencja
    mov eax, [ebp+8]    ;char* s -> eax
    mov edx, eax    ; edx - zapisywanie
    mov ebx, eax    ; ebx - iteracja

check: 
    mov ch, [eax]   ; zapisanie do ch znaku z eax
    cmp ch, 0    
    je save          ; skok do end jesli to ostatni znak
    inc eax         
    mov ebx, [ebp+8]    ; reset ebx

loop_:
    cmp edx, ebx    
    je save        
    cmp ch, [ebx]  
    je check
    inc ebx
    jmp loop_

save: ;save char to edx
    mov [edx], ch
    inc edx
    cmp ch, 0
    jne check

end:
    sub eax, edx
    inc eax
    pop ebx
    pop ebp
    ret
