from brownie import Sukuk,config,accounts
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

