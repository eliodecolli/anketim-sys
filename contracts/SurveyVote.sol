pragma solidity 0.5.0;

contract SurveyVote{
    
    address private owner;
    uint32 private alternative;
    bytes private expression;

    int256 private a_id;

    constructor(bytes memory exp, uint32 alt, int256 parent_id) public{
        owner = msg.sender;
        expression = exp;
        alternative = alt;

        a_id = parent_id;
    }

    function GetExpression() public view returns(bytes memory){
        return expression;
    }

    function GetAlternative() public view returns(uint32){
        return alternative;
    }

    function GetParentID() public view returns(int256){
        return a_id;
    }
}