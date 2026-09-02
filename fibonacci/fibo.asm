section .bss
    input_fibo resb 20
    output_fibo resb 20

section .data
    input_msg db 'Input:', 10
    input_msg_len equ $ - input_msg

section .text
    global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, input_msg
    mov rdx, input_msg_len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, input_fibo
    mov rdx, 20
    syscall

    call str_to_int
    mov r15, rax
    add r15, 1

    call fibo

    mov rax, 60
    mov rdi, 0
    syscall


fibo:
    ;r12 = 0 r13 = 1
    ;r12 = 1 r13 = 1
    ;r12 = 2 r13 = 1
    ;r8 = r12
    ;r12 = r12 + r13
    ;r13 = r8
    ;r8 = r12
    mov r12, 0
    mov r13, 1

.fibo_loop:
    cmp r15, 0
    jle .fibo_done
    dec r15
    mov rax, r12
    call int_to_str
    jmp .fibo_print
    
.fibo_print:
    mov rax, 1
    mov rdi, 1
    mov rsi, r8
    mov rdx, rcx
    syscall

    call str_clear

    xchg r12, r13
    add r12, r13
    jmp .fibo_loop

.fibo_done:
    ret



int_to_str:
    xor rcx, rcx
    xor rdx, rdx
    mov rbx, 10
    mov rsi, output_fibo
    add rsi, 19
    mov byte [rsi], 10  ; SỬA: Thêm '\n' vào cuối chuỗi để tự động xuống dòng khi in
    inc rcx

.convert:
    xor rdx, rdx
    div rbx
    add rdx, 48
    dec rsi
    mov [rsi], dl
    inc rcx
    cmp rax, 0
    jg .convert

    mov r8, rsi
    ret



str_to_int:
    xor rax, rax ;so sánh 2 thanh ghi theo xor nếu bằng thì trả về 0, nếu không bằng trả về 1
    xor rbx, rbx
    mov rsi, input_fibo
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



str_clear:
    mov rsi, output_fibo
    mov rcx, 20

.clear_loop:
    mov byte [rsi], 0
    inc rsi
    dec rcx 
    jnz .clear_loop

    ret
