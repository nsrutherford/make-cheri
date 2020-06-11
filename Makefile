build: cheri-build
	@echo "[+] Finished Build"

cheri-build: sys-deps
	@echo "[*] Building CHERI"
	@echo -e "\t[*] Cloning git repo into $(HOME)/cheribuild"
	git clone https://github.com/CTSRD-CHERI/cheribuild ~/cheribuild 

sys-deps:
	@echo "[*] Installing system packages"
	pkg install  -y git cmake python3 gmake gcc perl5 ninja libtool autoconf automake pkgconf glib gsed gmake pixman cmake samba410 texinfo vim
	@echo "[+] Done installing system packages"	
