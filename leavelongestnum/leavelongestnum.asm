section .text
global leavelongestnum

leavelongestnum:
    ; eax - text
    ; edx - wynik
    ; cl - licznik długości
    ; ch - długość max
    ; bl - wczytywany char
    ; al - num indeks
    ; ah - longest num indeks
    ; bh - numer charu

    push ebp
    mov ebp, esp

    push ebx

    mov eax, [ebp+8]
    mov edx, eax
    mov cl, 0
    mov ch, 0
    mov bh, 0

get_max_lenght:
    mov bl, [eax]
    inc eax
    add bh, 1

    cmp bl, 0
    jz set_buffor

    cmp bl, '0'
    jge check

    jmp get_max_lenght

check:
    cmp bl, '9'
    jg not_number

    add cl, 1

    cmp cl, 1
    jz first
    jmp check_max

first:
    mov al, bh

check_max:
    cmp cl, ch
    jg set_new_max

    jmp get_max_lenght

set_new_max:
    mov ch, cl
    mov ah, al
    jmp get_max_lenght

not_number:
    mov cl, 0
    jmp get_max_lenght

set_buffor:
    mov eax, edx
    mov bh, 0

find_longest:
    mov bl, [eax]
    inc eax
    add bh, 1

    cmp bh, ah
    je set_store

    jmp find_longest

set_store:
    mov bh, 0

store:
    add bh, 1
    mov [edx], bl
    inc edx

    cmp bh, ch
    je end

    mov bl, [eax]
    inc eax
    jmp store

end:
    mov bl, 0
    mov [edx], bl

    mov eax, [ebp+8]
    pop ebx
    pop ebp
    ret
