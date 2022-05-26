// SPDX-License-Identifier: MIT

pragma solidity 0.6.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";


// This one for now to track what each investor/ I will look at the implementation later


contract Sukuk{
    mapping(address => uint256) public addressToAmountFunded;
    address payable[] public investors;
    address public  admin;
    AggregatorV3Interface public priceFeed;

    //Sukuk State
    enum SUKUK_STATE{
        OPEN,
        ISSUE,
        CLOSE,
        COOLDOWN, // This state will be when the contract is in effect however it doesn't have any tasks to excute
        REDEEM_PERIOD,
        TERM_1,
        TERM_2
    }
    SUKUK_STATE public sukuk_state;




    //added an argument to constructor for testing
    constructor(
        address _priceFeed
      ) 
    public {
        priceFeed = AggregatorV3Interface(_priceFeed);
        // Admin will be the contract sender for now
        admin = msg.sender;

    }




    function     startSukuk( ) onlyAdmin{
        require(
            sukuk_state = SUKUK_STATE.CLOSE,
            "Can't start a new Sukuk already"
        );

        sukuk_state = SUKUK_STATE.OPEN;

    }
    




    function  IssueSukuk( ) onlyAdmin{
        require(
            sukuk_state = SUKUK_STATE.OPEN,
            "Can't issue new suks yet"
        );

        sukuk_state = SUKUK_STATE.ISSUE;

    }

    function EndIssue() onlyAdmin{
        require(
            sukuk_state = SUKUK_STATE.ISSUE
        );

        sukuk_state = SUKUK_STATE.COOLDOWN;
    }

    function startRedeem() onlyAdmin{
        require(
            sukuk_state = SUKUK_STATE.COOLDOWN
        );

        sukuk_state = SUKUK_STATE.REDEEM_PERIOD;
    }





    function 

    function purchase_suk(uint256 _number_of_sukuk) public payable{



        // Right now it only tracks the amount and address only.
        addressToAmountFunded[msg.sender] += msg.value;
        investors.push(payable(msg.sender));
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

    }

    //function redeem() public payable{}


}