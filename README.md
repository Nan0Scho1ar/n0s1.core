# n0s1.core

### Several suckless shell scripts and other core features.

## Shell

### FZY: Command Line Fuzzy Finder 
([link](fzy))

I found myself using fzf a lot and building it into my scripts.
But on a number of occasions I was working on machines which didn't have it installed.
This covers many of my use cases (Like fuzzy menus) in < 20 lines of shell script.

#### FZY_Lite: 10 SLOC Command Line Fuzzy Finder 
([link](fzy_lite))
I have also included FZY_Lite which is basically the same logic but squished into 10 SLOC
(And smaller comment) for embedding inside scripts.

### TOML: Simple get/set commands to read and write toml files 
([link](toml))
POSIX Compliant shell script for reading from + writing to TOML files.

### BISH 
([link](bish))
Floating shell used for loading scripts and managing the system configuration.
Built to allow easy customization supporting bioinformatics workloads,
but generally just a good tool for extending your shell.

### BM: Bookmarks 
([link](bm))
Bookmarks for everything.

### CHECK_ROOT: Throws an error if the current user is not root 
([link](check_root))
Checks if the current user is root.

### DISCORD_WEBHOOKS: Tool for managing and messaging using discord webhooks 
([link](discordwebhooks))
Manage webhooks to post as multiple users, for multiple channels in your servers.

### HIST: Shell history made easy 
([link](hist))
Tool for working with shell history.

### USELESS: less but less code. Seriously, just use less. 
([link](useless))
Less but written in 20 lines of shell script.
Not designed to be used as is, more a foundation for other CLI tools

### HACKLESS: The hackable less 
([link](hackless))
More extensible version of useless.

### SETUP
([link](setup))
Script to set up parts of NanOS
