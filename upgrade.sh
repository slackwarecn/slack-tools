#!/bin/bash
# Mod by MDrights from Slackware's official script.

# Change Log
# 2017.12.05		set custom directories to be upgraded; make logs.
# 2018.03.26		add unwant-upgrade package options.

set -eu

# Upgrade these serials, but not e, xap, xfce, kde, t, etc.
##    Do not upgrade kernel,. Upgrade them manually. 

REPO_DIR=${REPO_DIR:-/home/user/slackware-repo/slackware64-current/slackware64}

cd $REPO_DIR

ret=0
for dir in a ap d f k l n x xap tcl;
do
	for PKG in $(ls ${dir}/*.txz); do
		if [[ "$PKG" = *"kernel-generic"* ]] || [[ "$PKG" = *"kernel-huge"* ]] || [[ "$PKG" = *"kernel-modules"* ]];then
			echo "WARN Do not upgrade official kernel packages ..." | tee -a /tmp/upgrade.log
			continue
		fi
		upgradepkg --install-new $PKG || (ret=1; echo "Error while processing: $PKG_" | tee -a /tmp/upgrade.log )
	done
done

if [[ $ret -ne 0 ]]; then
	echo "ERROR you have one or more packages wrong."
fi

exit $ret
