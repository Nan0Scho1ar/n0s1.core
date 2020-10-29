# n0s1.core

### Several suckless shell scripts and other core features.

## Shell

### FZY
I found myself using fzf a lot and building it into my scripts.
But on a number of occasions I was working on machines which didn't have it installed.
This covers many of my use cases (Like fuzzy menus) in < 20 lines of shell script.

I have also included FZY_Lite which is basically the same logic but squished into 10 SLOC
(And smaller comment) for embedding inside scripts.

### TOML
POSIX Compliant shell script for reading from + writing to TOML files.

### BISH
Floating shell used for loading scripts and managing the system configuration.
Built to allow easy customization supporting bioinformatics workloads,
but generally just a good tool for extending your shell.
