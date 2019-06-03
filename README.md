
**ClassicBets CBET AutoInstallation script**
------------------------------

Shell script to install a [ClassicBets](https://classicbets.net) Masternode on a Linux server (VPS) running **Ubuntu 16.04 or higher**. Use it on your own risk.


Installation of masternode on VPS
----------------------------
```
https://github.com/ClassicBets/cbet-mn.git
cd cbet-mn-install
bash cbet-mn-install.sh
```
For dependencies installation , at any time when you requested for installation confirmation ( Y/n ) press **Y + ENTER** , and where you requested for ( ENTER / ESC ) press **ENTER**.


**Desktop wallet setup**
--------------
After the MN is up and running, you need to configure the desktop wallet accordingly. Here are the steps for Desktop Wallet

1. Open the ClassicBets Desktop Wallet.
2. Go to RECEIVE and create a New Address: **MN1**
3. Send **3333 CBET** to **MN1**.
4. Wait for 10 confirmations.
5. Go to **Tools -> "Debug console - Console"**
6. Type the following command: **masternode outputs**
7. Go to ** Tools -> "Open Masternode Configuration File"
8. Add the following entry:
```
Alias Address Privkey TxHash Output_index
```
- Alias: **MN1**
- Address: **VPS_IP:PORT**
- Privkey: **Masternode Private Key**
- TxHash: **First value from Step 6**
- Output index: **Second value from Step 6**

9. Save and close the file.
10. Go to **Masternode Tab**. If you tab is not shown, please enable it from: **Settings - Options - Wallet - Show Masternodes Tab**
11. Click **Update status** to see your node. If it is not shown, close the wallet and start it again. Make sure the wallet is unlocked.
12. Open **Debug Console** and type:
```
startmasternode alias false MN1
```

**Usage:**
------------------
```
classicbets-cli getinfo
classicbets-cli mnsync status
classicbets-cli masternode status
```
