[org 0x7c00]          ; Начальный адрес загрузки BIOS

; 1. Переходим в текстовый режим 80x25 и очищаем экран
mov ah, 0x00
mov al, 0x03          
int 0x10

; 2. Выводим текст "catOS loading..."
mov si, greeting_msg
call print_string

animation_loop:
    ; 3. Выводим анимированный символ для спирали/эффекта
    mov ah, 0x09
    mov al, '*'       
    mov bh, 0x00
    mov bl, 0x0A      ; Зеленый цвет текста
    mov cx, 1         
    int 0x10

    jmp animation_loop

print_string:
    lodsb
    cmp al, 0
    je .done
    mov ah, 0x0E
    int 0x10
    jmp print_string
.done:
    ret

greeting_msg db 'catOS loading...', 13, 10, 0

; Заполняем до 512 байт и добавляем стандартную подпись загрузчика
times 510-($-$$) db 0
dw 0xaa55
