section .text
global leaverng

leaverng:
    ; eax - tekst
    ; edx - wynik
    ; cl - lower
    ; ch - high
    ; bl - iterowane słowo

    push ebp
    mov ebp, esp

    push ebx

    mov eax, [ebp+8]
    mov edx, eax
    mov cl, [ebp+12]
    mov ch, [ebp+16]

iterate:
    mov bl, [eax]
    inc eax

    cmp bl, 0
    jz save

    cmp bl, cl
    jl iterate
    
    cmp bl, ch
    jg iterate

    jmp save

save:
    mov [edx], bl
    inc edx

    cmp bl, 0
    jz end

    jmp iterate

end:
    mov eax, [ebp+8]
    pop ebx
    pop ebp
    ret