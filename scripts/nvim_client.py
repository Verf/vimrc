# -*- coding: utf-8 -*-
# This script open file via Neovim RPC protocol
import os
import sys
from pynvim import attach

SERVER = '\\\\.\\pipe\\nvim-pipe-12345'

def main(argv):
    path =argv[1] if len(argv) > 0 else ''
    try:
        nvim = attach("socket", path=SERVER)
    except Exception:
        nvim = None
    if nvim:
        nvim.command(f':e {path}')
        nvim.close()
    else:
        os.system(f'start nvim-qt {path}')
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
