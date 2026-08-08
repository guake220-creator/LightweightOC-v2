[org 0x7c00]

    ; 1. Вход в графический режим 320x200 (режим 13h)
    mov ax, 0x0013
    int 0x10

    ; 2. Рисуем панель задач внизу (синяя полоса)
    mov ax, 0xA000
    mov es, ax
    mov di, 320 * 180       ; Начало полосы (y = 180)
    mov cx, 320 * 20        ; Размер полосы (высота 20 строк)
    mov al, 1               ; Синий цвет
    rep stosb               ; Заполняем память экрана

    ; 3. Рисуем элемент интерфейса
    mov di, 320 * 80 + 140
    mov cx, 40              ; Счетчик цикла
    xor bx, bx              ; Смещение bx = 0
.golova:
    mov byte [es:di+bx], 15 ; Белый цвет ([di+bx] разрешено в 16-бит)
    inc bx                  ; Увеличиваем смещение
    dec cx                  ; Уменьшаем счетчик
    jnz .golova

    ; 4. Вывод текста
    mov si, message
    mov ah, 0x0E
.print:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .print

.done:
    jmp $

message db "catOS Desktop", 0

times 510-($-$$) db 0
dw 0xaa55
