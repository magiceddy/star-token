pragma solidity ^0.4.7;

// @title Base class for contracts that are used is a doug system
// @author Rinaldo Rossi <rinaldo.rossi.web@gmail.com>

contract DougEnabled {
    address DOUG;

    function DoungEnabled() {}

    function setDougAddress(address dougAddr) returns (bool result) {
        if (DOUG != 0x0 && msg.sender != DOUG) {
            return false;
        }
        DOUG = dougAddr;
        return true;
    }

    function remove() {
        if (msg.sender == DOUG) {
            selfdestruct(DOUG);
        }
    }
}