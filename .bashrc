
# If not running interactively, don't do anything
[[ $- != *i* ]] && return


alias Vdownload="proxychains4 yt-dlp -f 'bestvideo[height<=480]+bestaudio/best[height<=480]'"
alias ls='lsd --color=auto'
alias bashconf='vim ~/.bashrc'

# Networking aliases
alias ports='ss -tulnp'                    # Show listening ports
alias ipa='ip -c a'                        # Colorized ip addresses
alias ipr='ip -c route'                    # Colorized routing table
alias conns='ss -tupn'                     # Active connections

# Quick directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

# Colorize commands
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Safety nets
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Shortcuts for common commands
alias c='clear'
alias h='history'
alias j='jobs -l'

# Custom Wizard PS1 Prompt
wizard_prompt() {
    # Define colors
    local RED="\[\033[1;31m\]"
    local GREEN="\[\033[1;32m\]"
    local YELLOW="\[\033[1;33m\]"
    local BLUE="\[\033[1;34m\]"
    local PURPLE="\[\033[1;35m\]"
    local CYAN="\[\033[1;36m\]"
    local WHITE="\[\033[1;37m\]"
    local RESET="\[\033[0m\]"

    # Git branch (if in a git repo)
    local git_branch
    git_branch=$(git branch 2>/dev/null | sed -n -e 's/^\* \(.*\)/ � \1/p')

    # Exit code (if last command failed)
    local exit_code=""
    if [ $? != 0 ]; then
        exit_code="❌ "
    fi

    # Final PS1 construction
    PS1="\n${PURPLE}🧙‍♂️ ${CYAN}\u${WHITE}@${YELLOW}\h ${BLUE}\w${GREEN}${git_branch}${RESET}\n${exit_code}${RED}➜${RESET} "
}

# Create new QEMU image and optionally install from ISO
qemu-new() {
    local img="${1:-qemu.img}"
    local size="${2:-20G}"
    local iso="$3"
    
    qemu-img create -f qcow2 "$img" "$size"
    [ -n "$iso" ] && echo "Install with: qemu-install '$iso' '$img'"
}

# Install OS from ISO to image
qemu-install() {
    local iso="$1"
    local img="${2:-qemu.img}"
    
    qemu-system-x86_64 -enable-kvm -cpu host -smp 2 -m 4G \
        -cdrom "$iso" -hda "$img" -boot d
}

# Run existing image with good defaults
qemu-start() {
    local img="${1:-qemu.img}"
    
    qemu-system-x86_64 -enable-kvm -cpu host -smp 2 -m 4G \
        -vga virtio -display sdl,gl=on \
        -hda "$img" \
        -net nic -net user,hostfwd=tcp::2222-:22
}

# Run with SPICE for better graphics
qemu-spice() {
    local img="${1:-qemu.img}"
    
    qemu-system-x86_64 -enable-kvm -cpu host -smp 4 -m 8G \
        -vga qxl -spice port=5900,addr=127.0.0.1,disable-ticketing=on \
        -device virtio-serial-pci \
        -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
        -chardev spicevmc,id=spicechannel0,name=vdagent \
        -hda "$img"
}

<<<<<<< HEAD
PS1='[\W]\$ '

alias ls='lsd'
alias grep='grep --color=auto'
alias bashconfig="vim ~/.bashrc"
alias Vdownload="proxychains4 yt-dlp -f 'bestvideo[height<=480]+bestaudio/best[height<=480]'"

# Create new QEMU image and optionally install from ISO
qemu-new() {
    local img="${1:-qemu.img}"
    local size="${2:-20G}"
    local iso="$3"

    qemu-img create -f qcow2 "$img" "$size"
    [ -n "$iso" ] && echo "Install with: qemu-install '$iso' '$img'"
}

# Install OS from ISO to image
qemu-install() {
    local iso="$1"
    local img="${2:-qemu.img}"

    qemu-system-x86_64 -enable-kvm -cpu host -smp 2 -m 4G \
        -cdrom "$iso" -hda "$img" -boot d
}

# Run existing image with good defaults
qemu-start() {
    local img="${1:-qemu.img}"

    qemu-system-x86_64 -enable-kvm -cpu host -smp 2 -m 4G \
        -vga virtio -display sdl,gl=on \
        -hda "$img" \
        -net nic -net user,hostfwd=tcp::2222-:22
}

# Run with SPICE for better graphics
qemu-spice() {
    local img="${1:-qemu.img}"

    qemu-system-x86_64 -enable-kvm -cpu host -smp 4 -m 8G \
        -vga qxl -spice port=5900,addr=127.0.0.1,disable-ticketing=on \
        -device virtio-serial-pci \
        -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
        -chardev spicevmc,id=spicechannel0,name=vdagent \
        -hda "$img"
}
