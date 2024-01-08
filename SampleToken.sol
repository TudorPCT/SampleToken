// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SampleToken {
    
    // variable members
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    mapping (address => uint256) _balances;
    // owner => (spender => no of tokens)
    mapping (address => mapping(address => uint256)) _allowances;

    // Methods
    constructor (
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _initialSupply) {

        require(_initialSupply >= 0, "Total supply must be positive");
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _initialSupply;
        
        _balances[msg.sender] = _initialSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        require(_owner != address(0), "Address cannot be 0");
        return _balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_balances[msg.sender] >= _value, "Not enough balance");
        require(_balances[msg.sender] > 0, "Your balance for this token is 0");

        _balances[msg.sender] -= _value;
        _balances[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= _balances[_from], "Not enough balance");
        require(_value <= _allowances[_from][msg.sender], "Balance higher than allowed");

        _balances[_from] -= _value;
        _balances[_to] += _value;
        _allowances[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        require(_value >= 0, "Allowances must be positive");
        require(_spender != address(0), "Address cannot be 0");
        
        _allowances[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return _allowances[_owner][_spender];
    }

    // Events
    event Transfer(address indexed _from,
                   address indexed _to,
                   uint256 _value);

    event Approval(address indexed _owner,
                   address indexed _spender,
                   uint256 _value);
}

contract SampleTokenSale {
    
    SampleToken public tokenContract;
    uint256 public tokenPrice;
    address owner;
    uint256 public tokensSold;

    event Sell(address indexed _buyer, uint256 indexed _amount);

    constructor(SampleToken _tokenContract, uint256 _tokenPrice) {
        owner = msg.sender;
        tokenContract = _tokenContract;
        tokenPrice = _tokenPrice;
    }

    function changePrice(uint256 _newPrice) public onlyOwner {
        tokenPrice = _newPrice;
    }

    function buyTokens(uint256 _numberOfTokens) public payable {
        require(msg.value >= _numberOfTokens * tokenPrice, "Not enough ether");
        uint256 change = msg.value - _numberOfTokens * tokenPrice;

        require(tokenContract.balanceOf(address(this)) >= _numberOfTokens, "Not enough tokens. Recharge contract with tokens first");
        require(tokenContract.transfer(msg.sender, _numberOfTokens));
        tokensSold += _numberOfTokens;
        payable(msg.sender).transfer(change);
        emit Sell(msg.sender, _numberOfTokens);
    }

    function endSale() public onlyOwner {
        require(tokenContract.transfer(owner, tokenContract.balanceOf(address(this))));
        payable(msg.sender).transfer(address(this).balance);
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "You are not the onwer of this contract. Only the owner can call this function.");
        _;
    }
}
