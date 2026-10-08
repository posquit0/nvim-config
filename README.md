<img src="https://raw.githubusercontent.com/posquit0/vimrc/main/icon.png?v=3&s=200" align="left" width="128px" height="128px"/>

### **nvim-config by posquit0**
> *NeoVIM Configuration for nerds written by posquit0*

[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg?v=103)](https://opensource.org/licenses/mit-license.php)
[![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=103)](https://github.com/ellerbrock/open-source-badge/)

<br />

[**This NeoVIM configuration**](https://github.com/posquit0/nvim-config) is written by [posquit0](https://github.com/posquit0/) to improve the environment in NeoVIM.


## Usage

```sh
$ cd ~
$ git clone https://github.com/posquit0/nvim-config ~/.config/nvim
$ nvim --headless "+Lazy! restore" +qa
```

Use `:Lazy restore` after pulling configuration changes to restore the plugin
versions recorded in `lazy-lock.json`. `:Lazy sync` includes updates and rewrites
the lockfile; use it only when intentionally updating plugins.

### Updating plugins with chezmoi

The dotfiles repository keeps `external_nvim` as a submodule. Since `external_`
disables chezmoi filename attributes inside it, the dotfiles ignore rule excludes
`~/.config/nvim/lazy-lock.json` from copying. An `after` hook links that file to
the submodule's `lazy-lock.json` before the restore hook runs. Other nvim files
are copied normally.

1. Run `:Lazy update` on one machine and verify that Neovim works as expected.
   The symlink writes lockfile changes directly to the source repository;
   `chezmoi re-add` is no longer needed for this file.
2. Review and commit `lazy-lock.json` in the nvim repository, then commit the
   updated submodule reference in the parent dotfiles repository. Push both.
3. On other machines, pull the dotfiles and updated submodule, then run
   `chezmoi apply`. The dotfiles hook runs `Lazy restore` when the source
   lockfile changes.


## Contributing

This project follows the [**Contributor Covenant**](http://contributor-covenant.org/version/1/4/) Code of Conduct.

#### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/posquit0/nvim-config/issues) to report any bugs or ask feature requests.


## Self Promotion

Like this project? Follow the repository on [GitHub](https://github.com/posquit0/nvim-config). And if you're feeling especially charitable, follow [posquit0](https://posquit0.com) on [GitHub](https://github.com/posquit0).


## See Also

- [brewfile](https://github.com/posquit0/brewfile) - Brewfile to install softwares in macOS for engineers.
- [dotfiles](https://github.com/posquit0/dotfiles) - Awesome configurations for the development environments.
- [gitconfig](https://github.com/posquit0/gitconfig) - Git configurations.
- [tmux-conf](https://github.com/posquit0/tmux-conf) - TMUX Configuration for nerds with tpm.
- [vimrc](https://github.com/posquit0/vimrc) - Vim Configuration for nerds with vim-plug.
- [zshrc](https://github.com/posquit0/zshrc) - Zsh Configuration for nerds with zplug.


## License

Provided under the terms of the [MIT License](https://github.com/posquit0/nvim-config/blob/main/LICENSE).

Copyright © 2023-2026, [Byungjin Park](https://www.posquit0.com).
