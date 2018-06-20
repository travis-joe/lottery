pragma solidity ^0.4.0;

contract Match {

    uint8 gameType;
    uint minimum;
    string desc;
    PoolType[] totalPool;

    struct Bet {
        address player;
        uint amount;
    }

    struct PoolType {
        uint total;
        Bet[] bets;
    }

    constructor (uint8 gameType, uint minimum, string desc) public {
        gameType = gameType;
        minimum = minimum;
        desc = desc;
    }

    // 下注
    function gamble(uint action, uint amount) public {

    }

}


contract MatchFactory {

    address owner;

    address[] matches;

    constructor () public {
        owner = msg.sender;
    }

    function createMatch(uint8 gameType, uint minimum, string desc) public returns (uint) {
        address matching = new Match(gameType, minimum, desc);
        matches.push(matching);
        return matches.length - 1;
    }

    function getMatches(uint8 gameType, uint32 page, uint8 pageSize) public {

    }

    function settlement(uint key) public {

    }

}
