section .data
    enter1_msg db 'Enter first number:', 10
    enter1_msg_len equ $ - enter1_msg
    enter2_msg db 'Enter second number:',10
    enter2_msg_len equ $ - enter2_msg

section .bss
    num1 resb 100
    num2 resb 100
    temp resb 100
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
    mov rsi, result
    add rsi, 99
    mov byte [rsi], 10
    dec rsi
    push rsi
    mov rsi, num2
    push rsi
    mov rsi, num1
    push rsi


.bs_loop:
    ;dua con tro vao num1
    ;12809 
    ;lay '9'
    ;chuyen thanh so
    ;cho vao r12   
    xor rax, rax
    xor rbx, rbx
    mov rsi, [rsp]
    mov bl, [rsi]
    inc rsi
    mov [rsp], rsi
    imul rax, rax, 10
    sub bl, 48
    add rax, rbx
    mov r12, rax
    
    ;dua con tro vao num2
    ;36728
    ;lay '8'
    ;chuyen thanh so
    ;cho vao r13
    xor rax, rax
    xor rbx, rbx
    mov rsi, [rsp + 8]
    mov bl, [rsi]
    inc rsi
    mov [rsp + 8], rsi
    imul rax, rax, 10
    sub bl, 48
    add rax, rbx
    mov r13, rax

    ;r12 + r13 + bien nho
    ;cmp >= 10
    ; luu bien nho
    add r12, r13
    add r12, r14
    call _calculate

    ;chuyen so cong thanh ky tu cho vo mang result
    mov rsi, [rsp + 16]
    add r12, 48
    mov [rsi], dl
    dec rsi
    mov [rsp + 16], rsi

    cmp 


_calculate:
    xor rdx, rdx
    mov rbx, 10
    mov rax, r12 
    div rbx
    mov r12, rdx
    mov r14, rax
    jmp __done
    
__done:
    ret
    

.big_sum_done:
        ret



move_num:
    
