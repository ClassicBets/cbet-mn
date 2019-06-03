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
  wget https://github.com/ClassicBets/cbet-coin/releases/download/1.0.0/classicbets-masternode.tar.gz
  echo -e "---[B] UNTARING ARCHIVE"
  tar -xvzf classicbets-masternode.tar.gz
  echo -e "---[C] MOVING BINARIES"
  chmod +x classicbetsd classicbets-cli
  mv classicbetsd /usr/local/bin/
  mv classicbets-cli /usr/local/bin
  sleep 5
}


