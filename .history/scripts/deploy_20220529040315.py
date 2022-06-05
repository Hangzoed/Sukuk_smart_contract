from brownie import Sukuk,config,accounts
import time
from web3 import Web3

def deploy_contract():
    account = accounts.add("0x218adcce38db7326bd54c2644ba0643d594ef069b7a5697b85aa26ee04e2094f")
    print(account)

    suk = Sukuk.deploy('0x8A753747A1Fa494EC906cE90E9f37563A8AF630e',{"from":account},publish_source = "TGZ97FPNS79CJW18UM48VJWQUUQN5SKR8G")
    
    #print(account)
    #print(suk.getAdminAddress())
    #print(suk.getIjaaraAddress())
    #suk.setIjaara(accounts[1],{"from":account})
    #print(suk.getIjaaraAddress())
    

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