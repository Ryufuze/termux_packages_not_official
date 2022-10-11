TERMUX_PKG_HOMEPAGE=https://www.pango.org/
TERMUX_PKG_DESCRIPTION="Library for laying out and rendering text"
TERMUX_PKG_LICENSE="LGPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
_MAJOR_VERSION=1.50
TERMUX_PKG_VERSION=${_MAJOR_VERSION}.10
TERMUX_PKG_SRCURL=https://ftp.gnome.org/pub/GNOME/sources/pango/${_MAJOR_VERSION}/pango-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=7e5d2f1e40854d24a9a2c4d093bafe75dcdbeccdf1de43e4437332eabed64966
TERMUX_PKG_DEPENDS="fontconfig, fribidi, glib, harfbuzz, libcairo, libxft, zlib"
TERMUX_PKG_BREAKS="pango-dev"
TERMUX_PKG_REPLACES="pango-dev"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-Dintrospection=disabled"

termux_step_post_make_install() {
	install -Dm600 $TERMUX_PKG_BUILDER_DIR/pango-view.1 \
		$TERMUX_PREFIX/share/man/man1/pango-view.1
}
