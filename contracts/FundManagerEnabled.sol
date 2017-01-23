pragma solidity ^0.4.7;
import 'DougEnabled.sol';
import 'ContractProvider.sol';

// @title Base class for contracts that only allow the fundmanager to call them.

contract FundManagerEnabled is DougEnabled {

    // @dev check that fundmanager is the caller
    function isFoundManager() constants returns (bool) {
        if(DOUG != 0x0) {
            address fm = ContractProvider(DOUG).contracts("fundmanager");
            return msg.sender == fm;
        }
        return false;
    }

}