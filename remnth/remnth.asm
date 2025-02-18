section .text
global remnth

remnth:
; eax - text
; edx - text po usunięciu 
; cl - ilość co którą będziemy skakać
; ch - licznik
; bl - odczytywany char

    push ebp
    mov ebp, esp 

    push ebx

    mov eax, [ebp+8]
    mov edx, eax
    mov cl, [ebp+12]
    mov ch, 1

remove_loop:
    mov bl, [eax]
    inc eax

    test bl, bl
    jz end

    cmp ch, cl
    je skip

    add ch, 1
    mov [edx], bl
    inc edx
    jmp remove_loop

skip:
    mov ch, 1
    jmp remove_loop

end:
    mov [edx], bl
    
    mov eax, [ebp+8]
    
    pop ebx
    pop ebp
    ret

    