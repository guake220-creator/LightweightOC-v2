void kernel_main() {
    const char *str = "Hello from LightweightOS!";
    char *video_memory = (char *) 0xb8000;
    int i = 0;

    while (str[i] != '\0') {
        video_memory[i * 2] = str[i];
        video_memory[i * 2 + 1] = 0x07; // Белый текст на черном фоне
        i++;
    }

    while (1); // Бесконечный цикл, чтобы система не зависала внезапно
}
