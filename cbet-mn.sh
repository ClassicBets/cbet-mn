#!/bin/bash

# Initial setup for environment variables
CONFIG_FOLDER='/root/.classicbets/'
COIN_FOLER='/root/.classicbets'
CONFIG_FILE='classicbets.conf'
COIN_DAEMON='classicbetsd'
COIN_CLI='classicbets-cli'
COIN_PORT=7777
NODEIP=$(curl -s4 icanhazip.com)
clear

# Function : mn_install_head
function mn_install_head()
{
  echo -e "*******************************************************************************"
  echo -e " "
  echo -e "Install ClassicBets Masternode - P2P Cryptocurrency for classic betting games"
  echo -e "Follow all next steps. For dependencies , confirm installation by pressing Y"
  echo -e "and ENTER on request."
  echo -e " "
  echo -e "*******************************************************************************"
  sleep 10
}

# Function : mn_install_dependencies
function mn_install_dependencies()
{
  echo -e " "
  echo -e "A: INSTALLING IMPORTANT DEPENDENCIES"
  echo -e "===================================="
  echo -e "It my take a little time , up to 30 minutes. Please , if you are requested to"
  echo -e "confirm installation of part of dependencies with Y/n options , press Y and ENTER"
  echo -e "When you are requested to press ENTER for confirmation and ESC for cancell ,"
  echo -e "press ENTER for installation."
  sleep 5
  apt-get update
  add-apt-repository ppa:bitcoin/bitcoin
  apt-get update
  apt-get install -y wget curl ufw binutils net-tools
  apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils python3 libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-test-dev libboost-thread-dev libboost-all-dev libboost-program-options-dev
  apt-get install -y libminiupnpc-dev libzmq3-dev libprotobuf-dev protobuf-compiler unzip software-properties-common
  apt-get install -y libdb4.8-dev libdb4.8++-dev
  sleep 5
}

# Function : mn_install_daemoninstall
function mn_install_daemoninstall()
{
  echo -e " "
  echo -e "B: DOWNLOADING CLASSICBETS"
  echo -e "=========================="
  echo -e "Downloading and installing ClassicBets daemon and cli command"
  sleep 5
  ecoh -e " "
  echo -e "---[A] DOWNLOAD"
  wget https://github.com/ClassicBets/cbet-coin/releases/download/1.0.0.1/classicbets-masternode.tar.gz
  echo -e "---[B] UNTARING ARCHIVE"
  tar -xvzf classicbets-masternode.tar.gz
  echo -e "---[C] MOVING BINARIES"
  chmod +x classicbetsd classicbets-cli
  mv classicbetsd /usr/local/bin/
  mv classicbets-cli /usr/local/bin
  sleep 5
}

# Function : mn_install_daemon
function mn_install_daemon()
{
  echo -e " "
  echo -e "C: INSTALLING CLASSICBETS MASTERNODE"
  echo -e "===================================="
  echo -e "---[A] STARING DAEMON"
  $COIN_DAEMON -daemon -server -listen
  sleep 30
  echo -e "---[B] STOPPING DAEMON"
  $COIN_CLI stop
  sleep 20
  echo -e "---[C] PRIVATE KEY REQUEST"
  echo -e " "
  echo -e "Masternode Private key"
  echo -e "( In your hot wallet open Console and type masternode genkey , copy generated masternode key and past it here )"
  echo -e "Enter your masternode private key:"
  read -e COINKEY
  echo -e " "
  echo -e "---[D] GENERATING RPC CREDENTIALS"
  RPCUSER=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w10 | head -n1)
  RPCPASSWORD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w22 | head -n1)
  echo -e "---[E] COLLECTING CONFIGURATION FILE"

  cat << EOF > /root/.classicbets/classicbets.conf
rpcuser=$RPCUSER
rpcpassword=$RPCPASSWORD
rpcallowip=127.0.0.1
listen=1
server=1
daemon=1
staking=0
enablezeromint=0
addnode=68.183.64.109:7777
addnode=104.248.18.75:7777
addnode=157.230.31.231:7777
addnode=104.248.137.59:7777
addnode=134.209.226.96:7777
addnode=46.101.160.38:7777
addnode=46.101.149.216:7777
addnode=207.154.233.197:7777
port=$COIN_PORT
maxconnections=64
masternode=1
externalip=$NODEIP:$COIN_PORT
masternodeprivkey=$COINKEY
EOF
  
  echo -e "---[F] STARTING DAEMON"
  $COIN_DAEMON -daemon -server -listen
  sleep 20
  clear
  echo -e " "
  echo -e "----------------------------------------------------------------"
  echo -e "ClassicBets - P2P Cryptocurrency for classic betting games"
  echo -e "----------------------------------------------------------------"
  echo -e " "
  echo -e "Masternode has been successfylly installed";
  echo -e " "
  echo -e "PrivKey       : $COINKEY"
  echo -e "ExternalIp    : $NODEIP:$COIN_PORT"
  echo -e "RPC Username  : $RPCUSER"
  echo -e "RPC Password  : $RPCPASSWORD"
  echo -e " "
  echo -e "Check sync and status of wallet and daemon with classicbets-cli getinfo"
  echo -e "Check masternode syncing with classicbets-cli mnsync status"
  echo -e "Check masternode status with classicbets-cli masternode status"
  echo -e "Stop daemon with classicbets-cli stop"
  echo -e "Start daemon with classicbetsd -daemon -listen -server"
  echo -e " "
}

# Initializing installation script
clear
mn_install_head
mn_install_dependencies
mn_install_daemoninstall
mn_install_daemon

