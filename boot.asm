[BITS 32]
section .multiboot
    align 4
    dd 0x1BADB002            ; магическое число Multiboot
    dd 0x00                  ; флаги
    dd - (0x1BADB002 + 0x00) ; контрольная сумма

section .text
global start
extern kernel_main

start:
    cli                      ; выключаем прерывания
    call kernel_main         ; вызываем функцию из C-файла
.hang:
    hlt                      ; останавливаем процессор
    jmp .hang
