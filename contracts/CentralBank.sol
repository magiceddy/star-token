pragma solidity ^0.4.7;
import "CentralBankOwner.sol";

/// @title Central Eth storage for Company
/// @author Rinaldo Rossi <rinaldo.rossi.web@gmail.com>

contract CentralBank is CentralBankOwner {
    
    /* emit company registration */
    event companyRegistered(address company);

    /* emit company charge account */
    event companyAccountRegistered(
        address indexed company,
        uint value
    );

    /* emit registration of customer */
    event customerRegistered(
        address indexed company,
        address customer
    );

    /* emit when a customer withdrawed for initial gas */
    event customerWithdrawed(
        address company,
        address customer,
        uint ammount
    );

    /* basic information of customer */
    struct Customer {
        bool registered;
        bool withdrawed;
    }
    
    /* Company amount */
    mapping (address => uint256) private balances;
    
    /* Company registered */
    mapping (address => bool) public companies;
    
    /* Company => (customerAddress customerInfo) */
    mapping (address => mapping(address => Customer)) public customers;
    
    /* ammount sent to Customer to pay gas */
    uint fillAmount = 5 * 1 finney;
    
    /// @dev Contract constructor
    function CentralBank() {}
    
    /// @dev Let Company to register himself
    function registerCompany() external {
        companies[msg.sender] = true;
        companyRegistered(msg.sender);
    }
    
    /// @dev Let Company to charge account
    function chargeCompanyAccount() external payable {
        if(msg.value <= 0) throw;
        balances[msg.sender] = msg.value;
        companyAccountRegistered(msg.sender, msg.value);
    }
    
    /// @dev return sender balance
    function getBalanceByCompany() 
    public 
    constant 
    returns (uint256 balance) 
    {
        return(balances[msg.sender]);
    }
    
    /// @dev let customer to sign his registration for specific company
    /// @param _company address of specific company
    function registerCustomer(address _company) external returns (bool _registered) {
        if (!companies[_company]) throw;
        customers[_company][msg.sender] = Customer({registered: true, withdrawed: false});
        customerRegistered(_company, msg.sender);
        return true;
    }
    
    
    /// @dev let customer to withdraw gas needed to vote
    /// @param _company address of specific company
    function withdrawGasToRate(address _company) external returns (bool withdrawed) {
        if(!customers[_company][msg.sender].registered) throw;
        customers[_company][msg.sender].withdrawed = true;
        if (!msg.sender.send(fillAmount)) {
            customers[_company][msg.sender].withdrawed = false;    
        }
        customerWithdrawed(_company, msg.sender, fillAmount);
    }
    
    
    
    
}