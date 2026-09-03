section .data
    enter1_msg db 'Enter first number:', 10
    enter1_msg_len equ $ - enter1_msg
    enter2_msg db 'Enter second number:',10
    enter2_msg_len equ $ - enter2_msg

section .bss
    num1_str resb 100
    num2_str resb 100
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
    mov rsi, num1_str
    mov rdx, 100
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, enter2_msg
    mov rdx, enter2_msg_len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, num2_str
    mov rdx, 100
    syscall

    mov rax, 1
    mov rdi, 1
    mov rdx, rcx
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

str_to_int:
    xor rax, rax ;so sánh 2 thanh ghi theo xor nếu bằng thì trả về 0, nếu không bằng trả về 1
    xor rbx, rbx
    mov bl, [rsi]
    cmp bl, 10
    je .num_read_done

.num_read:
    ;n = n*10 + bl - 48('0')    
    imul rax, rax, 10
    sub bl, 48
    add rax, rbx
    inc rsi
    mov bl, [rsi]
    cmp bl, 10
    jne .num_read

.num_read_done:
    ret

int_to_str:
    ; a= n % 10
    ; a = a + 48
    ; put a into result
    xor rcx, rcx
    mov rbx, 10
    mov rsi, result
    add rsi, 99
    mov byte [rsi], 10
    inc rsi

.convert:
    xor rdx, rdx
    div rbx
    add rdx, 48
    dec rsi
    mov [rsi], dl
    inc rcx 
    cmp rax, 0
    jg .convert

    ret


