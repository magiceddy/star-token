pragma solidity ^0.4.7;

/// @title Collect of all products by Company
/// @author Rinaldo Rossi <rinaldo.rossi.web@gmail.com>

contract Products {
    
    address owner;
    
    /* emit when company add a product */
    event productAdded(
        address indexed company,
        string name
    );

    /* emit when company update a product */
    event productUpdated(
        address indexed company,
        uint indexed code,
        string indexed name
    );
    
    struct Product {
        string name;
        uint votes;
        bool created;
    }
    
    /* Company => (productId Product) */
    mapping (address => mapping(uint => Product)) listOfProductsByCompany;

    /// @dev check if product whas already registered for a specific company
    /// @param _code - product code
    modifier productAlreadyCreated(uint _code) {
        if(listOfProductsByCompany[msg.sender][_code].created) 
            throw;
        _;
    }
    
    /// @dev check if product is not created
    /// @param _code product code
    modifier productNotCreated(uint _code) {
        if(!listOfProductsByCompany[msg.sender][_code].created) 
            throw;
        _;
    }
    
    /// check if product code is valide
    /// @param _code - product code
    modifier valideCode(uint _code) {
        if(_code <= 0) throw;
        _;
    }
    

    /// @dev constructor
    function Products () {
        owner = msg.sender;
    }

    /* @dev add product for specific company
     * @param _code - product code
     * @param _name - product name 
     */
    function addProduct(uint _code, string _name) 
        valideCode(_code) 
        productAlreadyCreated(_code) 
    {
        listOfProductsByCompany[msg.sender][_code] = Product(
            {
                name: _name, 
                votes: 0, 
                created: true
            }
        );
        productAdded(msg.sender, _name);
    }
    
    /* @dev seach producy by code
     * @param _code - product code
     * @return product name
     * @return number of votes
    */
    function getProductByCode(uint _code) 
        valideCode(_code)
        productNotCreated(_code)
        constant 
        returns (string _name, uint _votes) 
    {
        var product = listOfProductsByCompany[msg.sender][_code];
        return( product.name, product.votes);   
        
    }
    
    //verificare se devo verificare l'address della company
    /* @dev update name of specific product
     * @param _code - product code
     * @param _name - product name
    */
    function updateProduct(uint _code, string _name) 
        valideCode(_code)
        productNotCreated(_code)
    {
            var product = listOfProductsByCompany[msg.sender][_code];
            product.name = _name;
            productUpdated(msg.sender, _code, _name);
    }

    function () {
        //if ether is sent to this address, send it back.
        throw;
    }

}