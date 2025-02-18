section .text
global growing

growing:
    ; eax - text
    ; edx - answer
    ; bl - read string
    ; bh - biggest

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

    cmp bl, bh
    jg store

    jmp iterate

store:
    mov [edx], bl
    inc edx
    mov bh, bl
    jmp iterate

end:
    mov [edx], bl
    mov eax, [ebp+8]
    pop ebx
    pop ebp
    ret