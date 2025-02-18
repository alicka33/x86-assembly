section .data
    m             dq 1.0       ; Mass of the ball
    t             dq 0.01      ; Time step
    g             dq 9.81      ; Acceleration due to gravity
    num_steps     dd 100       ; Number limit of simulation steps
    num_steps_limit dd 100     ; Number of simulation steps
    factor        dq 0.01745329252 ; Conversion factor (pi / 180.0)
    PI            dq 3.14159265359 ; PI
    z             dq 180.0     ; 180
    width         dq 800.0

section .text
global projectile_motion
extern cos, sin

projectile_motion:
    finit
    push rbx
    mov rbx, rdi      ; rdi = pixelData (uint8_t*)

    ; Initialize variables
    movsd xmm0, qword [rsi] ; xmm0 = v0 (double)
    movsd xmm1, qword [rdx] ; xmm1 = theta (double)
    movsd xmm2, qword [rcx] ; xmm2 = K (double)

    movsd xmm3, qword [m]       ; xmm3 = m
    movsd xmm4, qword [t]       ; xmm4 = t
    movsd xmm5, qword [g]       ; xmm5 = g
    mov dword [num_steps], 0    ; Initialize num_steps to 0

    ; Convert angle from degrees to radians
    movaps xmm6, xmm1            ; xmm6 = xmm1 (theta)
    movsd xmm7, qword [z]
    divsd xmm6, xmm7             ; xmm6 = xmm6 / xmm7 (theta / 180.0)
    mulsd xmm6, qword [PI]       ; xmm6 = xmm6 * pi (theta * pi)

    ; Calculate horizontal and vertical components of initial velocity
    movaps xmm1, xmm0            ; xmm1 = xmm0 (v0)
    movsd xmm7, qword [factor]   ; xmm7 = conversion factor (pi / 180.0)
    mulsd xmm1, xmm7             ; xmm1 = xmm1 * xmm7 (v0 * conversion factor)
    ;cos xmm8, xmm1              ; Move the value from xmm1 to xmm0
    fcos xmm8, xmm1              ; xmm8 = cos(xmm1) (cos(theta))
    mulsd xmm9, xmm0             ; xmm9 = xmm0 * xmm8 (v0 * cos(theta)) - horizontal component
    ;sin xmm8, xmm1              ; Move the value from xmm1 to xmm0
    fsin xmm8, xmm1              ; xmm8 = sin(xmm1) (sin(theta))
    mulsd xmm10, xmm0            ; xmm10 = xmm0 * xmm8 (v0 * sin(theta)) - vertical component

simulate_motion:
    ; Calculate frictional force T = K * v^2
    movaps xmm11, xmm9           ; xmm11 = xmm9 (horizontal velocity component)
    mulsd xmm11, xmm11           ; xmm11 = xmm11 * xmm11 (horizontal velocity component ^ 2)
    movaps xmm12, xmm10          ; xmm12 = xmm10 (vertical velocity component)
    mulsd xmm12, xmm12           ; xmm12 = xmm12 * xmm12 (vertical velocity component ^ 2)
    addsd xmm11, xmm12           ; xmm11 = xmm11 + xmm12 (horizontal velocity component ^ 2 + vertical velocity component ^ 2)
    mulsd xmm11, xmm3            ; xmm11 = xmm11 * xmm3 (K * velocity^2)

    ; Apply frictional force to horizontal and vertical velocities
    movaps xmm12, xmm11          ; xmm12 = xmm11 (frictional force)
    divsd xmm12, xmm2            ; xmm12 = xmm12 / xmm2 (frictional force / m)
    mulsd xmm12, xmm4            ; xmm12 = xmm12 * xmm4 (frictional force * t)
    subsd xmm9, xmm12            ; xmm9 = xmm9 - xmm12 (horizontal velocity component - frictional force * t)
    movaps xmm12, xmm11          ; xmm12 = xmm11 (frictional force)
    divsd xmm12, xmm2            ; xmm12 = xmm12 / xmm2 (frictional force / m)
    mulsd xmm12, xmm4            ; xmm12 = xmm12 * xmm4 (frictional force * t)
    subsd xmm10, xmm12           ; xmm10 = xmm10 - xmm12 (vertical velocity component - frictional force * t)

    ; Apply gravitational force to vertical velocity
    mulsd xmm13, xmm5            ; xmm13 = xmm5 * xmm4 (g * t)
    addsd xmm10, xmm13           ; xmm10 = xmm10 + xmm13 (vertical velocity component + g * t)

    ; Calculate displacement
    mulsd xmm14, xmm9            ; xmm14 = xmm9 * xmm4 (horizontal velocity component * t)
    mulsd xmm15, xmm10           ; xmm15 = xmm10 * xmm4 (vertical velocity component * t)

    ; Convert displacements to integers
    cvttsd2si eax, xmm14    ; Convert xmm14 to signed integer in rdx
    mov dword [ecx], eax    ; Store the converted integer in memory

    cvttsd2si eax, xmm15    ; Convert xmm15 to signed integer in rdx
    mov dword [edx], eax    ; Store the converted integer in memory

    ; Store position in pixelData (e.g., print position or perform other calculations)
    ; Calculate the memory offset for the pixel
    ;mov eax, edx                         ; edx = y
    imul edx, dword [width]         ; Multiply y by the width of the pixel array
    add edx, ecx                         ; Add x to the offset

    ; Calculate the memory address of the pixel
    mov rdi, rbx                        ; rbx = address of the pixel array
    lea rdx, [rdx * 3]
    add rdi, rdx             ; Multiply the offset by 4 (each pixel is 4 bytes) and add it to the pixel array address

    ; Modify the color of the pixel
    mov dword [edi], 0x01            ; Store the new color at the memory address of the pixel

    ; Increment num_steps
    inc dword [num_steps]

    ; Check if simulation should continue
    mov eax, dword [num_steps]
    cmp eax, dword [num_steps_limit]
    jl simulate_motion
; Clean up
end:

    pop rbx
    ret
