[org 0x7c00]

    mov ah, 0x00
    mov al, 0x03          ; Текстовый режим
    int 0x10

    ; 1. Показываем анимацию спирали
    mov si, spiral
    call print_string
    mov cx, 0xFFFF
delay1: loop delay1       ; Задержка

    ; 2. Очищаем экран для кошки
    mov ah, 0x00
    mov al, 0x03
    int 0x10

    ; 3. Рисуем кошку и название
    mov si, cat_art
    call print_string
    mov si, os_name
    call print_string

    ; 4. Переходим к вводу текста (терминалу)
start_shell:
    mov si, prompt_msg
    call print_string

input_loop:
    ; Ожидание нажатия клавиши от пользователя
    mov ah, 0x00
    int 0x16              ; Прерывание клавиатуры BIOS
    
    ; Проверка на клавишу Enter (код 0x0D)
    cmp al, 0x0D
    je .enter_pressed

    ; Проверка на Backspace / стирание (код 0x08)
    cmp al, 0x08
    je .backspace

    ; Иначе — выводим набранный символ на экран
    mov ah, 0x0E
    int 0x10
    jmp input_loop

.enter_pressed:
    ; Перевод строки при нажатии Enter
    mov ah, 0x0E
    mov al, 0x0D
    int 0x10
    mov al, 0x0A
    int 0x10
    jmp start_shell       ; Снова выводим приглашение catOS>

.backspace:
    ; Логика стирания символа (в текстовом режиме)
    mov ah, 0x0E
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 0x08
    int 0x10
    jmp input_loop

print_string:
    lodsb
    cmp al, 0
    je .done
    mov ah, 0x0E
    int 0x10
    jmp print_string
.done:
    ret

spiral  db ' @ @ @ @ @ ', 13, 10, '  @ @ @ @  ', 13, 10, '   @ @ @   ', 13, 10, 0
cat_art db ' /\_/\ ', 13, 10, '( o.o )', 13, 10, ' > ^ < ', 13, 10, 0
os_name db 13, 10, 'catOS v1.0', 13, 10, 13, 10, 0
prompt_msg db 'catOS> ', 0

times 510-($-$$) db 0
dw 0xaa55
