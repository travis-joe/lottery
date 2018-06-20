pragma solidity ^0.4.24;
import "./match.sol";

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