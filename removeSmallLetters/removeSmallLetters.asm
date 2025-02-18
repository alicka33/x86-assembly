section .text
global removeSmallLetters

removeSmallLetters:
    ; edx - text
    ; eax - text with removed small letters 
    ; cl - read char

    push ebp
    mov ebp, esp

    mov edx, [ebp+8]
    mov eax, edx

iterate:
    mov cl, [edx]
    inc edx

    cmp cl, 'a'
    jl save
    cmp cl, 'z'
    jle iterate

save:
    mov [eax], cl
    inc eax

    test cl, cl
    jnz iterate

end:
    dec eax
    sub eax, [ebp+8]
    pop ebp
    ret