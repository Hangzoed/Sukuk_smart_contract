from brownie import Sukuk,config,accounts
import time

def deploy_contract():
    account = accounts[0]

    suk = Sukuk.deploy('0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419',{"from":account})
    print(suk)
    #print(suk.sukuk_state)
    print(suk.get())

    #suk.startSukuk({"from":account})
    print(suk.get())
    time.sleep(2)
    return suk
    







def main():
    deploy_contract()