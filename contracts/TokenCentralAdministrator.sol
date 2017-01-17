pragma solidity ^0.4.7;

/// @title Administrator of Token contract
/// @author Rinaldo Rossi <rinaldo.rossi.web@gmail.com>

contract TokenCentralAdministrator {
    address public owner;
    
    function TokenCentralAdministrator() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        if (msg.sender != owner) 
            throw;
        _;
    }

    /// @dev transfer the contract's ownership
    /// @param _newOwner - new owner address
    function transferOwnership(address _newOwner) onlyOwner {
        owner = _newOwner;
    }
}