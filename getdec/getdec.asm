section .text
global getdec

getdec:
    ; eax - text
    ; ecx - num string
    ; ecx - unsigned 
    ; bl - read char

    push ebp
    mov ebp, esp

    push ebx

    mov eax, [ebp+8]
    mov ecx, 0

search_num:
    mov bl, [eax]
    inc eax

    test bl, bl
    jz end

    cmp bl, '0'
    jl search_num
    cmp bl, '9'
    jg search_num

    jmp save_num

save_num:
    sub bl, '0'
    imul ecx, 10
    movzx ebx, bl
    add ecx, ebx

    mov bl, [eax]
    inc eax

    test bl, bl
    jz end

    cmp bl, '0'
    jl end
    cmp bl, '9'
    jg end

    jmp save_num

end:
    mov eax, ecx
    pop ebx
    pop ebp
    ret 