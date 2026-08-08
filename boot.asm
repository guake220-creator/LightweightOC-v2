[org 0x7c00]

    ; 1. Вход в графический режим 320x200 256 цветов
    mov ax, 0x0013
    int 0x10

    ; 2. Рисуем "панель задач" - синяя полоса внизу (цвет 1)
    mov ax, 0xA000
    mov es, ax
    mov di, 320 * 180  ; Начало полосы
    mov cx, 320 * 20   ; Размер полосы
    mov al, 1          ; Синий цвет
    rep stosb

    ; 3. Рисуем "голову" кота (белый прямоугольник 40x20)
    mov di, 320 * 80 + 140
    mov cx, 40
.head:
    mov byte [es:di+cx], 15 ; Белый цвет
    add di, 320
    loop .head
    
    ; 4. Текстовая подпись
    mov ah, 0x02
    mov bh, 0
    mov dh, 24
    mov dl, 15
    int 0x10
    
    mov si, msg
    mov ah, 0x0E
.print:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .print
.done:
    jmp $

msg db 'CatOS Graphical Interface', 0

times 510-($-$$) db 0
dw 0xaa55
