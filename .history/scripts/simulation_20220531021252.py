from brownie import Sukuk,config,accounts
import time
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




def intialize_sukuk():
    pass



def main():
        intialize_sukuk()