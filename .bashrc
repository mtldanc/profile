# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment

# Prevent doublesourcing
if [ -z "$MYBASHRCSOURCED" ]; then
	MYBASHRCSOURCED="Y"

	pathmunge () {
		if ! echo $PATH | /bin/grep -E "(^|:)$1($|:)"; then
			if [ "$2" = "after" ] ; then
				PATH=$PATH:$1
			else
				PATH=$1:$PATH
			fi
		fi
	}

	if [ -n "$PS1" ]; then
		# Uncomment the following line if you don't like systemctl's
		#	auto-paging feature:
		# export SYSTEMD_PAGER=

		# User specific aliases and functions
		alias vi=vim
		alias lt='ls -lrt --color=auto'
		alias hg='history | grep'
		alias ht='history | tail'
	fi

	if ! shopt -q login_shell; then
		:
	fi

	if [ -n "$HOME" ]; then
		for path in "$HOME/bin" "$HOME/.local/bin"; do
			if [ -d "$path" ]; then
				pathmunge "$path"
			fi
		done
	fi

	for path in '/opt/bpis/bin'; do
		if [ -d "$path" ]; then
			pathmunge "$path"
		fi
	done

	unset path
	unset -f pathmunge
fi
# vim:ts=4:sw=4
