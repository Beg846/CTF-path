section .data
    enter1_msg db 'Nhập số thứ nhất:', 10
    enter1_msg_len equ $ - enter1_msg
    enter2_msg db 'Nhập số thứ hai:', 10
    enter2_msg_len equ $ - enter2_msg

section .bss
    num1 resb 20
    num2 resb 20
    result resb 20

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
    mov rdx, 20
    syscall

    mov rsi, num1
    call str_to_int
    mov r12, rax

    mov rax, 1
    mov rdi, 1
    mov rsi, enter2_msg
    mov rdx, enter2_msg_len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, num2
    mov rdx, 20
    syscall

    mov rsi, num2
    call str_to_int
    imul rax, r12

    call int_to_str

    mov rax, 1
    mov rdi, 1
    mov rsi, r8
    mov rdx, rcx
    syscall

    mov rax, 60
    mov rdi, 0
    syscall


str_to_int:
    xor rbx, rbx
    xor rax, rax
    mov bl, [rsi]
    cmp bl, 10
    je .done

.convert:
    imul rax, rax, 10
    sub bl, 48
    add rax, rbx
    inc rsi
    mov bl, [rsi]
    cmp bl, 10
    jne .convert

.done:
    ret



int_to_str:
    xor rcx, rcx
    mov rbx, 10
    mov rsi, result
    add rsi, 19
    mov byte [rsi], 10
    inc rcx

.convert:
    xor rdx, rdx
    div rbx
    add rdx, 48
    dec rsi
    mov [rsi], dl
    inc rcx
    cmp rax, 0
    jne .convert

    mov r8, rsi
.done:
    ret