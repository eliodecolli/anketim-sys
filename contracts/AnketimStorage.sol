pragma solidity 0.5.0;
pragma experimental ABIEncoderV2;

import "./Poll.sol";

contract AStorage{

    address private owner;
    
    mapping(string => bool) private allowed_peers_id;
    mapping(uint256 => address) private polls;

    uint256 private total_polls;

    event PollCreated(address addr, string title);

    constructor() public{
        owner = msg.sender;
        total_polls = 0;
    }

    function CreatePoll(string memory title, string[] memory alternatives, uint256 days_active) public returns(Poll){
        require(msg.sender == owner, "Nuk keni te drejte te krijoni nje Poll te ri.");

        Poll p = new Poll(title, alternatives, days_active, total_polls + 1, address(this));
        total_polls++;
        polls[total_polls] = address(p);
        emit PollCreated(polls[total_polls], title);
        
        return p;
    }

    function IsPeerAllowed(string memory id) public view returns(bool){
        return allowed_peers_id[id];
    }
}