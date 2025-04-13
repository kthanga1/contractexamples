
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;


interface ITokenContract {

    function name() external view returns (string memory );

    function symbol() external view returns (string memory );
   
    function message() external view returns (string memory );

}
