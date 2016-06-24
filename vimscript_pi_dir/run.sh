#!/usr/bin/env bash

# See: http://vim.wikia.com/wiki/Vim_as_a_system_interpreter_for_vimscript
vim -i NONE -u NORC -U NONE -V1 -nNesS pi.vimscript -c'echo""|qall!' -- pi.vimscript


