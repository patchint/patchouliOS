# Patchouli OS

This repository is about a simple OS :)

I was bored but it works lol.

If you want to follow the advancement of the project, go on my [Kanboard](https://kb.patchli.fr/?controller=BoardViewController&action=readonly&token=8d3f54b9e60087e3aef7579353d02712d9d75c4910455db6f7db15851d9d)

## Requirements

ArchLinux :

```bash
sudo pacman -Syy
sudo pacman -S nasm qemu gcc bison flex gmp mpc mpfr texinfo
```

Debian :

```bash
sudo apt update
sudo apt install nasm qemu-system-x86 gcc
```

## Build and run

```bash
make run
```

## Just build

```bash
make all
```

## Cleaning

```bash
make clean
```
