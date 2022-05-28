from brownie import Sukuk,config,accounts
import time

def deploy_contract():
    account = accounts[0]
    print(account)

    suk = Sukuk.deploy('0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419',{"from":account})
    
    print(account)
    print(suk.getAdminAddress())
    print(suk.getIjaaraAddress())
    suk.setIjaara(account,{"from":account})

    time.sleep(2)
    return suk
    







def main():
    deploy_contract()