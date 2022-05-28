from brownie import Sukuk,config,accounts,exceptions
from scripts.deploy import deploy_contract

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

def test_contract_state_saftey():
    suk = deploy_contract()
    time.sleep(5)
    account = accounts[0]
    with pytest.raises(exceptions.VirtualMachineError):
        suk.startSukuk({"from":account})