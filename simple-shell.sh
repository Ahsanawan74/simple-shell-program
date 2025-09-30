#!/bin/bash

# simple-shell.sh - A comprehensive shell program merging multiple scripts
# Based on ruanyf/simple-bash-scripts

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to display menu
show_menu() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${GREEN}    SIMPLE SHELL PROGRAM${NC}"
    echo -e "${BLUE}================================${NC}"
    echo "1. System Information"
    echo "2. File Operations"
    echo "3. Process Management"
    echo "4. Network Utilities"
    echo "5. Backup Operations"
    echo "6. Text Processing"
    echo "7. Calculator"
    echo "8. File Search"
    echo "9. Disk Usage"
    echo "10. User Management"
    echo "11. Exit"
    echo -e "${BLUE}================================${NC}"
    echo -n "Enter your choice [1-11]: "
}
# System Information
system_info() {
    echo -e "${YELLOW}=== System Information ===${NC}"
    echo "Hostname: $(hostname)"
    echo "Kernel: $(uname -r)"
    echo "Architecture: $(uname -m)"
    echo "Current user: $(whoami)"
    echo "Shell: $SHELL"
    echo "Running in: Git Bash on Windows"
    echo -e "${GREEN}Disk Space:${NC}"
    df -h /
}

# File Operations
file_operations() {
    echo -e "${YELLOW}=== File Operations ===${NC}"
    echo "1. List files"
    echo "2. Create directory"
    echo "3. Create file"
    echo "4. Copy file"
    echo "5. Move file"
    echo "6. Back to main menu"
    
    read -p "Choose file operation [1-6]: " file_choice
    
    case $file_choice in
        1)
            ls -la
            ;;
        2)
            read -p "Enter directory name: " dirname
            dirname=$(echo "$dirname" | xargs)  # Clean the input
            mkdir -p "$dirname"
            echo "Directory '$dirname' created"
            ;;
        3)
            read -p "Enter filename: " filename
            filename=$(echo "$filename" | xargs)  # Clean the input
            touch "$filename"
            echo "File '$filename' created"
            ;;
        4)
            read -p "Enter source file: " source
            read -p "Enter destination: " dest
            source=$(echo "$source" | xargs)  # Clean the input
            dest=$(echo "$dest" | xargs)      # Clean the input
            cp "$source" "$dest"
            echo "File copied from $source to $dest"
            ;;
        5)
            read -p "Enter source file: " source
            read -p "Enter destination: " dest
            source=$(echo "$source" | xargs)  # Clean the input
            dest=$(echo "$dest" | xargs)      # Clean the input
            mv "$source" "$dest"
            echo "File moved from $source to $dest"
            ;;
        6)
            return
            ;;
        *)
            echo -e "${RED}Invalid choice${NC}"
            ;;
    esac
}
# Process Management
process_management() {
    echo -e "${YELLOW}=== Process Management ===${NC}"
    echo "1. Show running processes"
    echo "2. Kill process by PID"
    echo "3. Back to main menu"
    
    read -p "Choose process operation [1-3]: " process_choice
    
    case $process_choice in
        1)
            echo "Running Processes:"
            ps aux
            ;;
        2)
            read -p "Enter PID to kill: " pid
            if kill "$pid" 2>/dev/null; then
                echo "Process $pid killed"
            else
                echo "Failed to kill process $pid"
            fi
            ;;
        3)
            return
            ;;
        *)
            echo -e "${RED}Invalid choice${NC}"
            ;;
    esac
}

# Network Utilities
network_utils() {
    echo -e "${YELLOW}=== Network Utilities ===${NC}"
    echo "1. Check network connectivity"
    echo "2. Show IP information"
    echo "3. Back to main menu"
    
    read -p "Choose network operation [1-3]: " net_choice
    
    case $net_choice in
        1)
            echo "Testing internet connection..."
            if ping -n 4 google.com > /dev/null 2>&1; then
                echo -e "${GREEN}✓ Internet is working${NC}"
            else
                echo -e "${RED}✗ No internet connection${NC}"
            fi
            ;;
        2)
            echo "Network Information:"
            echo "===================="
            echo "Computer Name: $(hostname)"
            echo -n "Public IP: "
            public_ip=$(curl -s https://api.ipify.org 2>/dev/null)
            if [ -n "$public_ip" ]; then
                echo "$public_ip"
            else
                echo "Not available"
            fi
            echo ""
            echo "For local network info:"
            echo "- Open Windows Command Prompt"
            echo "- Type: ipconfig"
            ;;
        3)
            return
            ;;
        *)
            echo -e "${RED}Invalid choice${NC}"
            ;;
    esac
}

# Backup Operations
backup_ops() {
    echo -e "${YELLOW}=== Backup Operations ===${NC}"
    echo "Note: This will backup the CURRENT directory"
    echo "Current location: $(pwd)"
    
    read -p "Enter backup filename: " backup_file
    
    # Clean input
    backup_file=$(echo "$backup_file" | xargs)
    
    if [ -z "$backup_file" ]; then
        backup_file="my_backup"
    fi
    
    echo "Creating backup of current directory..."
    
    if tar -czf "${backup_file}.tar.gz" . 2>/dev/null; then
        echo -e "${GREEN}✓ Backup created: ${backup_file}.tar.gz${NC}"
    else
        echo -e "${RED}✗ Backup failed${NC}"
    fi
}

# Text Processing
text_processing() {
    echo -e "${YELLOW}=== Text Processing ===${NC}"
    echo "Current directory: $(pwd)"
    echo "Files here: $(ls -p | grep -v / | tr '\n' ' ')"
    echo ""
    
    echo "1. Count lines in file"
    echo "2. Count words in file"
    echo "3. Search text in file"
    echo "4. Back to main menu"
    
    read -p "Choose text operation [1-4]: " text_choice
    
    case $text_choice in
        1|2|3)
            read -p "Enter filename: " filename
            filename=$(echo "$filename" | xargs)
            
            if [ ! -f "$filename" ]; then
                echo -e "${RED}File '$filename' not found! Available: $(ls -p | grep -v/ | xargs)${NC}"
                return
            fi
            
            case $text_choice in
                1) echo "Lines: $(wc -l < "$filename")" ;;
                2) echo "Words: $(wc -w < "$filename")" ;;
                3) 
                    read -p "Search for: " text
                    grep -n "$text" "$filename" || echo "Not found"
                    ;;
            esac
            ;;
        4) return ;;
        *) echo -e "${RED}Invalid choice${NC}" ;;
    esac
}
# Calculator
calculator() {
    echo -e "${YELLOW}=== Calculator ===${NC}"
    echo "1. Addition"
    echo "2. Subtraction"
    echo "3. Multiplication"
    echo "4. Division"
    echo "5. Back to main menu"
    
    read -p "Choose operation [1-5]: " calc_choice
    
    case $calc_choice in
        1)
            read -p "Enter first number: " num1
            read -p "Enter second number: " num2
            result=$((num1 + num2))
            echo "Result: $result"
            ;;
        2)
            read -p "Enter first number: " num1
            read -p "Enter second number: " num2
            result=$((num1 - num2))
            echo "Result: $result"
            ;;
        3)
            read -p "Enter first number: " num1
            read -p "Enter second number: " num2
            result=$((num1 * num2))
            echo "Result: $result"
            ;;
        4)
            read -p "Enter first number: " num1
            read -p "Enter second number: " num2
            if [ "$num2" -eq 0 ]; then
                echo -e "${RED}Error: Division by zero${NC}"
            else
                result=$((num1 / num2))
                echo "Result: $result"
            fi
            ;;
        5)
            return
            ;;
        *)
            echo -e "${RED}Invalid choice${NC}"
            ;;
    esac
}

# File Search
file_search() {
    echo -e "${YELLOW}=== File Search ===${NC}"
    echo "Current directory: $(pwd)"
    echo ""
    
    read -p "Enter search pattern: " pattern
    pattern=$(echo "$pattern" | xargs)
    
    echo "Searching in current directory..."
    echo -e "${GREEN}Files containing '$pattern' in their name:${NC}"
    
    # Search in current directory only
    find . -maxdepth 2 -name "*$pattern*" 2>/dev/null | head -20
    
    if [ $? -ne 0 ]; then
        echo "No files found matching '$pattern'"
    fi
}

# Disk Usage
disk_usage() {
    echo -e "${YELLOW}=== Disk Usage ===${NC}"
    echo "1. Show disk usage by partition"
    echo "2. Show disk usage by directory"
    echo "3. Back to main menu"
    
    read -p "Choose disk operation [1-3]: " disk_choice
    
    case $disk_choice in
        1)
            df -h
            ;;
        2)
            read -p "Enter directory (default: current): " dir
            dir=${dir:-.}
            if [ -d "$dir" ]; then
                du -sh "$dir"/*
            else
                echo -e "${RED}Directory $dir does not exist${NC}"
            fi
            ;;
        3)
            return
            ;;
        *)
            echo -e "${RED}Invalid choice${NC}"
            ;;
    esac
}

# User Management
user_management() {
    echo -e "${YELLOW}=== User Management ===${NC}"
    echo "1. Show current user"
    echo "2. Show logged in users"
    echo "3. Show user groups"
    echo "4. Back to main menu"
    
    read -p "Choose user operation [1-4]: " user_choice
    
    case $user_choice in
        1)
            echo "Username: $(whoami)"
            echo "User ID: $(id -u)"
            echo "Group ID: $(id -g)"
            echo "Groups: $(groups)"
            ;;
        2)
            who
            ;;
        3)
            echo "Current user groups:"
            groups
            ;;
        4)
            return
            ;;
        *)
            echo -e "${RED}Invalid choice${NC}"
            ;;
    esac
}

# Main program loop
main() {
    while true; do
        show_menu
        read choice
        
        case $choice in
            1)
                system_info
                ;;
            2)
                file_operations
                ;;
            3)
                process_management
                ;;
            4)
                network_utils
                ;;
            5)
                backup_ops
                ;;
            6)
                text_processing
                ;;
            7)
                calculator
                ;;
            8)
                file_search
                ;;
            9)
                disk_usage
                ;;
            10)
                user_management
                ;;
            11)
                echo -e "${GREEN}Thank you for using Simple Shell Program!${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}Invalid choice. Please try again.${NC}"
                ;;
        esac
        
        echo
        read -p "Press Enter to continue..."
        clear
    done
}

# Check if bc is installed for calculator
if ! command -v bc &> /dev/null; then
    echo -e "${YELLOW}Warning: 'bc' calculator not found. Installing...${NC}"
    sudo apt-get update && sudo apt-get install -y bc
fi

# Start the program
clear
main