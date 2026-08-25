section .text
	global _start

_start:
	mov rax, 1							;sysnumber = 1: write
	mov rdi, 1							;(fd - file descrypter)stdout = 1
	mov rsi, hello_msg					;(buf - Buffer(vùng nhớ)) địa chỉ chuỗi
	mov rdx, hello_msg_len				;count = độ dài chuỗi
	syscall

	mov rax, 60							;sysnumber = 60: exit
	mov rdi, 0							;status = 0: thoát
	syscall

section .data
	hello_msg db 'Hello world', 10		;khai báo biến có chứa chuỗi Hello world sau đó xuống dòng(10)
	hello_msg_len equ $ - hello_msg		;khai báo biến chứa độ dài ký tự bằng hàm equ(Equate) đưa trực tiếp kết quả vào biến(bao gồm cả xuống dòng bằng cách: $(địa chỉ hiện tại) - hello_msg(địa chỉ đầu chuỗi) = 12(kết quả bao gồm 11 ký tự trong Hello world(bao gồm cả dấu cách) và xuống dòng))
