section .text
global leavelastndig

; consider errors

leavelastndig:
; eax - text
; edx - ostatnie n znaków telstu
; cl - n
; ch - licznik
; bl - wczytywane słowo
; bh - indeks

    push ebp
    mov ebp, esp

    push ebx

    mov eax, [ebp+8]
    mov edx, eax
    mov cl, [ebp+12]
    mov ch, 0

counting_lengh:
    mov bl, [eax]
    
    cmp bl, 0
    jz caluclate_position

    add ch, 1
    inc eax
    jmp counting_lengh

caluclate_position:
    mov eax, edx        ;powrót wskaznikiem
    sub ch, cl
    mov bh, ch
    add bh, 1
    mov ch, 0

find_postion:
    mov bl, [eax]
    inc eax
    add ch, 1

    cmp ch, bh
    je save_postion

    jmp find_postion

save_postion:
    mov [edx], bl
    inc edx

    cmp bl, 0
    jz end

    mov bl, [eax]
    inc eax
    jmp save_postion

end:
    mov eax, [ebp+8]
    pop ebx
    pop ebp
    ret