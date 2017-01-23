pragma solidity ^0.4.7;
import 'DougEnabled.sol';

// @title Top Level CMC
// @author Rinaldo Rossi <rinaldo.rossi.web@gmail.com>

contract Doug {

    address owner;

    // Where we keep all contracts
    mapping (bytes32 => address) public contracts;

    modifier onlyOwner {
        if (msg.sender != owner) throw;
        _;
    }

    function Doug() {
        owner = msg.sender;
    }

    // @param _name - name of contract
    // @param _addr - address of contract
    function addContract(bytes32 _name, address _addr) onlyOwner returns (bool result){
        DougEnabled de = DougEnabled(addr);
        if (!de.setDougAddress(address(this))) {
            return false;
        }
        contracts[name] = addr;
        return true;
    }

    // @param name - name of contract
    // @return success or not
    function removeContract(bytes32 name) onlyOwner returns(bool success) {
        if (contracts[name] == 0x0) {
            return false
        }
        contracts[name] = 0x0;
        return true;
    }

    // @param name - contract name
    // @return success or not
    function getContract(bytes32 name) constant return (address addr) {
        return contracts[name];
    }

    function remove() onlyOwner {
        address fm = contracts["foundmanager"];
        address perms = contracts["perms"];
        address permsdb = contracts["permsdb"];
        address bank = contracts["bank"];
        address bankdb = contracts["bankdb"];

        // remove everyting
        if(fm != 0x0){ DougEnabled(fm).remove(); }
        if(perms != 0x0){ DougEnabled(perms).remove(); }
        if(permsdb != 0x0){ DougEnabled(permsdb).remove(); }
        if(bank != 0x0){ DougEnabled(bank).remove(); }
        if(bankdb != 0x0){ DougEnabled(bankdb).remove(); }
        
        selfdestruct(owner);
    } 

}