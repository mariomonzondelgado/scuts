#!/usr/bin/env bash
# ============================================
#  Instalador automático de Scuts
#  Compatible con Linux y macOS
# ============================================

set -e  # Salir si hay algún error

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'  # No Color

# Detectar el sistema operativo
detect_os() {
    case "$(uname -s)" in
        Linux*)
            echo "linux"
            ;;
        Darwin*)
            echo "macos"
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

# Instalar glow en Linux
install_glow_linux() {
    if command -v glow &> /dev/null; then
        return 0  # Ya está instalado
    fi
    
    echo -ne "${BLUE}[*]${NC} Detectando gestor de paquetes... "
    
    if command -v apt-get &> /dev/null; then
        echo -ne "${BLUE}APT${NC}\n"
        echo -ne "${BLUE}[*]${NC} Instalando glow (requiere sudo)... "
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg 2>/dev/null
        echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list > /dev/null
        sudo apt-get update > /dev/null 2>&1
        sudo apt-get install -y glow > /dev/null 2>&1
        echo -e "${GREEN}✓${NC}"
        
    elif command -v dnf &> /dev/null; then
        echo -ne "${BLUE}DNF${NC}\n"
        echo -ne "${BLUE}[*]${NC} Instalando glow (requiere sudo)... "
        sudo dnf install -y glow > /dev/null 2>&1
        echo -e "${GREEN}✓${NC}"
        
    elif command -v pacman &> /dev/null; then
        echo -ne "${BLUE}PACMAN${NC}\n"
        echo -ne "${BLUE}[*]${NC} Instalando glow (requiere sudo)... "
        sudo pacman -S --noconfirm glow > /dev/null 2>&1
        echo -e "${GREEN}✓${NC}"
        
    elif command -v brew &> /dev/null; then
        echo -ne "${BLUE}HOMEBREW${NC}\n"
        echo -ne "${BLUE}[*]${NC} Instalando glow... "
        brew install glow > /dev/null 2>&1
        echo -e "${GREEN}✓${NC}"
        
    else
        echo -e "${RED}✗${NC}"
        echo -e "${RED}❌ No se encontró un gestor de paquetes compatible${NC}"
        echo "   Instala glow manualmente desde: https://github.com/charmbracelet/glow"
        return 1
    fi
}

# Instalar glow en macOS
install_glow_macos() {
    if command -v glow &> /dev/null; then
        return 0  # Ya está instalado
    fi
    
    echo -ne "${BLUE}[*]${NC} Instalando glow con Homebrew... "
    
    if ! command -v brew &> /dev/null; then
        echo -e "${RED}✗${NC}"
        echo -e "${RED}❌ Homebrew no está instalado${NC}"
        echo "   Instálalo desde: https://brew.sh"
        return 1
    fi
    
    brew install glow > /dev/null 2>&1
    echo -e "${GREEN}✓${NC}"
}

# Crear la estructura de archivos
setup_config_files() {
    echo -ne "${BLUE}[*]${NC} Creando archivos de configuración... "
    
    mkdir -p ~/.config/scuts
    
    # Índice principal
    cat << 'EOF' > ~/.config/scuts/index.md
# 🚀 Shortcuts (Scuts) - Referencia Rápida

Bienvenido a tu cheat sheet personalizada. Usa el comando `scuts [seccion]` para ver los detalles.

## 📂 Secciones disponibles

| Comando | Descripción |
| :--- | :--- |
| `scuts vscode` | Atajos de teclado de Visual Studio Code |
| `scuts python` | Alias recomendados para Python y PIP |
| `scuts git` | Alias recomendados para Git |
| `scuts bash` | Atajos de terminal (Bash/Zsh) y alias de sistema |

> 💡 **Tip:** Puedes editar estos archivos en cualquier momento en `~/.config/scuts/`.
EOF

    # Visual Studio Code
    cat << 'EOF' > ~/.config/scuts/vscode.md
# 💻 Visual Studio Code

## 🌟 General
| Atajo | Acción |
| :--- | :--- |
| `Ctrl + Shift + P` | Command Palette |
| `Ctrl + P` | Abrir archivo rápido |
| `Ctrl + \`` | Abrir/cerrar terminal integrada |
| `Ctrl + B` | Toggle barra lateral |
| `Ctrl + ,` | Abrir configuración |

## ✍️ Edición
| Atajo | Acción |
| :--- | :--- |
| `Ctrl + D` | Seleccionar siguiente ocurrencia |
| `Ctrl + Shift + K` | Eliminar línea completa |
| `Alt + ↑/↓` | Mover línea arriba/abajo |
| `Shift + Alt + ↑/↓` | Duplicar línea arriba/abajo |
| `Ctrl + /` | Comentar/descomentar línea |
| `Ctrl + Shift + L` | Seleccionar todas las ocurrencias |

## 🧭 Navegación y Símbolos
| Atajo | Acción |
| :--- | :--- |
| `Ctrl + G` | Ir a línea |
| `Ctrl + Shift + O` | Ir a símbolo en archivo |
| `F12` | Ir a definición |
| `Shift + F12` | Ver todas las referencias |
| `Ctrl + Tab` | Cambiar entre tabs |

## 🛠️ Refactorización y Git
| Atajo | Acción |
| :--- | :--- |
| `F2` | Renombrar símbolo |
| `Shift + Alt + F` | Formatear documento |
| `Ctrl + Shift + G` | Abrir panel de control de Git |
EOF

    # Python
    cat << 'EOF' > ~/.config/scuts/python.md
# 🐍 Python

Añade estos alias a tu `~/.bashrc` o `~/.zshrc` para acelerar tu flujo de trabajo.

## 🏃 Ejecución y Entornos
```bash
alias py="python3"
alias pyv="python3 -m venv .venv"
alias pyea="source .venv/bin/activate"
```

## 📦 PIP
```bash
alias pip="pip3"
alias pipl="pip list"
alias pipir="pip install -r requirements.txt"
alias pipfr="pip freeze > requirements.txt"
```

## 🛠️ Herramientas Útiles
```bash
alias pyhttp="python3 -m http.server 8000"
alias pyjson="python3 -m json.tool"
```
EOF

    # Git
    cat << 'EOF' > ~/.config/scuts/git.md
# 🌿 Git

Añade estos alias a tu `~/.bashrc` o `~/.zshrc`.

## 📝 Básicos
```bash
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"
```

## 🌳 Ramas
```bash
alias gb="git branch"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gsw="git switch"
```

## 📜 Historial y Log
```bash
alias gl="git log --oneline --graph --decorate"
alias gd="git diff"
alias gds="git diff --staged"
```

## 🧰 Útiles
```bash
alias gst="git stash"
alias gstp="git stash pop"
alias gundo="git reset HEAD~1"
```
EOF

    # Bash / Zsh
    cat << 'EOF' > ~/.config/scuts/bash.md
# 🐚 Bash / Zsh

## ⌨️ Atajos de Navegación
| Atajo | Acción |
| :--- | :--- |
| `Ctrl + A` | Ir al inicio de la línea |
| `Ctrl + E` | Ir al final de la línea |
| `Alt + B` | Retroceder una palabra |
| `Alt + F` | Avanzar una palabra |

## ✂️ Edición y Borrado
| Atajo | Acción |
| :--- | :--- |
| `Ctrl + U` | Borrar desde cursor al inicio |
| `Ctrl + K` | Borrar desde cursor al final |
| `Ctrl + W` | Borrar palabra anterior |
| `Ctrl + Y` | Pegar lo último borrado |

## 🔄 Historial y Control
| Atajo | Acción |
| :--- | :--- |
| `Ctrl + R` | Buscar en historial (reverse search) |
| `Ctrl + C` | Interrumpir proceso actual |
| `Ctrl + Z` | Suspender proceso (mandar a bg) |
| `Ctrl + L` | Limpiar pantalla (clear) |

## 🚀 Alias de Sistema Recomendados
```bash
alias ll="ls -alF"
alias ..="cd .."
alias ...="cd ../.."
alias ports="ss -tulnp"
alias myip="curl ifconfig.me"
```
EOF

    echo -e "${GREEN}✓${NC}"
}

# Instalar el script
setup_script() {
    echo -ne "${BLUE}[*]${NC} Instalando script 'scuts'... "
    
    mkdir -p ~/bin
    
    cat << 'EOF' > ~/bin/scuts
#!/usr/bin/env bash
# ============================================
#  scuts - Referencia rápida en Markdown
# ============================================

DATA_DIR="$HOME/.config/scuts"

# Verificar que glow está instalado
if ! command -v glow &> /dev/null; then
    echo -e "\e[31m❌ Error: 'glow' no está instalado.\e[0m"
    echo "Visita: https://github.com/charmbracelet/glow"
    exit 1
fi

# Función de ayuda
show_help() {
    echo -e "\e[1;36mUso:\e[0m scuts [seccion]"
    echo ""
    echo -e "\e[1;32mSecciones:\e[0m"
    echo "  vscode    Atajos de Visual Studio Code"
    echo "  python    Alias para Python y PIP"
    echo "  git       Alias para Git"
    echo "  bash      Atajos de terminal y alias de sistema"
    echo ""
    echo -e "\e[2mEjecuta 'scuts' sin argumentos para ver el índice.\e[0m"
}

# Lógica principal
case "${1:-all}" in
    vscode|python|git|bash)
        if [ -f "$DATA_DIR/$1.md" ]; then
            glow -p "$DATA_DIR/$1.md"
        else
            echo "❌ El archivo para '$1' no existe."
        fi
        ;;
    all|"")
        glow -p "$DATA_DIR/index.md"
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo -e "\e[31m❌ Sección desconocida: '$1'\e[0m"
        show_help
        exit 1
        ;;
esac
EOF

    chmod +x ~/bin/scuts
    echo -e "${GREEN}✓${NC}"
}

# Añadir al PATH
setup_path() {
    echo -ne "${BLUE}[*]${NC} Configurando PATH... "
    
    # Detectar shell
    if [ -f ~/.bashrc ]; then
        if ! grep -q 'export PATH="$HOME/bin:$PATH"' ~/.bashrc; then
            echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
        fi
    fi
    
    if [ -f ~/.zshrc ]; then
        if ! grep -q 'export PATH="$HOME/bin:$PATH"' ~/.zshrc; then
            echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
        fi
    fi
    
    echo -e "${GREEN}✓${NC}"
}

# Main
main() {
    echo ""
    echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║  Instalador de Scuts (Shortcuts)      ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
    echo ""
    
    OS=$(detect_os)
    
    if [ "$OS" = "unknown" ]; then
        echo -e "${RED}❌ Sistema operativo no soportado${NC}"
        exit 1
    fi
    
    echo -e "${BLUE}[*]${NC} Sistema detectado: ${YELLOW}$(uname -s)${NC}"
    echo ""
    
    # Instalar glow según el SO
    if [ "$OS" = "linux" ]; then
        install_glow_linux || exit 1
    elif [ "$OS" = "macos" ]; then
        install_glow_macos || exit 1
    fi
    
    # Resto de la instalación
    setup_config_files
    setup_script
    setup_path
    
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  ✓ Instalación completada             ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}📝 Próximos pasos:${NC}"
    echo ""
    echo "1️⃣  Recarga tu shell:"
    echo -e "   ${BLUE}source ~/.bashrc${NC}  (o ${BLUE}source ~/.zshrc${NC} si usas zsh)"
    echo ""
    echo "2️⃣  Prueba el comando:"
    echo -e "   ${BLUE}scuts${NC}"
    echo ""
    echo -e "${BLUE}Más info: scuts help${NC}"
    echo ""
}

main
