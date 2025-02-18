section .text
global capwords

capwords:
    ; eax - text
    ; edx - answer
    ; bl - read char
    ; bh - next char
    ; cl - 'a' - 'A'
    ; ch - first_ind

    push ebp
    mov ebp, esp

    push ebx

    mov eax, [ebp+8]
    mov edx, eax
    mov cl, 'a'
    sub cl, 'A'
    mov ch, 0

seek_space:
    mov bl, [eax]
    inc eax

    mov [edx], bl
    inc edx

    cmp bl, 0
    jz end

    cmp ch, 0
    jz check_letter

    cmp bl, ' '
    je check_letter

    jmp seek_space

check_letter:
    mov ch, 1
    
    mov bh, [eax]

    cmp bh, 'a'
    jl seek_space
    cmp bh, 'z'
    jg seek_space

    sub bh, cl
    mov [edx], bh

    jmp seek_space

end:
    mov eax, edx
    pop ebx
    pop ebp
    ret