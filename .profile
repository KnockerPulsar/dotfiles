# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


. "$HOME/.cargo/env"


# Have to have these here instead of .bashrc since rofi seems to load PATH before .bashrc is read.
export PATH=$PATH:/mnt/AAE4829AE4826901/LinuxPrograms/qt/5.15.2/gcc_64/bin/
export PATH=$PATH:/mnt/AAE4829AE4826901/LinuxPrograms/qt/Tools/QtCreator/bin
export PATH=$PATH:/opt/Jetbrains/apps/IDEA-U/ch-0/221.5921.22/bin
export PATH=$PATH:~/eclipse-jdt/bin
export PATH=$PATH:/home/tarek/.jdks/corretto-16.0.2/bin
export PATH=$PATH:/home/tarek/flexlm_artwork_v11.17.2.linux64
