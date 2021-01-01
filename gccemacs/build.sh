# native-comp optimization
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:${PATH}"
export CFLAGS="-I/usr/local/Cellar/gcc/10.2.0/include"
export LDFLAGS="-L/usr/local/Cellar/gcc/10.2.0/lib/gcc/10 -I/usr/local/Cellar/gcc/10.2.0/include"
export LIBRARY_PATH="/usr/local/Cellar/gcc/10.2.0/lib/gcc/10:${LIBRARY_PATH:-}"

cd emacs || exit

git clean -xfd
# git reset --hard origin/feature/native-comp
# git pull

# Add patches from emacs-plus
# git am ../homebrew-emacs-plus/patches/emacs-28/fix-window-role.patch
# git am ../homebrew-emacs-plus/patches/emacs-28/no-frame-refocus-cocoa.patch
# git apply ../homebrew-emacs-plus/patches/emacs-28/system-appearance.patch

./autogen.sh

./configure \
     --disable-dependency-tracking \
     --disable-silent-rules \
     --enable-locallisppath=/usr/local/share/emacs/28.0.50/site-lisp \
     --prefix=/usr/local/opt/gccemacs \
     --without-dbus \
     --without-imagemagick \
     --with-mailutils \
     --with-ns \
     --disable-ns-self-contained \
     --with-cairo \
     --with-modules \
     --with-xml2 \
     --with-gnutls \
     --with-json \
     --with-rsvg \
     --with-nativecomp

# Ensure /usr/local/opt/gccemacs exists
rm -rf /usr/local/opt/gccemacs
mkdir /usr/local/opt/gccemacs

# Ensure the directory to which we will dump Emacs exists and has the correct
# permissions set.
libexec=/usr/local/libexec/emacs/28.0.50
if [ ! -d $libexec ]; then
  sudo mkdir -p $libexec
  sudo chown $USER $libexec
fi

make -j8 NATIVE_FAST_BOOT=1
make install

rm -rf "/Applications/Emacs.app"
mv nextstep/Emacs.app "/Applications/"

cd /usr/local/bin || exit
rm emacs
rm emacsclient
ln -s /usr/local/opt/gccemacs/bin/emacs .
ln -s /usr/local/opt/gccemacs/bin/emacsclient .


cd /Applications/Emacs.app/Contents || exit
ln -s /usr/local/opt/gccemacs/share/emacs/28.0.50/lisp .
ln -s /usr/local/native-lisp .
