TERMUX_PKG_HOMEPAGE=https://electrum.org
TERMUX_PKG_DESCRIPTION="Electrum is a lightweight Bitcoin wallet"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=4.3.1
TERMUX_PKG_SRCURL=https://download.electrum.org/$TERMUX_PKG_VERSION/Electrum-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=a4086c1ca20c081dcebad253ae018d4fd3ca7d3717720c548ffc75eae04ad88b
TERMUX_PKG_DEPENDS="python, libsecp256k1"
_PKG_PYTHON_DEPENDS="'qrcode' 'protobuf<4,>=3.12' 'qdarkstyle>=2.7' 'aiorpcx<0.23,>=0.22.0' 'aiohttp<4.0.0,>=3.3.0' 'aiohttp_socks>=0.3' 'certifi' 'bitstring' 'attrs>=19.2.0' 'dnspython>=2.0'"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_PLATFORM_INDEPENDENT=true
# asciinema previously contained some files that python packages have in common
TERMUX_PKG_CONFLICTS="asciinema (<< 1.4.0-1)"

_PYTHON_VERSION=$(. $TERMUX_SCRIPTDIR/packages/python/build.sh; echo $_MAJOR_VERSION)

TERMUX_PKG_RM_AFTER_INSTALL="
lib/python${_PYTHON_VERSION}/site-packages/__pycache__
lib/python${_PYTHON_VERSION}/site-packages/easy-install.pth
lib/python${_PYTHON_VERSION}/site-packages/site.py
"

termux_step_pre_configure() {
	termux_setup_python_crossenv
	pushd $TERMUX_PYTHON_CROSSENV_SRCDIR
	_CROSSENV_PREFIX=$TERMUX_PKG_BUILDDIR/python-crossenv-prefix
	python${_PYTHON_VERSION} -m crossenv \
		$TERMUX_PREFIX/bin/python${_PYTHON_VERSION} \
		${_CROSSENV_PREFIX}
	popd
	. ${_CROSSENV_PREFIX}/bin/activate
}

termux_step_make_install() {
	export PYTHONPATH=$TERMUX_PREFIX/lib/python${_PYTHON_VERSION}/site-packages
	PYTHONDONTWRITEBYTECODE=1 pip install --no-deps . --prefix $TERMUX_PREFIX
}

termux_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$TERMUX_PREFIX/bin/sh
	echo "Installing dependencies through pip..."
	pip3 install ${_PKG_PYTHON_DEPENDS}
	EOF
}
