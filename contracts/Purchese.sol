// SPDX-License-Identifier: MIT

pragma solidity 0.6.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";


// This one for now to track what each investor/ I will look at the implementation later


contract Sukuk{

    struct suk_investor{
        address investoraddress;
        uint256 number_of_sukuk;
        uint256 value;

    }




    mapping(address => uint256) public addressToAmountFunded;
    mapping(address => uint256) public addressToAmountDeposited;
    address payable[] public investors;
    address public  admin;
    AggregatorV3Interface public priceFeed;
    address payable public Ijaara ;
    uint public suk_price;
    suk_investor[] public suk_investors;




    //Sukuk State
    enum SUKUK_STATE{
        COOLDOWN,   //This state will be when the contract is in effect however it doesn't have any tasks to excute
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
        suk_price = 100;

    }


    function get_expetected_price(uint256 _numberOfSukuk) public returns (uint256 exptectedPrice) {
        suk_price = getEntranceFee();
    }

    function getEntranceFee() public view returns (uint256) {
        (, int256 price, , , ) = priceFeed.latestRoundData();
        uint256 adjustedPrice = uint256(price) * 10**10; // 18 decimals
        // $50, $2,000 / ETH
        // 50/2,000
        // 50 * 100000 / 2000
        uint256 costToEnter = (suk_price * 10**18) / adjustedPrice;
        return costToEnter;
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
        // Later I will need to take the number of sukuk as a factor and change how it works
        // It should take the number of sukuk and checks if the sent amount is correct or not 
        // Not lower or higher


        struct suk_investor memory new_investor = suk_investor;
        uint expectedPrice = get_expetected_price(_number_of_sukuk);
        require(
            expectedPrice == msg.value,
            "Send the correct amount of eth"
        );


        new_investor.investoraddress = msg.adress;
        new_investor.number_of_sukuk = _number_of_sukuk;
        new_investor.value = msg.value;


        suk_investors.push(new_investor);







        addressToAmountFunded[msg.sender] += msg.value;
        investors.push(payable(msg.sender));
    }




    function setIjaara(address payable  _Ijaara ) public onlyAdmin{
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

       /* for (
            uint256 funderIndex = 0;
            funderIndex < investors.length;
            funderIndex++
        ) {
            address funder = investors[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
    */
    }

    //function redeem() public payable{}

    function deposit() public payable onlyIjaara{
        addressToAmountDeposited[msg.sender] +=  msg.value;

    }
    function getBalance( ) view public returns (uint256 balance) {
        return address(this).balance;
        
    }


}