pragma solidity ^0.4.18;

import './ORPCoin.sol';
import '../installed_contracts/ERC23/contracts/Utils.sol';
import '../installed_contracts/ERC23/installed_contracts/zeppelin-solidity/contracts/ownership/Ownable.sol';
import '../installed_contracts/ERC23/installed_contracts/zeppelin-solidity/contracts/math/SafeMath.sol';

contract Arisan is Ownable, Utils {
    mapping(address => mapping(address => uint256)) arisans;

    function Arisan() {

    }
}