TERMUX_PKG_HOMEPAGE=https://www.gnupg.org/related_software/libassuan/
TERMUX_PKG_DESCRIPTION="Library implementing the Assuan IPC protocol used between most newer GnuPG components"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2.5.5
TERMUX_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=8e8c2fcc982f9ca67dcbb1d95e2dc746b1739a4668bc20b3a3c5be632edb34e4
TERMUX_PKG_DEPENDS="libgpg-error"
TERMUX_PKG_BREAKS="libassuan-dev"
TERMUX_PKG_REPLACES="libassuan-dev"