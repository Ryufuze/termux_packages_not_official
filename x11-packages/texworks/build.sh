TERMUX_PKG_HOMEPAGE=https://www.tug.org/texworks/
TERMUX_PKG_DESCRIPTION="TeXworks is an environment for authoring TeX (LaTeX, ConTeXt, etc) documents"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_LICENSE_FILE="COPYING"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=0.6.7
TERMUX_PKG_SRCURL=https://github.com/TeXworks/texworks/archive/refs/tags/release-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=dd55fc6aee5a4c93c4f2c304c234943428e3710aca7b180143f5be747e4f06cd
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_DEPENDS="qt5-qtscript, liblua53, poppler-qt, poppler, qt5-qtbase, qt5-qtdeclarative, zlib, qt5-qttools, hunspell, fontconfig"
TERMUX_PKG_BUILD_DEPENDS="git, qt5-qtbase-cross-tools, qt5-qtdeclarative-cross-tools, qt5-qttools-cross-tools"
TERMUX_PKG_AUTO_UPDATE=true

termux_step_pre_configure() {
        termux_setup_cmake

        TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-DLUA_MATH_LIBRARY=$TERMUX_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$TERMUX_HOST_PLATFORM/$TERMUX_PKG_API_LEVEL/libm.so"
}
