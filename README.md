# dotfiles
Мои конфигурационные файлы
Для управления конфигурационными файлами используется утилита stow

## Установка stow в Arch Linux
```sh
sudo pacman -S stow
```
Установка stow в Fedora
```sh
sudo dnf install stow
```

## Использование stow
После клонирования в домашнюю папку:
### 1.Добавление всех файлов конфигурации
с переходом в папку `~/dotfiles`
```sh
cd ~/dotfiles
stow -R -v -t ~ .
```
без перехода в папку `~/dotfiles`
```sh
stow -R -v -d ~/dotfiles -t ~ .
```

### 2.Выборочное добавление файлов конфигураций, на примере zsh и kitty
с переходом в папку `~/dotfiles`
```sh
cd ~/dotfiles
stow -R -v -t ~ zsh kitty
```
без перехода в папку `~/dotfiles`
```sh
stow -R -v -d ~/dotfiles -t ~ zsh kitty
```

### 3.Добавление новой конфигурации в папку ~/dotfiles на примере zsh и kitty
Файл конфигурации zsh находится `~/.zshrc  
В `~/dotfiles/ создаем директорию zsh и переносим файл конфигурации
```sh
mkdir -p ~/dotfiles/zsh
mv ~/.zshrc ~/dotfiles/zsh/
```
Файл конфигурации kitty находится `~/.config/kitty/kitty.conf`
```sh
mkdir -p ~/dotfiles/kitty/.config/kitty
mv ~/.config/kitty/kitty.conf ~/dotfiles/kitty/.config/kitty/
```

### 4.Удаление симлинк
всех ссылок
```sh
stow -D -v -t ~ .
```
выборочно
```sh
stow -D -v -t zsh kitty

**!** Если есть конфигурационные файлы которые не переносятся, стоит сделать их бэкап перед созданием ссылок 


