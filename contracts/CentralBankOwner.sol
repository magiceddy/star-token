pragma solidity ^0.4.7;

/// @title Store data of CentralBank Owner
/// @author Rinaldo Rossi <rinaldo.rossi.web@gmail.com>

contract CentralBankOwner {
    
    address public owner;
    
    /// @dev Contract constructor
    function CentralBankOwner() {
        owner = msg.sender;        
    }
    
    /* throw an error if sender is not the owner of the Contract*/
    modifier onlyOwner() {
        if(msg.sender != owner)
            throw;
        _;
    }

}