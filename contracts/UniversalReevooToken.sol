pragma solidity ^0.4.7;
import "TokenCentralAdministrator.sol";

/// @title Token factory
/// @author Rinaldo Rossi <rinaldo.rossi.web@gmail.com>

contract UniversalReevooToken is TokenCentralAdministrator {

    /* Public variables of the token */
    string public standard = "Token 0.1";
    string public name ;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    uint256 public buyPrice;
    uint minBalanceForAccounts;

    /* This create an array with all balances */
    mapping (address => uint256) public balanceOf;

    /* This create an array with all balances */
    mapping (address => bool) public frozenAccount;

    /* This generates a public event on the blockchain that will notify clients */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /* This generates a public event on the blockchain that will notify frozen account */
    event FrozenFunds(address target, bool frozen);

    /* Initializes contract with initial supply tokens to the creator of the contract
     * Note: When creating the contract, send enough ether to it so that it can buy back all the tokens on the market
    */
    
    /* @dev constructor of token factory
     * @params _initialSupply - initial ammount of token
     * @param _tokenName - token's name
     * @param _decimalUnits - token's decimal
     * @param _tokenSymbol - symbol of token es. URT
    */
    function UniversalReevooToken(
        uint256 _initialSupply,
        string _tokenName,
        uint8 _decimalUnits,       /* 2 for now */
        string _tokenSymbol
    ) {
        balanceOf[msg.sender] = _initialSupply;
        if (_initialSupply == 0) _initialSupply = 1000000;
        totalSupply = _initialSupply;
        name = _tokenName;
        symbol = _tokenSymbol;
        decimals = _decimalUnits;
    }

    /* @dev send token from msg.sender to another address
     * @param _to - beneficiary's address
     * @param _value - ammount of token
    */
    function transfer(address _to, uint256 _value) {
        if (frozenAccount[msg.sender]) throw;
        if (balanceOf[msg.sender] < _value) throw;
        // avoid having a number so big that it becomes zero again (overflow)
        if (balanceOf[_to] + _value < balanceOf[_to]) throw;

        if(_to.balance < minBalanceForAccounts) {
            if (!_to.send((minBalanceForAccounts - _to.balance))) {
                //failure code
            }
        }
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        Transfer(msg.sender, _to, _value);
    }

    /* @dev let owner to refill a specific account
     * @param _target - refill account
     * @param _mintedAmmount - new token's ammount 
    */
    function mintToken(address _target, uint256 _mintedAmmount) onlyOwner {
        balanceOf[_target] += _mintedAmmount;
        totalSupply += _mintedAmmount;
        Transfer(0, owner, _mintedAmmount);
        Transfer(owner, _target, _mintedAmmount);
    }

    /* @dev lok or unlok specific account
     * @param _target addres to lok
     * @param _freez lok value
    */
    function freezeAccount(address _target, bool _freeze) onlyOwner {
        frozenAccount[_target] = _freeze;
        FrozenFunds(_target, _freeze);
    }

    /// @dev ancora non lo so
    function setPrice(uint256 _newSellPrice) onlyOwner {
        buyPrice = _newSellPrice;
    }

    /// @dev ancora non lo so
    function buy() payable returns (uint _amount) {
        _amount = msg.value / buyPrice;
        if (balanceOf[this] < _amount) throw;
        balanceOf[msg.sender] += _amount;
        balanceOf[this] -= _amount;
        Transfer(this, msg.sender, _amount);
        return _amount; 
    }

    /// @dev let set minumum ammount for gas
    /// @param _minimunBalanceInFinney - minimum balance in Finney
    function setMinBalance(uint _minimunBalanceInFinney) onlyOwner {
        minBalanceForAccounts = _minimunBalanceInFinney * 1 finney;
    }

    /* This unnamed function is called whenever someone tries to send ether to it */
    function () {
        throw;     // Prevents accidental sending of ether
    }
}