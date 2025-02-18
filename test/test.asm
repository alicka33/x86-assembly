# extern void motion(uint8_t* pixelData, float v0, float cos, float sin, float K);
# rdi, xmm0, xmm1, xmm2, xmm3
.intel_syntax noprefix

.data
    t:              .float 0.01       # Time step
    g:              .float 9.81       # Acceleration due to gravity
    PI:             .float 3.14       # PI
    width:          .int 800          # Width

.text

.global motion

motion:
    finit
    # rdi = pixelData 
    # xmm0 = v0 (float)
    # xmm1 = cos(theta) (float)
    # xmm2 = sin(theta) (float)
    # xmm3 = K

    movss xmm4, dword ptr [t]           # xmm4 = t
    movss xmm5, dword ptr [g]           # xmm5 = g

calculate_vel:
    movss xmm6, xmm0                    # xmm6 v0
    mulss xmm6, xmm1                    # xmm6 vx = v0 * cos(theta)

    movss xmm7, xmm0                    # xmm7 v0
    mulss xmm7, xmm2                    # xmm7 vy = v0 * sin(theta)

set_staring_pos:
    xorps xmm8, xmm8
    xorps xmm9, xmm9

# LOOP
simulate_motion:

calculate_acc:
    movss xmm10, xmm6                   # xmm10 vx
    mulss xmm10, xmm10                  # xmm10 vx^2
    mulss xmm10, xmm3                   # xmm10 ax = K*vx^2

    movss xmm11, xmm7                   # xmm11 vy
    mulss xmm11, xmm11                  # xmm11 vy^2
    mulss xmm11, xmm3                   # xmm11 K*vx^2
    addss xmm11, xmm5                   # xmm11 ay = K*vx^2 + g

recalculate_vel:
    mulss xmm10, xmm4                   # xmm10 ax*t
    subss xmm6, xmm10                   # xmm6 vx -= ax*t (horizontal velocity after considering friction)
    
    mulss xmm11, xmm4                   # xmm11 ay*t
    subss xmm7, xmm11                   # xmm7 vy -= ay*t (vertical velocity after considering friction)

caluclate_pos:
    movss xmm12, xmm6                   # xmm12 vx
    mulss xmm12, xmm4                   # xmm12 vx*t
    addss xmm8, xmm12                   # xmm8 x +=vx*t

    movss xmm13, xmm7                   # xmm13 vy
    mulss xmm13, xmm4                   # xmm13 vy*t
    addss xmm9, xmm13                   # xmm9 y +=vy*t

# x - xmm8, y - xmm9
# (x,y) -> y * WIDTH + x
change_pixel: 
    cvtss2si rcx, xmm9                  # y (int)
    mov eax, dword ptr [width]
    imul rcx, rax 

    cvtss2si rax, xmm8                  # x (int)
    add rax, rcx
    imul rax, rax, 3
    add rax, rdi

    mov byte ptr [rax], 0xff

    xorps xmm1, xmm1 
    comiss xmm9, xmm1
    jae simulate_motion

end:
    ret