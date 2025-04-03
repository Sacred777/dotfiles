# Настройка и использование скрипта `setup-journald-config.sh`

Этот скрипт автоматизирует процесс создания директории `/etc/systemd/journald.conf.d` (если её нет) и создания символической ссылки на пользовательский конфигурационный файл `custom.conf` для управления настройками журнала systemd.

## Содержание

1. [Предварительные требования](#предварительные-требования)
2. [Настройка скрипта](#настройка-скрипта)
3. [Использование скрипта](#использование-скрипта)
4. [Проверка результатов работы](#проверка-результатов-работы)
5. [Обработка ошибок](#обработка-ошибок)

---

## Предварительные требования

Перед использованием скрипта убедитесь, что выполнены следующие условия:

1. У вас есть права суперпользователя (`sudo`) для создания директорий и символических ссылок в системных директориях.
2. В вашей домашней директории существует файл конфигурации `~/dotfiles/systemd/custom.conf`. Если его нет, создайте его:
   ```bash
   mkdir -p ~/dotfiles/systemd/
   nano ~/dotfiles/systemd/custom.conf
   ```
   Пример содержимого файла `custom.conf`:
   ```plaintext
   [Journal]
   SystemMaxUse=500M
   SystemKeepFree=1G
   MaxFileSec=1week
   ```

3. Убедитесь, что скрипт имеет права на выполнение:
   ```bash
   chmod +x setup-journald-config.sh
   ```

---

## Настройка скрипта

Скрипт уже настроен для работы "из коробки". Однако, если вы хотите изменить пути к файлам или директориям, отредактируйте следующие переменные в начале скрипта:

```bash
TARGET_FILE="$HOME/dotfiles/systemd/custom.conf"  # Путь к целевому файлу
TARGET_DIR="/etc/systemd/journald.conf.d"         # Путь к директории
LINK_PATH="$TARGET_DIR/custom.conf"              # Путь к символической ссылке
```

- Измените `TARGET_FILE`, если ваш конфигурационный файл находится в другом месте.
- Измените `TARGET_DIR` и `LINK_PATH`, если вы хотите использовать другую директорию или имя ссылки.

---

## Использование скрипта

1. **Запустите скрипт**:
   Выполните скрипт из терминала:
   ```bash
   ./setup-journald-config.sh
   ```

2. **Ожидаемый вывод**:
   При первом запуске скрипт создаст директорию `/etc/systemd/journald.conf.d` (если её нет) и символическую ссылку:
   ```plaintext
   Создаём директорию: /etc/systemd/journald.conf.d
   Создаём символическую ссылку: /etc/systemd/journald.conf.d/custom.conf
   Готово!
   ```

   Если директория и ссылка уже существуют, вы увидите:
   ```plaintext
   Символическая ссылка уже существует: /etc/systemd/journald.conf.d/custom.conf
   Готово!
   ```

---

## Проверка результатов работы

### 1. Проверка наличия директории
Убедитесь, что директория `/etc/systemd/journald.conf.d` существует:
```bash
ls -ld /etc/systemd/journald.conf.d
```
Вывод должен показать, что директория существует:
```plaintext
drwxr-xr-x 2 root root 4096 Oct 20 14:00 /etc/systemd/journald.conf.d
```

### 2. Проверка символической ссылки
Убедитесь, что символическая ссылка создана и указывает на правильный файл:
```bash
ls -l /etc/systemd/journald.conf.d/
```
Ожидаемый вывод:
```plaintext
lrwxrwxrwx 1 root root 35 Oct 20 14:00 custom.conf -> /home/username/dotfiles/systemd/custom.conf
```

Если ссылка битая (целевой файл отсутствует), вы увидите:
```plaintext
lrwxrwxrwx 1 root root 35 Oct 20 14:00 custom.conf -> /home/username/dotfiles/systemd/custom.conf (broken link)
```

### 3. Проверка работы systemd-journald
Перезапустите службу `systemd-journald`, чтобы применить изменения:
```bash
sudo systemctl restart systemd-journald
```

Проверьте текущее использование дискового пространства журналами:
```bash
journalctl --disk-usage
```

---

## Обработка ошибок

### 1. Ошибка: "No such file or directory"
Если вы видите сообщение об ошибке, например:
```plaintext
ln: failed to create symbolic link '/etc/systemd/journald.conf.d/custom.conf': No such file or directory
```
Это означает, что директория `/etc/systemd/journald.conf.d` не была создана. Убедитесь, что скрипт выполняется с правами суперпользователя (`sudo`).

### 2. Ошибка: Битая ссылка
Если символическая ссылка битая (целевой файл отсутствует), убедитесь, что файл `~/dotfiles/systemd/custom.conf` существует и доступен:
```bash
ls -l ~/dotfiles/systemd/custom.conf
```

### 3. Ошибка: "Permission denied"
Если вы видите ошибку доступа, убедитесь, что вы запускаете скрипт с правами суперпользователя:
```bash
sudo ./setup-journald-config.sh
```
