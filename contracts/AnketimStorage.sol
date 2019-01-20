pragma solidity 0.5.0;
pragma experimental ABIEncoderV2;

contract AStorage{
    
    mapping(string => bool) private allowed_peers_id;

    function IsPeerAllowed(string memory id) public view returns(bool){
        return allowed_peers_id[id];
    }
}