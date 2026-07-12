# 🚀 Scuts (Shortcuts) - Cheat Sheet Interactivo

Una herramienta elegante para gestionar tus atajos y alias de desarrollo. Renderiza markdown en la terminal con tablas y bloques de código con colores.

## ⚡ Instalación Rápida

```bash
git clone https://github.com/tuusuario/scuts.git
cd scuts
chmod +x install.sh
./install.sh
```

Eso es todo. El script se encarga de:
- ✅ Detectar tu sistema operativo (Linux o macOS)
- ✅ Instalar **glow** automáticamente si no lo tienes
- ✅ Copiar los archivos de configuración
- ✅ Configurar el comando `scuts` en tu PATH

## 🎯 Uso

```bash
# Ver el índice principal
scuts

# Ver una sección específica
scuts vscode
scuts python
scuts git
scuts bash

# Ver ayuda
scuts help
```

## 📂 Estructura

```
scuts/
├── install.sh              # Script de instalación automática
├── README.md               # Este archivo
├── .gitignore              # Configuración de git
└── bin/
    └── scuts               # Script principal (se copia a ~/bin/)
```

Después de instalar, tus archivos de configuración estarán en:
```
~/.config/scuts/
├── index.md                # Índice principal
├── vscode.md              # Atajos de VS Code
├── python.md              # Alias de Python
├── git.md                 # Alias de Git
└── bash.md                # Atajos de Bash/Zsh
```

## 🔧 Editar los shortcuts

Es súper simple. Los archivos son markdown puro. Puedes editarlos con cualquier editor:

```bash
nano ~/.config/scuts/vscode.md
# o tu editor favorito
```

Los cambios se reflejan inmediatamente.

## 🖥️ Compatibilidad

- ✅ **Linux** (Ubuntu, Debian, Fedora, Arch, etc.)
- ✅ **macOS** (Intel y Apple Silicon)

## 📋 Requisitos

- `bash` o `zsh`
- `curl` (para descargar glow)
- Acceso a `sudo` en Linux (solo para la primera instalación)

## 🚀 Características

- 📱 **Markdown renderizado** con tablas y código coloreado
- 🎨 **Temas automáticos** según tu terminal
- 📝 **Fácil de editar** - Solo son archivos markdown
- 🔄 **Multiplataforma** - Funciona en Linux y macOS
- 💾 **Portátil** - Copia la carpeta `~/.config/atajos/` a otro PC

## 🛠️ Desinstalar

Para desinstalar:

```bash
rm ~/bin/scuts
rm -rf ~/.config/scuts
```

Y opcionalmente quita las líneas de PATH de `~/.bashrc` y/o `~/.zshrc`.

## 🤝 Contribuciones

¿Quieres añadir más secciones? Solo:

1. Crea un nuevo archivo en `~/.config/scuts/` (ej: `docker.md`)
2. Añade una entrada en `index.md` con la descripción
3. ¡Listo! El comando `scuts docker` funcionará automáticamente

## 📝 Licencia

MIT

## 💡 Inspirado en

[Charm - glow](https://github.com/charmbracelet/glow) - La herramienta que renderiza el markdown
