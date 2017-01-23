pragma solidity ^0.4.7;
import 'DougEnabled.sol';
import 'ContractProvider.sol';

// @title Permission database
contract PermissionsDb is DougEnabled {

    mapping (address => uint8) public perms;

    function setPermission(address addr, uint8 perm) returns (bool res) {
        if(DOUG != 0x0) {
            address permC = ContractProvider(DOUG).contracts("perms");
            if (msg.sender == permC) {
                perms[addr] = perm;
                return true;
            }
            return false;
        } else {
            return false;
        }
    }
}