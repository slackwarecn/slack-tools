# NOTE: This script has been moved to https://github.com/mdrights/my-little-airport/Slackware  

<hr />

## system-upgrade
A simple script to upgrade packages in Slackware.

0. 首先你需要下载好 Slackware 软件源到本地（或网络挂载盘），比如：  

  rsync.osuosl.org::slackware/slackware-current
  slackware.mirrors.tds.net::slackware/slackware-current
  rsync.slackware.pl::slackware/slackware-current
  rsync.slackware.at::slackware/slackware-current
  mirrors.vbi.vt.edu::slackware/slackware-current
  rsync.slackware.no::slackware/slackware-current

(当然也可以找第三方软件源如 Slackbuilds.org)   

1. 运行本脚本，前面加上下载好的软件源的本地路径，如：

	REPO_DIR=/home/user/slackware-repo/slackware64-current/slackware64 ./upgrade.sh

路径指定到 a/ ap/ d/ e/ 之类的目录上一层即可。   

本脚本现在默认不升级内核（kernel-huge, kernel-generic, kernel-modules）。有其他需求的话可以自行进脚本去修改。  

还可自行设定升级软件源内的哪些目录，如不升级 kde/。


2. 以后可以通过 Alien 大神的镜像同步脚本 (mirror-slackware-current.sh) 同步即可。大神的脚本仓库是：http://bear.alienbase.nl/mirrors/people/alien/tools/
