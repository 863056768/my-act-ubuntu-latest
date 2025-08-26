FROM docker.gitea.com/runner-images:ubuntu-latest

RUN <<EOT
    set -Eeuxo pipefail
    BASE=/opt/acttoolcache/node
    NODE16=$(ls -d $BASE/16.* | sort -V | tail -n1)
    NODE18=$(ls -d $BASE/18.* | sort -V | tail -n1)
    NODE20=$(ls -d $BASE/20.* | sort -V | tail -n1)
    printf "\n\t🐋 Removing Node.JS=%s 🐋\t\n" $(basename $NODE16)
    rm -rf $NODE16
    printf "\n\t🐋 Removing Node.JS=%s 🐋\t\n" $(basename $NODE16)
    rm -rf $NODE18
    printf "\n\t🐋 Running \`sed \"%s\" /etc/environment\` 🐋\t\n" "s|$NODE18|$NODE20/bin:|mg"
    sed "s|$NODE18|$NODE20|mg" /etc/environment
    printf "\n\t🐋 Linking %s to %s 🐋\t\n" $NODE20 $NODE18
    ln -s $NODE20 $NODE18
    printf "\n\t🐋 Using Node.js=%s Now 🐋\t\n" $(basename $NODE20)
EOT