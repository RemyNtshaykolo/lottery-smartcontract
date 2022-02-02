// SPDX-License-identifier: MIT
pragma solidity ^0.6.6; //It will any compiler up to 0.5.0
import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract Lottery {
    address payable[] players; //address payable allow to easily transfer money to the address with x.transfer()
    uint256 public usdEntryFee;
    AggregatorV3Interface internal ethUsdPriceFeed;

    constructor(address _priceFeedAddress) public {
        // The constructor is trigger only once when the contract is deployed and created into the blockchain
        // Price in Wei
        usdEntryFee = 50 * 1e18;
        ethUsdPriceFeed = AggregatorV3Interface(_priceFeedAddress);
    }

    function enter() public payable {
        // 50$ minimum
        players.push(msg.sender);
    }

    function getEntranceFee() public view returns (uint256) {
        (, int256 price, , , ) = ethUsdPriceFeed.latestRoundData(); //The price contain 8 decimals
        uint256 adjustedPrice = uint256(price) * 1e10; //Convert the price to 18 decimals
        uint256 costToEnter = (usdEntryFee * 1e18) / adjustedPrice;
        return costToEnter;
    } // It is a view it does not change the state of the blockchain

    function startLottery() public {}

    function endLottery() public {}
}
