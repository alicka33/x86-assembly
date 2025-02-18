section .text 
global replnum

replnum:
    ; eax - text
    ; edx - answer
    ; cl - char to change
    ; bl - read char

    push ebp
    mov ebp, esp

    push ebx

    mov eax, [ebp+8]
    mov edx, eax
    mov cl, [ebp+12]

find_numbers:
    mov bl, [eax]
    inc eax

    cmp bl, 0
    jz end

    cmp bl, '0'
    jl save_char
    cmp bl, '9'
    jg save_char

    jmp replace

save_char:
    mov [edx], bl
    inc edx
    jmp find_numbers

replace:
    mov bl, [eax]
    inc eax

    cmp bl, 0
    jz ending

    cmp bl, '0'
    jl ending
    cmp bl, '9'
    jg ending

    jmp replace

ending:
    mov bl, cl
    dec eax
    jmp save_char

end:
    mov [edx], bl
    mov eax, [ebp+8]
    pop ebx
    pop ebp
    ret