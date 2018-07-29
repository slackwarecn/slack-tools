#!/bin/bash
# Mod by MDrights from Slackware's official script.

# Change Log
# 2017.12.05		set custom directories to be upgraded; make logs.
# 2018.03.26		add unwant-upgrade package options.
# 2018.07.29		1. sync remote repo; 2. can prevent selected apps to be installed; 3. delete packages if installation succeeded.

set -eu

# Fill in the apps you do not want to install/upgrade in APP_EXC.
# Upgrade the series in the `for ... in ...` statement.


REPO_DIR=${REPO_DIR:-/home/user/slackware-repo/slackware64-current}
APP_EXC=(mozilla-thunderbird seamonkey seamonkey-solibs)

# rsync first
rsync -avz --delete linus@192.168.10.108:/mnt/usb1/slackware64-current/ ${REPO_DIR}/


cd ${REPO_DIR}/slackware64

ret=0
for dir in a ap d f k l n x xap tcl;
do
	for PKG in $(ls ${dir}/*.txz); do
		pkg=$(cut -d"-" -f1,2 <<< ${PKG##*/})
		if [[ "${APP_EXC[@]}" =~ "$pkg" ]]; then
			echo "WARN Do not upgrade package: $pkg" | tee -a /tmp/upgrade.log
			continue
		fi
		upgradepkg --install-new $PKG
		[[ $? -eq 0 ]] && rm $PKG
	done
done


APP_FAIL=$(find ${REPO_DIR}/slackware64/{a,ap,d,f,k,l,n,x,xap,tcl} -name "*.txz")

if [ ! -z "$APP_FAIL" ]; then
	echo "Finished. You may have one or more packages not installed:"
	echo $APP_FAIL
	ret=1
fi

exit $ret
