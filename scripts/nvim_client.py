# -*- coding: utf-8 -*-
# This script open file via Neovim RPC protocol
import sys
import neovim

SERVER = '\\\\.\\pipe\\nvim-pipe-12345'

def main(argv):
    try:
        nvim = neovim.attach("socket", path=SERVER)
    except Exception:
        print("[!] Neovim not found.")
        return 1
    path = sys.argv[1]
    nvim.command(f':e {path}')
    nvim.close()
    return 0


if __name__ == "__main__":
    ret = main(sys.argv)
    sys.exit(ret)
