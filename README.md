# About

This `unix` repository includes `sh-tools`, a collection of shitty shell scripts for everyday computing, and `dotfiles` configuration files, for my personal use. Recently added is `web-tools`, which is another collection of stupid shell scripts that helps me with maintaining [artnoi.com](https://artnoi.com).

## Installation

To install, first clone this repository:  

    $ git clone https://gitlab.com/artnoi-staple/unix.git

Then change working directory to the repository:

    $ cd /path/to/unix/repo

and execute install.sh to sync the files using either `rsync` or `cp`:

    $ ./install.sh

## Examples  

### up  

Cross-platform package manager/system update shortcut. Currently supports macOS, Debian, Fedora, Void and Arch Linux, and FreeBSD. Users can easily change commands by editting `up.tables` file.

### svstat  

Shortcuts for `systemctl`. Although not very useful, I use it very often.

#### ssc  

Shell script that `sed`s `sshd_config` (hence s s c)

## License  

shit-tools was distributed under BSD License, but now it is under [Unlicense](https://unlicense.org/)

## Dependencies  

`sh-tools` and `web-tools` require `dotfiles` provided in this repository.

# dotfiles

This is a collection of UNIX dotfiles. Most color themes (like those in `.Xresources` or `.vim/colors` are mixed from various other open-source projects, which I did not keep track of, so *I'm terribly sorry if I cannot give credit to the orginal creator of such themes*.

`.bashrc`, `.bash_profile` and their source files (i.e. files in `.config/shell`) are usually required if you want to use `sh-tools` shell script. 

## Credit 

- [Matthias' dotfiles](https://github.com/mathiasbynens/dotfiles) I derive most of bash config files from this repository.

- Several other color schemes (terminal themes) - I forgot which line is from which project - and Google search didn't help. Perhaps I got some of it from a compilation like [this one](https://github.com/logico-dev/Xresources-themes).

- [vim-afterglow](https://github.com/danilo-augusto/vim-afterglow) My favorite color scheme for `vim`. Does not work on some systems (currently).

- Some files are modifications of my Linux distribution default config files - so very special thanks to **MX Linux** (for `.conkyrc` and some element in bash config files) and **Manjaro Linux** (for `.Xresources` with `urxvt` configuration)
