// SPDX-License-Identifier: MIT


pragma solidity  ^0.8.20;



interface IERC165 {
   
    function supportsInterface(bytes4 interfaceID) external view returns (bool);
}

abstract contract ERC165 is IERC165 {
   
    function supportsInterface(bytes4 interfaceId) public view virtual returns (bool) {
        return interfaceId == type(IERC165).interfaceId;
    }
}

interface IERC721 is IERC165 {
    
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

    
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

   
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    function balanceOf(address _owner) external view returns (uint256);

    function ownerOf(uint256 _tokenId) external view returns (address);

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory data) external ;

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external ;

    function transferFrom(address _from, address _to, uint256 _tokenId) external ;

    function approve(address _approved, uint256 _tokenId) external ;

    function setApprovalForAll(address _operator, bool _approved) external;

    function getApproved(uint256 _tokenId) external view returns (address);

    function isApprovedForAll(address _owner, address _operator) external view returns (bool);
}


interface IERC721Metadata {
    function name() external view returns (string memory _name);

    function symbol() external view returns (string memory _symbol);

    function tokenURI(uint256 _tokenId) external view returns (string memory);
}