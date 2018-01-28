Znode Build Instructions and Notes
=============================
 - Version 0.1.6
 - Date: 14 December 2017

Prerequisites
-------------
 - Ubuntu 16.04+
 - Libraries to build from hexxcoin source
 - Port **8168** is open

Step 1. Build
----------------------
**1.1.**  Check out from source:

    git clone https://github.com/hexxcointakeove/hexxcoin

**1.2.**  See [README.md](README.md) for instructions on building.

Step 2. (Optional - only if firewall is running). Open port 8168
----------------------
**2.1.**  Run:

    sudo ufw allow 8168
    sudo ufw default allow outgoing
    sudo ufw enable

Step 3. First run on your Local Wallet
----------------------
**3.0.**  Go to the checked out folder

    cd hexxcoin

**3.1.**  Start daemon in testnet mode:

    ./src/hexxcoind -daemon -server -testnet

**3.2.**  Generate znodeprivkey:

    ./src/hexxcoin-cli znode genkey

(Store this key)

**3.3.**  Get wallet address:

    ./src/hexxcoin-cli getaccountaddress 0

**3.4.**  Send to received address **exactly 1000 HXX** in **1 transaction**. Wait for 15 confirmations.

**3.5.**  Stop daemon:

    ./src/hexxcoin-cli stop

Step 4. In your VPS where you are hosting your Znode. Update config files
----------------------
**4.1.**  Create file **hexxcoin.conf** (in folder **~/.hexxcoin**)

    rpcuser=username
    rpcpassword=password
    rpcallowip=127.0.0.1
    debug=1
    txindex=1
    daemon=1
    server=1
    listen=1
    maxconnections=24
    znode=1
    znodeprivkey=XXXXXXXXXXXXXXXXX  ## Replace with your znode private key
    externalip=XXX.XXX.XXX.XXX:8168 ## Replace with your node external IP

**4.2.**  Create file **znode.conf** (in 2 folders **~/.hexxcoin** and **~/.hexxcoin/testnet3**) contains the following info:
 - LABEL: A one word name you make up to call your node (ex. ZN1)
 - IP:PORT: Your znode VPS's IP, and the port is always 18168.
 - ZNODEPRIVKEY: This is the result of your "znode genkey" from earlier.
 - TRANSACTION HASH: The collateral tx. hash from the 1000 HXX deposit.
 - INDEX: The Index is always 0 or 1.

To get TRANSACTION HASH, run:

    ./src/hexxcoin-cli znode outputs

The output will look like:

    { "d6fd38868bb8f9958e34d5155437d009b72dfd33fc28874c87fd42e51c0f74fdb" : "0", }

Sample of znode.conf:

    ZN1 51.52.53.54:18168 XrxSr3fXpX3dZcU7CoiFuFWqeHYw83r28btCFfIHqf6zkMp1PZ4 d6fd38868bb8f9958e34d5155437d009b72dfd33fc28874c87fd42e51c0f74fdb 0

Step 5. Run a znode
----------------------
**5.1.**  Start znode:

    ./src/hexxcoin-cli znode start-alias <LABEL>

For example:

    ./src/hexxcoin-cli znode start-alias ZN1

**5.2.**  To check node status:

    ./src/hexxcoin-cli znode debug

If not successfully started, just repeat start command
