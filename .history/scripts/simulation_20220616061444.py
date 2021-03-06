from brownie import Sukuk,config,accounts,network
import time
from scripts.helpful_scripts import deploy_mocks, get_account
from scripts.deploy import deploy_contract
from web3 import Web3


# 1. account 0 will be the contract admin
# 2. account 1 will be the the ijaara 
# 3. account 2 to 5 will be customers who will invest from 50 dollar to 10000 per


# intialize_sukuk will 
#   1. create the contract 
#   2. make account 1 as Ijaara
# Issue_sukuk will 
#   1. admin will start the sukuk issuance 
#   2. customers will buy and send ether to the contract 
#   3. Admin will end the issuance process
# Ijaara
#   1. Admin will start the Ijaara period
#   2. Ijaara will withdraw money that he is allowed to withdraw
#   3. After a while they will deposit their amount of money 
#   4. Admin will end the Ijaara period





def simulate():
    # get users.
    admin = get_account(0)
    Ijaara = get_account(1)
    user_1 = get_account(2)
    user_2 = get_account(3)
    user_3 = get_account(4)
    user_4 = get_account(5)
    # Starting contract admin
    suk = Sukuk.deploy(config["networks"][network.show_active()]["eth_usd_price_feed"],{"from":admin})    
    suk.startSukuk({"from":admin})
    suk.IssueSukuk({"from":admin})
    suk.purchase_suk(3,{"from":user_1,"value":suk.get_expetected_price(3)})
    suk.purchase_suk(4,{"from":user_2,"value":suk.get_expetected_price(4)})
    suk.purchase_suk(5,{"from":user_3,"value":suk.get_expetected_price(5)})
    suk.purchase_suk(30,{"from":user_4,"value":suk.get_expetected_price(30)})
    suk.EndIssue({"from":admin})
    suk.setIjaara(Ijaara,{"from":admin})
    suk.withdraw({"from":Ijaara,"value":Web3.toWei(5,"Ether")})
    suk.deposit({"from":Ijaara,"value":Web3.toWei(5,"Ether")})



def main():
        simulate()
