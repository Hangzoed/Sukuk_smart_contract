from brownie import Sukuk,config,accounts
import time
from web3 import Web3

from scripts.helpful_scripts import deploy_mocks

def deploy_contract():
    account = accounts[0]
    print(account)
    deploy_mocks()
    price_feed_address = MockV3Aggregator[-1].address
    suk = Sukuk.deploy(price_feed_address,{"from":account})
    
    #print(account)
    #print(suk.getAdminAddress())
    #print(suk.getIjaaraAddress())
    #suk.setIjaara(accounts[1],{"from":account})
    #print(suk.getIjaaraAddress())
    print(suk.getEntranceFee())
    

    time.sleep(2)
    return suk
    
def Ijaara_withdraw_deposit():

    suk = deploy_contract()
    owner = accounts[0]
    Ijaara = accounts[1]
    suk.purchase_suk(3,{"from":owner,"value":Web3.toWei(1,"Ether")})
    suk.setIjaara(Ijaara,{"from":owner})


    suk.withdraw({"from":Ijaara,"value":Web3.toWei(0.5,"Ether")})
    suk.deposit({"from":Ijaara,"value":Web3.toWei(2,"Ether")})
    print(suk.addressToAmountDeposited)
    suk.getBalance()
    time.sleep(5)









def main():
    deploy_contract()
    Ijaara_withdraw_deposit()