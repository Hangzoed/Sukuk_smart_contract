// SPDX-License-Identifier: MIT

pragma solidity 0.6.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";


// This one for now to track what each investor/ I will look at the implementation later


contract Sukuk{
    mapping(address => uint256) public addressToAmountFunded;
    address payable[] public investors;
    address public  admin;
    AggregatorV3Interface public priceFeed;
    address payable public Ijaara ;

    //Sukuk State
    enum SUKUK_STATE{
        COOLDOWN,// This state will be when the contract is in effect however it doesn't have any tasks to excute
        OPEN,
        ISSUE,
        CLOSEED,
        
        REDEEM_PERIOD,
        TERM_1,
        TERM_2
    }
    SUKUK_STATE public sukuk_state;


    function get() public view returns(SUKUK_STATE){
        return sukuk_state;
    }





    //added an argument to constructor for testing
    constructor(
        address _priceFeed
      ) 
    public {
        priceFeed = AggregatorV3Interface(_priceFeed);
        // Admin will be the contract sender for now
        admin = msg.sender;
        sukuk_state = SUKUK_STATE.CLOSEED;

    }




    function     startSukuk( ) public onlyAdmin{
            require(
            sukuk_state == SUKUK_STATE.CLOSEED,
            "Can't issue new suks yet"
        );





        sukuk_state = SUKUK_STATE.OPEN;

    }
    




    function  IssueSukuk( ) public onlyAdmin{
        require(
            sukuk_state == SUKUK_STATE.OPEN,
            "Can't issue new suks yet"
        );

        sukuk_state = SUKUK_STATE.ISSUE;

    }

    function EndIssue() public onlyAdmin{
        require(
            sukuk_state == SUKUK_STATE.ISSUE,
            "Test"
        );

        sukuk_state = SUKUK_STATE.COOLDOWN;
    }

    function startRedeem() public onlyAdmin{
        require(
            sukuk_state == SUKUK_STATE.COOLDOWN,
            "Test"
        );

        sukuk_state = SUKUK_STATE.REDEEM_PERIOD;
    }





    

    function purchase_suk(uint256 _number_of_sukuk) public payable{



        // Right now it only tracks the amount and address only.
        addressToAmountFunded[msg.sender] += msg.value;
        investors.push(payable(msg.sender));
    }




    function setIjaara(address payable _Ijaara ) public onlyAdmin{
        Ijaara = _Ijaara;
        
    }








    modifier onlyAdmin(){
        require(msg.sender == admin);
        _;
    }

    modifier onlyIjaara(){
        require(msg.sender == Ijaara);
        _;
    }



    function getAdminAddress( ) view public returns (address ) {

        return admin;
    }
    function getIjaaraAddress( ) view public returns (address ) {
        return Ijaara;
    }

    function withdraw() public payable onlyIjaara{
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