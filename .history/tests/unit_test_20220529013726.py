from brownie import Sukuk,config,accounts,exceptions
from scripts.deploy import deploy_contract
from web3 import Web3

import time

import pytest



def test_contract_working():
    suk = deploy_contract()
    assert suk != None

def test_contract_state():
    suk = deploy_contract()
    time.sleep(5)
    account = accounts[0]
    
    suk.startSukuk({"from":account})
    suk.IssueSukuk({"from":account})
    suk.EndIssue({"from":account})
    suk.startRedeem({"from":account})

def test_contract_state_saftey():
    suk = deploy_contract()
    time.sleep(5)
    account = accounts[1]
    with pytest.raises(exceptions.VirtualMachineError):
        suk.startSukuk({"from":account})
        suk.IssueSukuk({"from":account})    
        suk.EndIssue({"from":account})
        suk.startRedeem({"from":account})
def test_modifers():
    suk = deploy_contract()
    owner = accounts[0]
    Ijaara = accounts[1]
    
    # Admin address is correct
    assert suk.getAdminAddress() == owner
    #Ijaara address is none
    print(suk.getIjaaraAddress())
    assert suk.getIjaaraAddress() == "0x0000000000000000000000000000000000000000"
    suk.setIjaara(Ijaara,{"from":owner})
    assert suk.getIjaaraAddress() == Ijaara



def test_withdraw():
    suk = deploy_contract()
    owner = accounts[0]
    Ijaara = accounts[1]
    suk.purchase_suk(3,{"from":owner,"value":Web3.toWei(1,"Ether")})
    suk.setIjaara(Ijaara,{"from":owner})


    suk.withdraw({"from":owner,"value":Web3.toWei(0.5,"Ether")})