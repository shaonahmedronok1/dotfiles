# dotfiles

Personal system configuration for NixOS and Arch Linux.
Every setting has a reason. Nothing is default without examination.

Live at [shaon.neocities.org](https://shaon.neocities.org)

---

## Structure
```
dotfiles/
├── .config/
│   ├── alacritty/
│   ├── fastfetch/
│   ├── fontconfig/
│   ├── fuzzel/
│   ├── ghostty/
│   ├── gtk-3.0/
│   ├── gtk-4.0/
│   ├── hypr/
│   ├── imv/
│   ├── kitty/
│   ├── mpv/
│   ├── oxwm/
│   ├── river/
│   ├── waybar/
│   ├── wofi/
│   ├── xdg-desktop-portal/
│   └── yazi/
├── .local/bin/
├── .bashrc
└── packages.txt
```

---

## Install

Install all packages at once:
```
sudo pacman -S --needed - < packages.txt
```

---

## Design Principles

- **Everything explicit** — no hidden defaults, no magic
- **Documented** — every structural choice has a comment
- **Reproducible** — clone and apply, same result every time
- **Minimal** — nothing included without a demonstrable function

---

## License

MIT — use freely. Personal, academic, commercial.

---

## Author

**Shaon Ahmed Ronok**

[shaon.neocities.org](https://shaon.neocities.org) · [github.com/shaonahmedronok1](https://github.com/shaonahmedronok1)

