from brownie import Sukuk,config,accounts


def deploy_contract():
    account = accounts[0]

    suk = Sukuk.deploy('0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419',{"from":account})








def main():
    pass