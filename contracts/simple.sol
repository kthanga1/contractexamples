
// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;


contract Simple {
    
    uint256 number;

    event Token(address caller, string  str);
    // event TokenName(address caller, bytes name);
    // event TokenSymbol(address callerr, bytes symbol);
    // event TokenMessage(address caller, bytes message);
    
    // address payable caller;

    struct  SimpleToken {
        bytes32 name;
        bytes32 symbol;
        // bytes32 message1;
        // bytes32 message2;
        bytes message;
    }

    error NotValidKey(address sender, string key); 

    mapping(string => string) contracttoken;

    SimpleToken inputcall;

    constructor(){
        contracttoken['Name']  = "selfish-square";
        contracttoken['Symbol']  = "SFFHFELHFA";
        contracttoken['Message']  = "Metaverse NFT identity solutions - kthanga1";
    }

    function retreivetoken(string calldata key) public view returns(string memory) {
        if (keccak256(bytes(key)) != keccak256(bytes("Name")) && keccak256(bytes(key)) != keccak256(bytes("Symbol")) && 
            keccak256(bytes(key)) != keccak256(bytes("Message"))) {
            revert NotValidKey(msg.sender,"Not Valid");
        }
        return  contracttoken[key];
    }

}