#!/bin/bash

#Remove old configuration
rm -f ~/.emacs
rm -rf ~/.emacs.d

#Add new configuration
cp emacs ~/.emacs
cp -r emacs.d ~/.emacs.d
