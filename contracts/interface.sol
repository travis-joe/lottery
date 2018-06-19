pragma solidity ^0.4.0;

contract Match {

    uint8 mode = 1;
    uint min = 1e8;
    string desc = "";

    // options: [
    //   {
    //     total: '100wei',
    //     bets: [
    //       {
    //         player: "0x0000000000000000000",
    //         amount: '3wei',
    //       }
    //     ]
    //   },
    // ]

    struct Bet {
        address player;
        uint amount;
    }

    struct Option {
        uint total;
        Bet[] bets;
    }

    Option[] options;


    constructor (uint8 mode, uint min, string desc) public {

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

    function createMatch(uint8 mode, uint min, string desc) public returns (uint) {
        address matching = new Match(mode, min, desc);
        matches.push(matching);
        return matches.length - 1;
    }

    function getMatches(uint8 mode, uint32 page, uint8 pageSize) public {

    }

    function settlement(uint key) public {

    }

}
