# If not running interactively, don't do anything
[[ $- != *i* ]] && return

cd() {
	if builtin cd "$@"; then
		lsd
	fi
}

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
