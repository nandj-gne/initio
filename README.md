initio
=======

*Endpoint and personal infra provisioning, like magic*

[![Build Status][travis-badge]][travis-link]
[![MIT licensed][mit-badge]][mit-link]

![Wizards](https://i.giphy.com/media/5tlq0pRndGu8U/giphy.webp)


This is a collection of [ansible](https://www.ansible.com/) playbooks for provisioning a new laptop, server, or other endpoint in a bespoke setup. Ideally, new systems should be up and running within a few commands.


Quick Start
-----------

Edit [`config.yml`](.config/initio/config.yml) as needed. Most defaults are specific to my setup. Remember to update the deploy key path for the "Secrets" repo before provisioning.

Use the included `bootstrap.sh` file to setup and execute the runbook.

```
❯ curl https://raw.githubusercontent.com/jnand/initio/master/.local/share/initio/bootstrap.sh --output bootstrap.sh
❯ ./bootstrap.sh
```

The runbook will ask about the setup: laptop, workstation, headnode, fileserver, or compute node; and if the system is a home or work box. Each type also has its own playbook found in `.config/initio/playbooks` for idividual push-deploys. **Home** will use personal settings and private repos, while **work** only uses common settings and public repos -- *i.e.* a box configured for work _**won't**_ have your personal dropbox, github keys, fileserver creds, etc...


:exclamation: Remember to check the [Manual Post-Install](#manual-install) checklist.


Built with
-----------

<dl>
	<dt>Ansible</dt>
	<dd>An IT automation suite for deploying and provisioning new systems (https://www.ansible.com/)</dd>

	<dt>Homebrew</dt>
	<dd>Package management for macOS (https://brew.sh/)</dd>

	<dt>Mackup</dt>
	<dd>App setting sync and backup (https://github.com/lra/mackup)</dd>

	<dt>YADM</dt>
	<dd>Dotfile management (https://thelocehiliosan.github.io/yadm/)</dd>
</dl>


XDG Base Dir Spec
------------------

initio aims to keep the home directory clean by consolidating files into `~/.config` and `~/.local`. Descriptions of where to find everything follow in the tree below:

`.config` is the new home of config dirs typically found cluttering `$HOME`
```
.config
├── git
├── gnupg
├── initio
...
├── ssh
└── zsh
```

Within `.config` is `initio`, where all ansible playbooks and support files are kept. The master playbook is `runbook.yml`. Additional requirements via ansible-galaxy are in the `requirements.yml` file, see the [`bootstrap.sh`](.local/share/initio/bootstrap.sh) file for an example.
```
├── initio
   ├── config.yml
   ├── hosts
   ├── playbooks
   │   └── laptop.yml
   ├── requirements.yml
   ├── roles
   │   ├── dotfiles
   │   ├── gnupg
   │   ├── secrets
   │   ├── xdg-base-dir-spec
   │   └── zsh
   └── runbook.yml
```

XDG calls for all non configuration files to be stored in `~/.local`. External tools like YADM are cloned into the `lib` dir and symlinked to `bin`. The included `.zshrc` adds `~/.local/bin` to the user's `PATH` envar. Application data and infrequently used support scripts are kept in the `share` dir. YADM store encrypted secrets in `files.gpg` which is cloned from a private repo during setup.

```
.local
├── bin
│   └── yadm -> ../lib/yadm/yadm
├── lib
│   ├── initio
│   │   └── initio.sh
│   └── yadm
└── share
    ├── initio
    │   └── bootstrap.sh
    └── yadm
        ├── encrypt
        ├── files.gpg -> ~/Secrets/Yadm/files.gpg
        └── repo.git
```



Included Stuff
--------------

* Ansible
* GnuPG
* Homebrew
* Mackup
* OpenSSH
* XDG Directory Spec
* YADM
* ZSH
* ZIM
* ... [more](.config/MANIFEST.md)


Manual Install
--------------

These software packages are tighly controlled by their vendors and need manual installation, and/or registering a cloud client.

- [ ] Sophos: https://home.sophos.com


References
------------------

1. XDG Specification. https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
2. Dotfiles. https://dotfiles.github.io/
3. Mac Dev Playbook. https://github.com/geerlingguy/mac-dev-playbook
4. TravisCI & Ansible. https://www.jeffgeerling.com/blog/testing-ansible-roles-travis-ci-github
5. Ansible Homebrew. https://github.com/geerlingguy/ansible-role-homebrew/blob/master/README.md
6. Terminal Colors. https://github.com/mbadolato/iTerm2-Color-Schemes