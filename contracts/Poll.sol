/*
Kur studenti te regjistrohet tek faqja e anketimeve, ai do te pajiset me nje kod i cili do e indentifikoj ate. Kodi eshte thjesht nje "celes" per te mundesuar regjistrimin.
Ai merret ne sekretarine e fakultetit dhe eshte i vlefshem vetem nje here!
 */



pragma solidity 0.5.0;
pragma experimental ABIEncoderV2;

import "./AnketimStorage.sol";

contract Poll{

    address private owner;
    AStorage    private papa;

    int256 private id;

    string private description;

    uint private startDate;
    uint private endDate;

    mapping(address => uint32) private votes_peers;   // Keep track of each address who can vote.

    mapping(address => bool) private voted_peers;   // Don't allow douple votes!

    mapping(uint32 => bool) private opts;     // Check-up dictionary for alternatives.
    mapping(uint32 => string) private opts_id;     // Each alternative.

    mapping(uint32 => uint256) private Results;    // Poll result until now.
    uint32[] private  Options;   // We gotta iterate through this unfortunately =/


    uint256 private a_len;

    uint256 private total_voted;


    constructor(string memory desc, uint32[] memory options, string[] memory opts_str, uint tot_days, int256 _id, address pAstorage) public{
        require(options.length == opts_str.length);
        
        id = _id;
        owner = msg.sender;
        papa = AStorage(pAstorage);
        description = desc;

        startDate = now;
        endDate = now + tot_days;

        for(uint256 i; i < options.length; i++){
            opts[options[i]] = true;
            opts_id[options[i]] = opts_str[i];
        }

        total_voted = 0;
    }

    function IsOptionValid(uint32 opt) private view returns(bool){
        return opts[opt];
    }

    function Vote(uint32 alt, string memory peer_id) public {
        require(msg.sender != owner, "Vetem nje student mund te votoj.");
        require(IsOptionValid(alt), "Alternativa eshte e gabuar.");
        require(papa.IsPeerAllowed(peer_id), "ID-a juaj nuk njihet ne rrjet si ID studenti.");
        require(now >= endDate, "Koha per te votuar ne kete Poll ka perfunduar.");
        
        votes_peers[msg.sender] = alt;
        voted_peers[msg.sender] = true;
        Results[alt]++;
    }

    function GetAltsIds() public view returns(uint32[] memory){
        return Options;
    }

    function GetAltById(uint32 opt_id) public view returns(string memory){
        require(opts[opt_id] == true, "Alternativa nuk eshte e sakte.");
        return opts_id[opt_id];
    }

    function GetResultForOpt(uint32 opt) public view returns(uint256){
        require(opts[opt] == true, "Alternativa nuk eshte e sakte.");
        return Results[opt];
    }
}