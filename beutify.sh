#!/bin/bash

BLACK="\e[30m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[37m"

BOLD_BLACK="\e[1;30m"
BOLD_RED="\e[1;31m"
BOLD_GREEN="\e[1;32m"
BOLD_YELLOW="\e[1;33m"
BOLD_BLUE="\e[1;34m"
BOLD_MAGENTA="\e[1;35m"
BOLD_CYAN="\e[1;36m"
BOLD_WHITE="\e[1;37m"

UNDERLINE_BLACK="\e[4;30m"
UNDERLINE_RED="\e[4;31m"
UNDERLINE_GREEN="\e[4;32m"
UNDERLINE_YELLOW="\e[4;33m"
UNDERLINE_BLUE="\e[4;34m"
UNDERLINE_MAGENTA="\e[4;35m"
UNDERLINE_CYAN="\e[4;36m"
UNDERLINE_WHITE="\e[4;37m"

BG_BLACK="\e[40m"
BG_RED="\e[41m"
BG_GREEN="\e[42m"
BG_YELLOW="\e[43m"
BG_BLUE="\e[44m"
BG_MAGENTA="\e[45m"
BG_CYAN="\e[46m"
BG_WHITE="\e[47m"

BOLD="\e[1m"
RESET="\e[0m"

SPINNER=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
COLORS=("\e[1;31m" "\e[1;33m" "\e[1;32m" "\e[1;36m" "\e[1;34m" "\e[1;35m")

spin_wheel() {
    local pid=$1  # Process ID of the running task
    local i=0     # Spinner frame index
    local c=0     # Color index

    while kill -0 "$pid" 2>/dev/null; do
        echo -ne "\r${COLORS[c]}${SPINNER[i]} \e[1;37mInstalling $2...\e[0m"
        sleep 0.1
        ((i=(i+1)%10))
        ((c=(c+1)%6))
    done

    echo -e "\r\e[1;32m✔ $2 installed successfully!     \e[0m"
    sleep 1.5
}

check_update() {
    apt update -y > /dev/null 2>&1 && apt upgrade -y > /dev/null 2>&1 &
    TASK_PID=$!
    clear
    echo -e "${YELLOW}Termux updateing & upgrading..${RESET}"
    spin_wheel "$TASK_PID"   
}

check_update

check_install() {
    apt install figlet -y > /dev/null 2>&1 &
    TASK_PID=$!
    spin_wheel "$TASK_PID" "figlet"
    gem install lolcat > /dev/null 2>&1 &
    TASK_PID=$!
    spin_wheel "$TASK_PID" "lolcat"
   
}

clear
check_install
clear

mv_fnt(){
    cp fig-fnt/* /data/data/com.termux/files/usr/share/figlet
}

check_internet() {
    ping -c 1 -W 2 8.8.8.8 > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        sleep 1
    else
	clear
	echo ""
        echo -e "${RED}Internet On Krle Bhai | And dobara Run krr..${RESET}"
	exit 0
    fi
}

printBanner(){
    clear
    
    figlet -f Rectangles BEUTIFY | lolcat

    echo -e "${CYAN}╭──────────────────────────────────────────╮${RESET}"
    echo -e "${CYAN}│${RESET}   ${BOLD}${RED} BEUTIFY A DESIGNING TOOL FOR TERMUX${RESET}   ${CYAN}│${RESET}"
    echo -e "${CYAN}├──────────────────────────────────────────┤${RESET}"
    echo -e "${CYAN}│${RESET}  ${BOLD}👤 Author  :${RESET} ${GREEN}@venom${RESET}                     ${CYAN}│${RESET}"
    echo -e "${CYAN}│${RESET}  ${BOLD}🔢 Version :${RESET} ${MAGENTA}1.0${RESET}                        ${CYAN}│${RESET}"
    echo -e "${CYAN}│${RESET}  ${BOLD}🌐 GitHub  :${RESET} ${BLUE}github.com/venom-x-999${RESET}     ${CYAN}│${RESET}"
    echo -e "${CYAN}╰──────────────────────────────────────────╯${RESET}"

    echo ""
}

userChoice() {
    echo -e "${BOLD_YELLOW}[1] Continue${RESET}"
    echo -e "${BOLD_RED}[2] Exit${RESET}"
    echo ""

    echo -ne "${BOLD_CYAN}Enter your choice: ${RESET}"
    read choice

    case $choice in
        1) 
            echo -e "${GREEN}Continuing...${RESET}"
            mv_fnt
            sleep 1
            ;;
        2) 
            echo -e "${RED}Exiting...${RESET}"
	    sleep 1
            exit 0
            ;;
        *)
            echo -e "${BOLD_RED}Invalid choice! Please select 1 or 2.${RESET}"
            userChoice  
            ;;
    esac
}


###FONT_LIST=("slant" "shadow" "block" "starwars" "big" "banner3-D" "digital" "rectangles" "univers" "smisome1")

### styles ps1

PS1_1="\n\[\e[1;37m\]╭──\[\e[1;31m\](root👽kali)\[\e[1;37m\]─[\w]\n\[\e[1;37m\]╰─\[\e[1;31m\]# \[\e[0m\]"
PS1_2="\n\[\e[1;37m\][DragonShell🐉]-\[\e[1;31m\](\w)\n\[\e[1;37m\]└─\[\e[1;31m\]➤ \[\e[0m\]"
PS1_3="\n\[\e[1;31m\]╔═\[\e[1;37m\][CyberPunk😈]\n\[\e[1;31m\]╚═[\w]➠ \[\e[0m\]"
PS1_4="\n\[\e[1;37m\]──\[\e[1;31m\]{Pentest🔍}\[\e[1;37m\]──[\w]\n\[\e[1;37m\]➜ \[\e[0m\]"

change_font() {
    clear
    echo""
    echo -e "${CYAN}╭────────────────────────────────────────╮${RESET}"
    echo -e "${CYAN}│      🎨 ${BOLD}${WHITE}Select a Font for Termux${RESET}       ${CYAN}│${RESET}"
    echo -e "${CYAN}├────────────────────────────────────────┤${RESET}"
    echo -e "${CYAN}│ ${RED} [01] ${GREEN}Speed${RESET}      ${CYAN} | ${RED} [06] ${GREEN}Bloody${RESET}       ${CYAN}│${RESET}"
    echo -e "${CYAN}│ ${RED} [02] ${GREEN}Kban${RESET}       ${CYAN} | ${RED} [07] ${GREEN}Fender${RESET}       ${CYAN}│${RESET}"
    echo -e "${CYAN}│ ${RED} [03] ${GREEN}Thorned${RESET}    ${CYAN} | ${RED} [08] ${GREEN}Soft${RESET}         ${CYAN}│${RESET}"
    echo -e "${CYAN}│ ${RED} [04] ${GREEN}Banner3${RESET}    ${CYAN} | ${RED} [09] ${GREEN}smpoison${RESET}     ${CYAN}│${RESET}"
    echo -e "${CYAN}│ ${RED} [05] ${GREEN}Tombstone${RESET}  ${CYAN} | ${RED} [10] ${GREEN}Lockergnome${RESET}  ${CYAN}│${RESET}"
    echo -e "${CYAN}╰────────────────────────────────────────╯${RESET}"
    echo -e "${RED}Note*: ${GREEN}01 Means 1 So write without 0 ${RESET}"
    echo ""
    echo -ne "${BOLD_YELLOW}Enter a Number[1-10]: ${RESET}"
    read font_choice

    if [[ $font_choice -lt 1 || $font_choice -gt 10 ]]; then
        echo -e "${BOLD_RED}Invalid choice! Please select a number between 1 and 10.${RESET}"
        exit 1
    fi

    echo -ne "${BOLD_BLUE}Write Header Text Here:  ${RESET}"
    read text

    FONT_LIST=("Speed" "Kban" "Thorned" "Banner3" "Tombstone" "Bloody" "Fender" "Soft" "smpoison" "Lockergnome")
    SELECTED_FONT=${FONT_LIST[$font_choice-1]}
}


change_ps1() {
    echo ""
    echo -e "${CYAN}╭────────────────────────────────────────╮${RESET}"
    echo -e "${CYAN}│         💻 ${BOLD}${WHITE}Select a PS1 Prompt${RESET}         ${CYAN}│${RESET}"
    echo -e "${CYAN}├────────────────────────────────────────┤${RESET}"
    echo -e "${CYAN}│ ${RED} [01] ${GREEN}root👽kali ${YELLOW}(recomended @venom)${RESET}   ${CYAN}│${RESET}"
    echo -e "${CYAN}│ ${RED} [02] ${GREEN}DragonShell 🐉${RESET}                   ${CYAN}│${RESET}"
    echo -e "${CYAN}│ ${RED} [03] ${GREEN}CyberPunk 😈${RESET}                     ${CYAN}│${RESET}"
    echo -e "${CYAN}│ ${RED} [04] ${GREEN}Pentest 🔍${RESET}                       ${CYAN}│${RESET}"
    echo -e "${CYAN}╰────────────────────────────────────────╯${RESET}"
    echo ""
    
    echo -ne "${BOLD_YELLOW}Enter a Number[1-4]: ${RESET}"
    read ps1_choice

    if [[ $ps1_choice -lt 1 || $ps1_choice -gt 4 ]]; then
        echo -e "${BOLD_RED}Invalid choice! Please select a number between 1 and 4.${RESET}"
        exit 1
    fi

    case $ps1_choice in
        1) SELECTED_PS1="$PS1_1" ;;
        2) SELECTED_PS1="$PS1_2" ;;
        3) SELECTED_PS1="$PS1_3" ;;
        4) SELECTED_PS1="$PS1_4" ;;
    esac
}

apply_changes() {
    TEMP_BASHRC="$HOME/temp_bash.bashrc"

    echo "# Custom Termux Homepage" > "$TEMP_BASHRC"
    echo "clear" >> "$TEMP_BASHRC"
    echo "figlet -f \"$SELECTED_FONT\" \"$text\" | lolcat" >> "$TEMP_BASHRC"
    echo "export PS1=\"$SELECTED_PS1\"" >> "$TEMP_BASHRC"

    mv "$TEMP_BASHRC" /data/data/com.termux/files/usr/etc/bash.bashrc

    source /data/data/com.termux/files/usr/etc/bash.bashrc
}

colorful_message() {
    clear
    msg="Termux homepage and PS1 prompt updated!"
    restart_msg="Please restart your Termux."

    echo ""

    for i in {1..3}; do
        echo -ne "\e[1;32m\e[5m${msg}\e[0m\r"
        sleep 0.2
        echo -ne "\r${msg}    \r"
        sleep 0.2
    done
    echo -e "\e[1;32m${msg}\e[0m"

    sleep 1

    for i in {1..3}; do
        echo -ne "\e[1;33m\e[5m${restart_msg}\e[0m\r"
        sleep 0.2
        echo -ne "\r${restart_msg}    \r"
        sleep 0.2
    done
    echo -e "\e[1;33m${restart_msg}\e[0m"
}

printBanner
check_internet
userChoice
change_font
change_ps1
apply_changes
colorful_message
