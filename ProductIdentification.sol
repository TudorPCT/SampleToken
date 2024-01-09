// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.2;
import "SampleToken.sol";

contract ProductIdentification2 {
    struct Product {
        address producerAddress;
        string name;
        uint volume;
    } 

    address public owner;
    uint public registrationFee;
    uint private nextProductId;

    mapping (address => bool) private registeredProducers;
    mapping (uint => Product) private registeredProducts;

    SampleToken public sampleToken; // Reference to your SampleToken contract

    constructor(uint _registrationFee, address _sampleTokenAddress){
        owner = msg.sender;
        registrationFee = _registrationFee;
        nextProductId = 1;
        sampleToken = SampleToken(_sampleTokenAddress);
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "You are not the owner of this contract. Only the owner can call this function.");
        _;
    }

    modifier onlyProducer() {
        require(registeredProducers[msg.sender], "You are not registered in this contract. Please register before executing any other actions.");
        _;
    }

    function setRegistrationFee(uint fee) public onlyOwner {
        registrationFee = fee;
    }

    function registerProducer() public payable {
        require(sampleToken.transferFrom(msg.sender, address(this), registrationFee), "Token transfer failed");
        registeredProducers[msg.sender] = true;
    }

    function registerProduct(string memory _name, uint _volume) public onlyProducer {
        registeredProducts[nextProductId++] = Product(msg.sender, _name, _volume);
    }

    function isProducerRegistered(address _producerAddress) public view returns (bool) {
        return registeredProducers[_producerAddress];
    }

    function isProductRegistered(uint _productId) public view returns (bool) {
        return registeredProducts[_productId].producerAddress != address(0);
    }

    function getProduct(uint _productId) public view returns (Product memory) {
        Product memory identifiedProduct = registeredProducts[_productId];
        if (identifiedProduct.producerAddress == address(0)) {
            // Product is not registered, return empty values
            return Product(address(0), "", 0);
        }
        return identifiedProduct;
    }
}