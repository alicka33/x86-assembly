# TODO
# 1. vectory
# 2. opis wykonywanych kroków
# 3. interaktywe wczytywanie parametró v0, theta, K

# the registers rdi, rsi, rdx, and rcx are used to pass the first four integer or pointer arguments to a function, respectively.
# projectileMotion(uint8_t* pixelData, float v0, float theta, float K)#
# rdi, xmm0, xmm1, xmm2
.intel_syntax noprefix

.data
    m:              .float 1          # Mass of the ball
    t:              .float 0.01       # Time step
    g:              .float 9.81       # Acceleration due to gravity
    num_steps:      .float 100        # Number limit of simulation steps
    num_steps_limit:      .float 100        # Number of simulation steps
    factor:         .float 0.017             # Conversion factor (pi / 180.0)
    PI:             .float 3.14            # PI
    z:              .float 180              # 180
    width:          .float 800
    cos:            .float 0.707
    sin:            .float 0.707

.text

.global projectile_motion

projectile_motion:
    finit
    # rdi = pixelData 
    # xmm0 = v0 (float)
    # xmm1 = theta (float)
    # xmm2 = K (float)

    movss xmm3, dword ptr [m]              # xmm3 = m
    movss xmm4, dword ptr [t]              # xmm4 = t
    movss xmm5, dword ptr [g]              # xmm5 = g
    mov dword ptr [num_steps], 0       # Initialize num_steps to 0

    # Convert angle from degrees to radians
    movaps xmm6, xmm1                   # xmm6 = theta
    # movss xmm7, dword [z]               # xmm7 = 180.0
    # divss xmm6, xmm7                    # xmm6 / xmm7 (theta / 180.0)
    # mulss xmm6, dword [PI]              # xmm6 = xmm6 * pi (theta * pi)
    movss xmm7, dword ptr [factor]
    mulss xmm6, xmm7                    # theta * (PI / 180)

    # Calculate horizontal and vertical components of initial velocity
    # horyzontalnie

    movss xmm9, dword ptr [cos]
    # vcosss xmm9, xmm6                 # xmm9 = cos(theta-radians) (xmm6)
    mulss xmm9, xmm0                    # xmm9(vx) = cos(theta-radians) * v0
    
    # vertical
    movss xmm10, dword ptr [sin]
    # vsinss xmm10, xmm6                # xmm10 = sin(theta-radians) (xmm6)
    mulss xmm10, xmm0                   # xmm10(vy) = v0 * sin(theta-radians)) 

simulate_motion:
    # Calculate frictional force T = K * (vx^2 + vy^2)
    movaps xmm11, xmm9                  # xmm11 = xmm9 vx
    mulss xmm11, xmm11                  # xmm11 = xmm11 * xmm11 (vx^2)
    movaps xmm12, xmm10                 # xmm12 = xmm10 (vy)
    
    mulss xmm12, xmm12                  # xmm12 = xmm12 * xmm12 (vy^2)
    addss xmm11, xmm12                  # xmm11 = xmm11 + xmm12 (vx^2 + vy^2)
    mulss xmm11, xmm2                   # xmm11(T) = xmm11 * xmm2 (K*(vx^2 + vy^2))

    # Apply frictional force to horizontal and vertical velocities
    movaps xmm12, xmm11                 # xmm12 = xmm11 (T)
    divss xmm12, xmm3                   # xmm12 = xmm12 / xmm3 (T/m)
    mulss xmm12, xmm9                   # xmm12 = xmm12 * xmm9 ((T/m)*vx)
    mulss xmm12, xmm4                   # xmm12 = xmm12 * xmm9 ((T/m)*vx)*t
    subss xmm9, xmm12                   # xmm9 = xmm9 - xmm12 (vx-((T/m)*vx)*t)

    movaps xmm12, xmm11                 # xmm12 = xmm11 (T)
    divss xmm12, xmm3                   # xmm12 = xmm12 / xmm3 (T/m)
    mulss xmm12, xmm10                  # xmm12 = xmm12 * xmm10 ((T/m)*vy)
    mulss xmm12, xmm4                   # xmm12 = xmm12 * xmm4 ((T/m)*vy)*t
    subss xmm10, xmm12                  # xmm10 = xmm10 - xmm12 (vy-((T/m)*vy)*t)

    # Apply gravitational force to vertical velocity
    subss xmm10, xmm5                  # xmm10 = xmm10 - xmm5 (vy-g)

    # Calculate displacement
    movaps xmm14, xmm4                  # xmm14 (t)
    mulss xmm14, xmm9                   # xmm14(sx) = vx*t
    movaps xmm15, xmm4                  # xmm15 (t)
    mulss xmm15, xmm10                  # xmm15(sy) = vy*t

    # Add to pixelData 
    # X - xmm14, Y - xmm15
color:
    cvttss2si rax, xmm14                # rax = sx (int)
    cvttss2si rcx, xmm15                # rcx = sy (int)

    # (x,y) -> y * WIDTH + x
get_pixel: 
    imul rcx, rcx, 800
    add rax, rcx

add_pixel_data:
    imul rax, rax, 3
    add rax, rdi
    # mov rax, rdi        
    # nwm do końca co to robi
    mov byte ptr [rax], 0xff

    # Increment num_steps
increment:
    inc dword ptr [num_steps]

    # addss xmm4, xmm4        # --> czy deltę zwiększać ???
    # czy ten kod aktualizuje prędkość ????

    # Check if simulation should continue
    mov eax, dword ptr [num_steps]
    cmp eax, dword ptr [num_steps_limit]
    jl simulate_motion

# End
end:
    ret