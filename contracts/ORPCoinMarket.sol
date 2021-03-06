pragma solidity ^0.4.18;

import './ORPCoin.sol';
import '../installed_contracts/ERC23/contracts/Utils.sol';
import '../installed_contracts/ERC23/installed_contracts/zeppelin-solidity/contracts/ownership/Ownable.sol';
import '../installed_contracts/ERC23/installed_contracts/zeppelin-solidity/contracts/lifecycle/Pausable.sol';
import '../installed_contracts/ERC23/installed_contracts/zeppelin-solidity/contracts/math/SafeMath.sol';

contract ORPCoinMarket is Ownable, Utils, Pausable {
    using SafeMath for uint256;

    ORPCoin public token;
    uint256 public minimumPurchase;
    uint256 public devPercentage;
    address private devWallet;
    bool public isTokenSet;
    event SomeoneBuys(uint256 _weiAmount, uint256 _devPortion, uint256 _buyerPortion, address _buyer);

    function ORPCoinMarket(uint256 _minimumPurchase, uint256 _devPercentage) {
        minimumPurchase = _minimumPurchase;
        devPercentage = _devPercentage;
        devWallet = msg.sender;
        isTokenSet = false;
    }

    function setToken(address _token) 
        public 
        validAddress(_token)
        onlyOwner
        returns (bool success)
    {
        require(!isTokenSet);
        token = ORPCoin(_token);
        isTokenSet = true;
        return true;
    }
    
    function() public payable {
        require(validPurchase());

        uint256 weiAmount = msg.value;
        uint256 devPortion = SafeMath.div(weiAmount,devPercentage);

        SomeoneBuys(weiAmount, devPortion, weiAmount - devPortion, msg.sender);
        token.mint(devWallet,devPortion);
        token.mint(msg.sender,weiAmount - devPortion);
    }

    function validPurchase() internal constant returns (bool) {
        bool nonZeroPurchase = msg.value != 0;
        bool moreThanMinimumPurchase = msg.value > minimumPurchase;

        return nonZeroPurchase && moreThanMinimumPurchase;
    }

    function withdrawToken() public {
        require(token.balanceOf(msg.sender) > 0);
        
        address beneficiary = msg.sender;
        uint256 amount = token.balanceOf(beneficiary);
        beneficiary.transfer(amount);
    }
}