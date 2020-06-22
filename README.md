# CHERI-make

## WORK IN PROGRESS
**currently only runs on FreeBSD**

Auto builds cheri for first time running.

This forms part of a larger documentation effort I host [here](https://nsrutherford.com/notes/cheri)

## Install

Clone this repo and use `make build` to build cheri and its dependencies using cheribuild.py. Type `make run-no-update` (experimental) to run cheri-bsd (MIPS).

```bash
git clone https://github.com/nsrutherford/make-cheri.git

cd make-cheri

make build
```
