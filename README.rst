
oh-my-zsh and holman/dotfiles combo
===================================

Trying to combine the best features from these two repositories.

To download
-----------

  $ curl -L https://github.com/ukrutt/oh-my-dotfiles-test/raw/master/scripts/download.sh | sh

To remove
---------

  $ sh .oh-my-dotfiles/scripts/omd-remove.sh

Tips & Tricks
-------------

Use zsh for your shell
~~~~~~~~~~~~~~~~~~~~~~

Check that :code:`/usr/bin/zsh` is the location of your zsh::

  $ which zsh

Then change it::

  $ chsh -s /usr/bin/zsh


Git Push Access
~~~~~~~~~~~~~~~

If you want to push to the main repo, you need Git access, not just
HTTP.  If your remote looks like this::

    [@ubuntu:~/.oh-my-dotfiles]$ git remote -v
    origin	https://github.com/ukrutt/oh-my-dotfiles-test.git (fetch)
    origin	https://github.com/ukrutt/oh-my-dotfiles-test.git (push)

Then do::

    $ git remote set-url --push origin git@github.com:ukrutt/oh-my-dotfiles-test.git

Check the result::

    [@ubuntu:~/.oh-my-dotfiles]$ git remote -v
    origin	https://github.com/ukrutt/oh-my-dotfiles-test.git (fetch)
    origin	git@github.com:ukrutt/oh-my-dotfiles-test.git (push)


Old approach for Git push access
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Less useful since it `blocks fetch access` if you don't have the correct keys

::

    $ git remote set-url origin git@github.com:ukrutt/oh-my-dotfiles-test.git

Check the result::

    [@ubuntu:~/.oh-my-dotfiles]$ git remote -v
    origin	git@github.com:ukrutt/oh-my-dotfiles-test.git (fetch)
    origin	git@github.com:ukrutt/oh-my-dotfiles-test.git (push)

Revert
++++++

This requires you to have the correct keys; if not you won't even be
able to download.  If that's the case you can revert::

    $ git remote set-url origin https://github.com/ukrutt/oh-my-dotfiles-test.git

Main computer
~~~~~~~~~~~~~

If this is your main computer or -user, then copy one or both of the
following files to your $HOME folder::

    $ cp ~/.oh-my-dotfiles/templates/.zsh-main-host ~/
    $ cp ~/.oh-my-dotfiles/templates/.zsh-main-user ~/

This will cause the user and computer name NOT to be printed in the prompt.


Cygwin
------

 - Install Cygwin
 - Install git, zsh, curl, vim
 - Maybe   chsh, screen
