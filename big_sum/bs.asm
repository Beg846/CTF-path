section .data
    enter1_msg db 'Enter first number:', 10
    enter1_msg_len equ $ - enter1_msg
    enter2_msg db 'Enter second number:',10
    enter2_msg_len equ $ - enter2_msg

section .bss
    num1 resb 100
    num2 resb 100
    result resb 100

section .text
    global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, enter1_msg
    mov rdx, enter1_msg_len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, num1
    mov rdx, 100
    syscall

    lea r12, [num1 + rax - 2]; r12 = địa chỉ chữ số hàng đơn vị của num1

    mov rax, 1
    mov rdi, 1
    mov rsi, enter2_msg
    mov rdx, enter2_msg_len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, num2
    mov rdx, 100
    syscall

    lea r13, [num2 + rax - 2]; r13 = địa chỉ chữ số hàng đơn vị của num1

    call big_sum

    mov rax, 1
    mov rdi, 1
    syscall

    mov rax, 60
    mov rdi, 0
    syscall


big_sum:
    ;khai báo biến nhớ
    ;loop
    ;chuyển 1 str thành int trong num1, num2
    ;lưu r12, r13, r12 + r13 + r14
    ;so sánh nếu >=10, gọi hàm tách, ret
    ;chuyển thành str, thêm vào
    ;
    ;
    xor r14, r14
    mov r8, result + 99
    mov byte [r8], 10
    dec r8


.bs_loop:
    ;dua con tro vao num1
    ;12809 
    ;lay '9'
    ;chuyen thanh so
    ;cho vao r12   
    mov rsi, r12
    mov rbx, num1
    call _converter
    mov r12, rsi
    mov r9, rax
    
    ;dua con tro vao num2
    ;36728
    ;lay '8'
    ;chuyen thanh so
    ;cho vao r13
    mov rsi, r13
    mov rbx, num2
    call _converter
    mov r13, rsi
    mov r10, rax

    xor r15, r15
    mov r11, r12
    call _cinc1
    mov r11, r13
    call _cinc2
    cmp r15, 2
    jne .sum
    cmp r14, 0
    je .big_sum_done

    ;r12 + r13 + bien nho
    ;cmp >= 10
    ; luu bien nho
.sum:
    add r9, r10
    add r9, r14
    call _calculator 

    ;chuyen so cong thanh ky tu cho vo mang result
    add rdx, 48
    mov [r8], dl
    dec r8

    jmp .bs_loop

.big_sum_done:
    inc r8
    mov rsi, r8             ; Dòng này copy giá trị địa chỉ r8 sang rsi
    mov rdx, result + 100
    sub rdx, rsi            ; rsi ở đây chính là địa chỉ r8 đã được copy sang
    ret



_calculator:
    xor rdx, rdx
    mov rbx, 10
    mov rax, r9
    div rbx
    mov r9, rdx
    mov r14, rax
    ret


_converter:
    cmp rsi, rbx            ; So sánh trực tiếp con trỏ rsi với địa chỉ mảng rbx
    jge __convert
    mov rax, 0
    ret

__convert:
    xor rax, rax
    xor rbx, rbx
    mov bl, [rsi]
    dec rsi
    sub bl, 48
    add rax, rbx
    ret


_cinc1:
    cmp r11, num1
    jl __inc1
    ret

__inc1:
    inc r15
    ret

_cinc2:
    cmp r11, num2
    jl __inc2
    ret

__inc2:
    inc r15
    ret