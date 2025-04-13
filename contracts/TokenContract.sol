
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

//Code reference - https://github.com/OpenZeppelin/openzeppelin-contracts/blob/1873ecb38e0833fa3552f58e639eeeb134b82135/contracts/token/ERC721/ERC721.sol

import "./ERC721.sol";

contract TokenContract is ERC721{
    
    string private _message;

    bytes32 private _test;

    constructor() ERC721("selfish-square", "SFFHFELHFA"){
        _message = "Metaverse NFT identity solutions - kthanga1"; //"Metaverse NFT identity solutions - kthanga1";
        _test= "YES";
     } 

    function message() public view   virtual returns (string memory) {
        return _message;
    }
   
    function name() public view  override  virtual returns (string memory) {
        return super.name();
    }
    function symbol() public view  override  virtual returns (string memory) {
        return super.symbol();
    }

 

}