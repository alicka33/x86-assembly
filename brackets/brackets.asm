section .text
global brackets

brackets:
    ; eax - text
    ; edx - answer
    ; bl - read char
    ; bh - lenght
    ; ebx - return lenght

    push ebp
    mov ebp, esp

    push ebx
    mov eax, [ebp+8]
    mov edx, eax
    mov bh, 0

find_opening:
    mov bl, [eax]
    inc eax

    test bl, bl
    jz end

    cmp bl, '['
    je save

    jmp find_opening

save:
    mov bl, [eax]
    inc eax
    
    mov [edx], bl
    inc edx

    test bl, bl
    jz end

    cmp bl, ']'
    je end

    inc bh
    jmp save

end:
    mov [edx], bl
    movzx ebx, bh
    mov eax, ebx
    pop ebx
    pop ebp
    ret


