section .text
global reverselet

reverselet:
    ; eax - text
    ; edx - answer 
    ; ecx - letters
    ; bl - read char

    push ebp
    mov ebp, esp

    push ebx

    mov eax, [ebp+8]   ;;; ewentualnie jeszcze jako eax <--> ecx 
    mov ecx, eax
    mov edx, eax

find_letters:
    mov bl, [eax]
    inc eax

    cmp bl, 0
    jz prepere_change_letters

    cmp bl, 'A'
    jl find_letters
    cmp bl, 'Z'
    jg search_small

    jmp store_letter

search_small:
    cmp bl, 'a'
    jl find_letters
    cmp bl, 'z'
    jg find_letters

    jmp store_letter

store_letter:
    mov [ecx], bl
    inc ecx
    jmp find_letters

prepere_change_letters:
    mov [ecx], bl
    dec ecx         ; jesteśmy teraz na ostatniej literze
    mov eax, edx
    
change_letters:
    mov bl, [eax]
    inc eax

    cmp bl, 0
    jz end

    cmp bl, 'A'
    jl store_char
    cmp bl, 'Z'
    jg search_small_store

    jmp store_char_letter

search_small_store:
    cmp bl, 'a'
    jl store_char
    cmp bl, 'z'
    jg store_char

    jmp store_char_letter

store_char:
    mov [edx], bl
    inc edx
    jmp change_letters

store_char_letter:
    mov bl, [ecx]
    dec ecx
    mov [edx], bl
    inc edx
    jmp change_letters

end:
    mov [edx], bl
    mov eax, [ebp+8]
    pop ebx
    pop ebp
    ret