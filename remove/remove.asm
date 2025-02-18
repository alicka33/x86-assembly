section .text
global remove

remove:
    ; eax - text
    ; edx - answer
    ; bl - read char
    ; bh - counter
    ; ebx - lenght

    push ebp
    mov ebp, esp

    push ebx
    mov eax, [ebp+8]
    mov edx, eax
    mov bh, 0

iterate:
    mov bl, [eax]
    inc eax

    test bl, bl
    jz end

    cmp bl, 'A'
    jl iterate
    cmp bl, 'Z'
    jg iterate

save_letter:
    mov [edx], bl
    inc edx
    inc bh
    jmp iterate

end: 
    mov [edx], bl
    movzx ebx, bh
    mov eax, ebx
    pop ebx
    pop ebp
    ret