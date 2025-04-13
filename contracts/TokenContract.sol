
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

//Code reference - https://github.com/OpenZeppelin/openzeppelin-contracts/blob/1873ecb38e0833fa3552f58e639eeeb134b82135/contracts/token/ERC721/ERC721.sol

import "./ERC721.sol";
import "./ITokenContract.sol";


contract TokenContract is ERC721, ITokenContract{
    
   

    string private _name;

    string private _symbol;

    string private _message;



    constructor(){
        _name = "selfish-square";
        _symbol = "SFFHFELHFA";
        _message = "Metaverse NFT identity solutions - kthanga1"; //"Metaverse NFT identity solutions - kthanga1";
     } 

    function message() public view  returns (string memory) {
        return _message;
    }
   
    function name() public view   returns (string memory) {
        return _name;
    }
    function symbol() public view   returns (string memory) {
        return _symbol;
    }


}