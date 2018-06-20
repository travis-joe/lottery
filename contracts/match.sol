pragma solidity ^0.4.24;

contract Match {
    uint8 results;
    uint minimum;
    string desc;
    PoolType[] poolTotal;

    struct Bet {
        address player;
        uint amount;
    }

    struct PoolType {
        uint total;
        Bet[] bets;
    }

    constructor (uint8 gameResults, uint min, string description) public {
        results = gameResults;
        minimum = min;
        desc = description;
        // poolTotal = new PoolType[](results);
    }

    function takeGamble(uint8 result, uint amount) public {
        Bet memory bet = Bet({player: msg.sender, amount: amount});
//        poolTotal[result].bets.push(bet);
//        poolTotal[result].total += amount;
    }

}


contract MatchFactory {

    address owner;

    address[] matches;

    constructor () public {
        owner = msg.sender;
    }

    function createMatch(uint8 results, uint minimum, string desc) public returns (uint) {
        address matching = new Match(results, minimum, desc);
        matches.push(matching);
        return matches.length - 1;
    }

    function getMatches(uint8 results, uint32 page, uint8 pageSize) public {

    }

    function settlement(uint key) public {

    }

}
