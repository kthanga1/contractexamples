// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./IERC721.sol";

// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

//Code reference - 
//https://github.com/OpenZeppelin/openzeppelin-contracts/blob/1873ecb38e0833fa3552f58e639eeeb134b82135/contracts/token/ERC721/ERC721.sol


abstract contract ERC721 is IERC721, ERC165{

    // using string for uint256;

   

    error InvalidAddress(address receiver);

    error ErrorToken(uint256 tokenId);

    error IncorrectOwner(address sender, uint256 tokenId, address owner);
    error InsufficientTokenApproval(address operator, uint256 tokenId);

    mapping(uint256 tokenId => address) private _owners;

    mapping(address owner => uint256) private _balances;

    mapping(uint256 tokenId => address) private _tokenApprovals;

    mapping(address owner => mapping(address operator => bool)) private _operatorApprovals;



    function balanceOf(address owner) public view virtual returns (uint256) {
        // if (owner == address(0)) {
        //     revert ERC721InvalidOwner(address(0));
        // }
        // return _balances[owner];
    }

 
    function ownerOf(uint256 tokenId) public view virtual returns (address) {
        return _owners[tokenId];
    }

    


     function transferFrom(address from, address to, uint256 tokenId) public virtual {
        if (to == address(0)) {
            revert InvalidAddress(address(0));
        }
        // Setting an "auth" arguments enables the `_isAuthorized` check which verifies that the token exists
        // (from != 0). Therefore, it is not needed to verify that the return value is not 0 here.
        address previousOwner = _update(to, tokenId, _msgSender());
        if (previousOwner != from) {
            revert IncorrectOwner(from, tokenId, previousOwner);
        }
    }

    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }


    function _ownerOf(uint256 tokenId) internal view virtual returns (address) {
        return _owners[tokenId];
    }

    function _update(address to, uint256 tokenId, address auth) internal virtual returns (address) {
        address from = _ownerOf(tokenId);

        // Perform (optional) operator check;
        if (auth != address(0)) {
            _checkAuthorized(from, auth, tokenId);
        }

        // Execute the update
        if (from != address(0)) {
            // Clear approval. No need to re-authorize or emit the Approval event
            _approve(address(0), tokenId, address(0), false);

            unchecked {
                _balances[from] -= 1;
            }
        }

        if (to != address(0)) {
            unchecked {
                _balances[to] += 1;
            }
        }

        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);

        return from;
    }
  
    function safeTransferFrom(address from, address to, uint256 tokenId) public {
        safeTransferFrom(from, to, tokenId, "");
    }

  
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public virtual{
        transferFrom(from, to, tokenId);
        // checkOnERC721Received(_msgSender(), from, to, tokenId, data);
    }

    function _checkAuthorized(address owner, address spender, uint256 tokenId) internal view virtual {
        if (!_isAuthorized(owner, spender, tokenId)) {
            if (owner == address(0)) {
                revert ErrorToken(tokenId);
            } else {
                revert InsufficientTokenApproval(spender, tokenId);
            }
        }
    }

    function approve(address to, uint256 tokenId) public virtual {
        _approve(to, tokenId, _msgSender());
    }

   
    function getApproved(uint256 tokenId) public view virtual returns (address) {
        _requireOwned(tokenId);

        return _getApproved(tokenId);
    }

    function _approve(address to, uint256 tokenId, address auth) internal {
        _approve(to, tokenId, auth, true);
    }

   
    function _approve(address to, uint256 tokenId, address auth, bool emitEvent) internal virtual {
        // Avoid reading the owner unless necessary
        if (emitEvent || auth != address(0)) {
            address owner = _requireOwned(tokenId);

            // We do not use _isAuthorized because single-token approvals should not be able to call approve
            if (auth != address(0) && owner != auth && !isApprovedForAll(owner, auth)) {
                revert InvalidAddress(auth);
            }

            if (emitEvent) {
                emit Approval(owner, to, tokenId);
            }
        }

        _tokenApprovals[tokenId] = to;
    }

   
    function setApprovalForAll(address operator, bool approved) public virtual {
        _setApprovalForAll(_msgSender(), operator, approved);
    }

    function _setApprovalForAll(address owner, address operator, bool approved) internal virtual {
        if (operator == address(0)) {
            revert InvalidAddress(operator);
        }
        _operatorApprovals[owner][operator] = approved;
        emit ApprovalForAll(owner, operator, approved);
    }

   
    function isApprovedForAll(address owner, address operator) public view virtual returns (bool) {
        return _operatorApprovals[owner][operator];
    }

     function _isAuthorized(address owner, address spender, uint256 tokenId) internal view virtual returns (bool) {
        return
            spender != address(0) &&
            (owner == spender || isApprovedForAll(owner, spender) || _getApproved(tokenId) == spender);
    }

    function _getApproved(uint256 tokenId) internal view virtual returns (address) {
        return _tokenApprovals[tokenId];
    }

    function _requireOwned(uint256 tokenId) internal view returns (address) {
        address owner = _ownerOf(tokenId);
        if (owner == address(0)) {
            revert ErrorToken(tokenId);
        }
        return owner;
    }
    
    function tokenURI(uint256 tokenId) public view virtual returns (string memory) {
        _requireOwned(tokenId);

        string memory baseURI = "";
        return bytes(baseURI).length > 0 ? string.concat(baseURI, string(abi.encode(tokenId)) ) : "";
    }

    //  function checkOnERC721Received(
    //     address operator,
    //     address from,
    //     address to,
    //     uint256 tokenId,
    //     bytes memory data
    // ) internal {
    //     if (to.code.length > 0) {
    //         try IERC721Receiver(to).onERC721Received(operator, from, tokenId, data) returns (bytes4 retval) {
    //             if (retval != IERC721Receiver.onERC721Received.selector) {
    //                 // Token rejected
    //                 revert IERC721Errors.ERC721InvalidReceiver(to);
    //             }
    //         } catch (bytes memory reason) {
    //             if (reason.length == 0) {
    //                 // non-IERC721Receiver implementer
    //                 revert IERC721Errors.ERC721InvalidReceiver(to);
    //             } else {
    //                 assembly ("memory-safe") {
    //                     revert(add(32, reason), mload(reason))
    //                 }
    //             }
    //         }
    //     }
    // }
}