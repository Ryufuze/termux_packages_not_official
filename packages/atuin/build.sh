TERMUX_PKG_HOMEPAGE=https://github.com/ellie/atuin
TERMUX_PKG_DESCRIPTION="Magical shell history"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="11.0.0"
TERMUX_PKG_SRCURL=https://github.com/ellie/atuin/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=29689906e3fd6bc680c60c3b2f41f756da5bd677a4f4aea3d26eff87f5bebac4
TERMUX_PKG_DEPENDS="libc++"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_HOSTBUILD=true

termux_step_pre_configure() {
	# required to build for x86_64, see #8029
	export RUSTFLAGS="${RUSTFLAGS:-} -C link-args=$($CC -print-libgcc-file-name)"
}

termux_step_handle_hostbuild() {
	export CC=""
	export CFLAGS=""
	export CPPFLAGS=""
	termux_setup_rust

	mkdir -p $TERMUX_PKG_HOSTBUILD_DIR
	cargo build \
		--jobs $TERMUX_MAKE_PROCESSES \
		--locked \
		--target-dir $TERMUX_PKG_HOSTBUILD_DIR
}

termux_step_post_make_install() {
	# Generate and install shell completions
	mkdir completions/
	for sh in 'bash' 'fish' 'zsh'; do
		$TERMUX_PKG_HOSTBUILD_DIR/debug/atuin gen-completions -s $sh -o completions/
	done

	install -Dm600 completions/atuin.bash $TERMUX_PREFIX/share/bash-completion/completions/atuin.bash
	install -Dm600 completions/_atuin $TERMUX_PREFIX/share/zsh/site-functions/_atuin
	install -Dm600 completions/atuin.fish $TERMUX_PREFIX/share/fish/vendor_completions.d/atuin.fish
}
