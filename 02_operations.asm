format ELF64
public _start

bss_char rb 1

_start:
    mov rax, 10
    add rax, 20
    call print_number
    call print_line
    call exit

print_number:
    push rax
    push rbx
    push rcx
    push rdx
    xor rcx, rcx
    .next_iter:
        cmp rax, 0
        je .print_iter
        mov rbx, 10
        xor rdx, rdx
        div rbx
        add rdx, '0'
        push rdx
        inc rcx
        jmp .next_iter
    .print_iter:
        cmp rcx, 0
        je .close
        pop rax
        call print_char
        dec rcx
        jmp .print_iter
    .close:
        pop rdx
        pop rcx
        pop rbx
        pop rax
        ret
print_char:
    push rax
    push rbx
    push rcx
    push rdx
    mov [bss_char], al
    mov rax, 4
    mov rbx, 1
    mov rcx, bss_char
    mov rdx, 1
    int 0x80
    pop rdx
    pop rcx
    pop rbx
    pop rax

print_line:
    push rax
    mov rax, 0xA
    call print_char
    pop rax
    ret

exit:
    mov rax, 1
    xor rbx, rbx
    int 0x80