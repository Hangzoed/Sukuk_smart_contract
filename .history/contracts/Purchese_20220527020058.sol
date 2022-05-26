// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.9.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

// This one for now to track what each investor/ I will look at the implementation later

struct investor{
    address investor_address;
    uint256 suk_number;

}

contract Sukuk{
    mapping(address => uint256) public addressToAmountFunded;
    address[] public investors;
    address public admin;
    AggregatorV3Interface public priceFeed;

    //Sukuk State
    enum Sukuk_state{
        OPEN,
        CLOSE,
        REDEEM_PERIOD,
        TERM_1,
        TERM_2
    }




    //added an argument to constructor for testing
    constructor(address _priceFeed  ) public{
        priceFeed = AggregatorV3Interface(_priceFeed);
        // Admin will be the contract sender for now
        admin = msg.sender;

    }

    function purchase_suk(uint256 _number_of_sukuk) public payable{



        // Right now it only tracks the amount and address only.
        addressToAmountFunded[msg.sender] += msg.value;
        investors.push(msg.sender);
    }


    modifier onlyAdmin(){
        require(msg.sender == admin);
        _;
    }

    function withdraw() public payable onlyAdmin{
        msg.sender.transfer(address(this).balance);

        for (
            uint256 funderIndex = 0;
            funderIndex < investors.length;
            funderIndex++
        ) {
            address funder = investors[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        investors = new address[](0);
    }

    function redeem() public payable


    }


