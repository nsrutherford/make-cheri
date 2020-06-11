build: cheri-build
	@echo "[+] Finished Build"

cheri-build: sys-deps
	@echo "[*] Building CHERI"
	@if test -d ~/cheribuild; then \
		echo -e "\t[*] Found existing cheribuild directory"; \
	else \
		echo -e "\t[*] Cloning git repo into $(HOME)/cheribuild"; \
		git clone https://github.com/CTSRD-CHERI/cheribuild ~/cheribuild; \
	fi

	@echo -e "\t[*] Building CHERI components - this can take a while, be patient ^^)"
	@cd ~/cheribuild ; ./cheribuild.py llvm -d -f ; ./cheribuild.py qemu -d -f ; ./cheribuild.py disk-image -d -f
	@echo -e "\t[+] CHERI dependencies built - run 'make run' to start cheri-bsd in qemu"

sys-deps:
	@echo "[*] Installing system packages"
	@pkg install  -y git cmake python3 gmake gcc perl5 ninja libtool autoconf automake pkgconf glib gsed gmake pixman cmake samba410 texinfo vim
	@echo "[+] Done installing system packages"

run:
	@echo "[*] Starting CHERI-BSD in QEMU"
	@cd ~/cheribuild ; ./cheribuild.py run

clean:
	rm -rf ~/cheribuild ~/cheri
