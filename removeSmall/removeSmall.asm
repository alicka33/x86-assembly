section .text
global removeSmall

removeSmall:
    ; eax - text
    ; edx - text with removed small letters 
    ; bl - read char
    ; bh - lenght

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

    cmp bl, 'a'
    jl save
    cmp bl, 'z'
    jg save

    jmp iterate

save:
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