HOME = ~
CHERI_HOME = $(HOME)/cheri
CHERI_SDK = $(CHERI_HOME)/output/sdk
ENV_SCRIPTS_DIR = $(CHERI_HOME)/env_scripts
ENV_SCRIPT = $(ENV_SCRIPTS_DIR)/env.sh

# NOTE - this will completely reinstall CHERI (removing all previous files)
.PHONY: cheri-build
build: cheri-build
	@echo "[+] Finished Build"

.PHONY: sys-deps
cheri-build: sys-deps
	@echo "[*] Building CHERI"
	@if test -d ~/cheribuild; then \
		rm -r ~/cheribuild; \
	fi

	git clone https://github.com/CTSRD-CHERI/cheribuild ~/cheribuild

	@echo -e "\t[*] Building CHERI components - this can take a while, be patient ^^)"
	@cd ~/cheribuild ; ./cheribuild.py llvm -d -f ; ./cheribuild.py qemu -d -f ; ./cheribuild.py disk-image -d -f
	@echo -e "[*] Configure host env vars"
	@echo 'setenv CHERI_HOME $(HOME)/cheri' >> ~/.cshrc
	@echo 'setenv CHERI_SDK $(CHERI_HOME)/output/sdk' >> ~/.cshrc
	@echo 'setenv CCFLAGS "-mabi=purecap --sysroot $(CHERI_SDK)/sysroot128 -B $(CHERI_SDK) -target mips64-unknown-freebsd13"' >> ~/.cshrc 
	@echo 'alias cclang $(CHERI_SDK)/bin/clang' >> ~/.cshrc

	mkdir -p $(ENV_SCRIPTS_DIR)

	@echo 'setenv CHERI_HOME /root/cheri' >> $(ENV_SCRIPT)
	@echo 'qemu-mount-rootfs.sh' >> $(ENV_SCRIPT)
	@echo 'qemu-mount-sources.sh' >> $(ENV_SCRIPT)

	@echo "[+] Done building CHERI, please run 'source ~/.cshrc' to update your host configuration, and use 'make run-no-update' to start cheri-qemu"

.PHONY: sys-deps
sys-deps:
	@echo "[*] Installing system packages"
	@pkg install  -y git cmake python3 gmake gcc perl5 ninja libtool autoconf automake pkgconf glib gsed gmake pixman cmake samba410 texinfo vim
	@echo "[+] Done installing system packages"

.PHONY: run-no-update
run-no-update:
	@echo "[*] Starting CHERI-BSD in QEMU"
	@cd ~/cheribuild ; ./cheribuild.py run --skip-update

.PHONY: clean
clean:
	rm -rf ~/cheribuild ~/cheri
