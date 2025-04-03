#!/bin/bash

# Путь к целевому файлу
TARGET_FILE="$HOME/dotfiles/systemd/custom.conf"

# Путь к директории и символической ссылке
TARGET_DIR="/etc/systemd/journald.conf.d"
LINK_PATH="$TARGET_DIR/custom.conf"

# Создаём директорию, если её нет
if [ ! -d "$TARGET_DIR" ]; then
    echo "Создаём директорию: $TARGET_DIR"
    sudo mkdir -p "$TARGET_DIR"
fi

# Создаём символическую ссылку
if [ ! -L "$LINK_PATH" ]; then
    echo "Создаём символическую ссылку: $LINK_PATH"
    sudo ln -s "$TARGET_FILE" "$LINK_PATH"
else
    echo "Символическая ссылка уже существует: $LINK_PATH"
fi

echo "Готово!"
