pragma solidity ^0.4.18;

import './ORPCoin.sol';
import '../installed_contracts/ERC23/contracts/Utils.sol';
import '../installed_contracts/ERC23/installed_contracts/zeppelin-solidity/contracts/ownership/Ownable.sol';
import '../installed_contracts/ERC23/installed_contracts/zeppelin-solidity/contracts/math/SafeMath.sol';

contract Roulette is Ownable, Utils {
    //mapping(uint => mapping(address => uint)) rolls;
    
    uint public maxParticipant;
    address[] participants;
    uint totalParticipants = 0;
    uint public currentStake;
    mapping(address => uint) balanceOfWinners;

    ORPCoin token;
    bool isTokenSet;
    bool isWinnerSelected;

    function Roulette(uint _maxParticipant) {
        maxParticipant = _maxParticipant;
        totalParticipants = 0;
        currentStake = 10000;
        isTokenSet = false;
        isWinnerSelected = false;
    }

    function setToken(address _token) public onlyOwner {
        require(!isTokenSet);
        token = ORPCoin(_token);
        isTokenSet = true;
    }

    function join() public {
        if(isWinnerSelected) {
            reset();
        } else {
            if(totalParticipants < 9) {
                if(totalParticipants == participants.length) {
                participants.length += 1;
            }
                if (!token.transferFrom(msg.sender, this, currentStake)) throw;
                participants[totalParticipants] = msg.sender;
                totalParticipants++;
            }
        }
    }

    function reset() {
        totalParticipants = 0;
        isWinnerSelected = false;
    }

    function setWinner() public {
        uint selected = rand(0,10);
        address winner = participants[selected];
        balanceOfWinners[winner] = 10 * currentStake;
        isWinnerSelected = true;
    }

    function withdraw() public {
        require(balanceOfWinners[msg.sender] > 0);
        if (!token.transfer(msg.sender, balanceOfWinners[msg.sender])) throw;
    }

    function rand(uint min, uint max) private constant returns (uint256) {
        uint256 lastBlockNumber = block.number - 1;
        uint256 hashVal = uint256(block.blockhash(lastBlockNumber));
        
        // This turns the input data into a 100-sided die
        // by dividing by ceil(2 ^ 256 / 100).
        uint256 FACTOR = 1157920892373161954235709850086879078532699846656405640394575840079131296399;
        return (uint256(uint256(hashVal) / FACTOR) / 10) + 1;
    }
}