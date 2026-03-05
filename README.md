<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:ffb7c5,100:c2185b&height=180&section=header&text=dotfiles&fontSize=36&fontColor=fff&fontAlignY=38&desc=Arch%20Linux%20%C2%B7%20NixOS%20%C2%B7%20River%20WM%20%C2%B7%20Wayland&descAlignY=58&descColor=ffe0ec"/>

[![Website](https://img.shields.io/badge/🌸%20shaon.neocities.org-c2185b?style=for-the-badge)](https://shaon.neocities.org)
[![Arch](https://img.shields.io/badge/Arch%20Linux-%231793D1.svg?style=for-the-badge&logo=archlinux&logoColor=white)](https://archlinux.org)
[![NixOS](https://img.shields.io/badge/NixOS-%235277C3.svg?style=for-the-badge&logo=nixos&logoColor=white)](https://nixos.org)
[![River](https://img.shields.io/badge/River-WM-c2185b?style=for-the-badge&logo=wayland&logoColor=white)](https://isaacfreund.com/software/river/)

*Every setting has a reason. Nothing is default without examination.*

</div>

---

<div align="center">

---

## 🌸 Structure
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
├── .local/
│   └── bin/
├── .bashrc
└── packages.txt
```

---

<div align="center">

## 🌺 Install

</div>

Install all packages at once:
```bash
sudo pacman -S --needed - < packages.txt
```

---

<div align="center">

## 🌸 Design Principles

</div>

- **Everything explicit** — no hidden defaults, no magic
- **Documented** — every structural choice has a comment
- **Reproducible** — clone and apply, same result every time
- **Minimal** — nothing included without a demonstrable function

---

<div align="center">

## 🌺 License

MIT — use freely. Personal, academic, commercial.

---

*"The burden of proof lies with the addition."*

**Shaon Ahmed Ronok**

[shaon.neocities.org](https://shaon.neocities.org) · [github.com/shaonahmedronok1](https://github.com/shaonahmedronok1)

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:c2185b,100:ffb7c5&height=120&section=footer"/>

</div>
