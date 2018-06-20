pragma solidity ^0.4.24;

contract Match {
    uint8 results;
    uint minimum;
    string desc;
    address manager;
    uint16 commissionPercent = 1000;

    PoolType[] public allPools;

    struct Bet {
        address player;
        uint amount;
    }

    struct PoolType {
        uint total;
        Bet[] bets;
        uint odds;
    }

    constructor (uint8 gameResults, uint min, string description) public {
        results = gameResults;
        minimum = min;
        desc = description;
        manager = msg.sender;
        allPools.length = gameResults;
    }

    function takeGamble(uint8 result) public inResultAndMoreThanMin(result) payable{
        Bet memory bet = Bet({player : msg.sender, amount : msg.value});
        allPools[result].bets.push(bet);
        allPools[result].total += msg.value;
        calcOdds();
    }

    function calcOdds() private {
        for(uint8 i = 0; i < results; i++) {
            allPools[i].odds = allPools[i].total / (address(this).balance / commissionPercent);
        }
    }

    function claimMoney(uint8 result) public managerOnly{

    }

    modifier inResultAndMoreThanMin(uint8 result) {
        require(results >= result + 1);
        require(msg.value >= minimum);
        _;
    }

    modifier managerOnly() {
        require(manager == msg.sender);
        _;
    }
}
