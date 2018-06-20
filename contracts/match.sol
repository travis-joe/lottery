pragma solidity ^0.4.24;

contract Match {
    uint8 results;
    uint8 winning;
    uint minimum;
    string desc;
    address manager;
    uint16 commissionPercent = 10;
    State state;

    enum State {uninitiated, began, finished}

    PoolType[] public allPools;

    struct Bet {
        address player;
        uint amount;
        bool isPayed;
    }

    struct PoolType {
        uint total;
        Bet[] bets;
        uint odds;
    }

    constructor (uint8 matchResults, uint min, string description) public {
        results = matchResults;
        minimum = min;
        desc = description;
        manager = msg.sender;
        allPools.length = matchResults;
        state = State.uninitiated;
    }

    function takeGamble(uint8 result) public inResultAndMoreThanMin(result) payable {
        Bet memory bet = Bet({player : msg.sender, amount : msg.value, isPayed : false});
        allPools[result].bets.push(bet);
        allPools[result].total += msg.value;
        calcOdds();
    }

    function calcOdds() private {
        for (uint8 i = 0; i < results; i++) {
            allPools[i].odds =  (address(this).balance * (100 - commissionPercent)) / allPools[i].total ;
        }
    }

    function finalize(uint8 result) managerOnly public {
        winning = result;
        state = State.finished;
    }

    function claimMoney() public {
        require(state == State.finished);
        PoolType storage winningPool = allPools[winning];
        uint prize = 0;
        for (uint i = 0; i < winningPool.bets.length; i++) {
            if (winningPool.bets[i].player == msg.sender) {
                prize += winningPool.bets[i].amount * winningPool.odds;
                winningPool.bets[i].isPayed = true;
            }
        }
        require(prize > 0);
        msg.sender.transfer(prize);
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
