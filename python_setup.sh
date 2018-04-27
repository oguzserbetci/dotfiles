pipsi install pipenv

pyenv install 2.7.14
pyenv install 3.6.5

pyenv virtualenv 2.7.14 neovim2
pyenv virtualenv 3.6.5 neovim3

pyenv activate neovim2
pip install neovim
pyenv which python  # Note the path

pyenv activate neovim3
pip install neovim
pyenv which python  # Note the path

# The following is optional, and the neovim3 env is still active
# This allows flake8 to be available to linter plugins regardless
# of what env is currently active.  Repeat this pattern for other
# packages that provide cli programs that are used in Neovim.
pip install flake8
ln -s `pyenv which flake8` ~/bin/flake8  # Assumes that $HOME/bin is in $PATH

pyenv virtualenv 3.6.5 jupyter3
pyenv virtualenv 3.6.5 tools3
pyenv virtualenv 2.7.14 ipython2
pyenv virtualenv 2.7.14 tools2

#jupyter labextension install jupyterlab-toc

