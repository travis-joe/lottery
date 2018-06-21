pragma solidity ^0.4.24;
import "./match.sol";

contract MatchFactory {
    address owner;
    address[] matches;

    constructor () public {
        owner = msg.sender;
    }

    function createMatch(uint8 matchResults, uint minimum, string desc) public returns (uint) {
        address matching = new Match(matchResults, minimum, desc);
        matches.push(matching);
        return matches.length - 1;
    }

    function getMatches(uint32 page, uint8 pageSize) view public returns (address[]){
        address[] memory result = new address[](page);
        for (uint i = pageSize * page - pageSize; i < pageSize * page; i++) {
            result[i] = matches[i];
        }
        return result;
    }
}