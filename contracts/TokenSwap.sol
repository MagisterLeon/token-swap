pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract TokenSwap is Ownable {

    address public tokenA;
    address public tokenB;
    uint256 public price;

    /// @param _tokenA is an address of the first token to swap
    /// @param _tokenB is an address of the second token to swap
    /// @param _price is an exchange rate for tokens (how much tokenB we will get for 1 tokenA)
    constructor(address _tokenA, address _tokenB, uint256 _price) {
        tokenA = _tokenA;
        tokenB = _tokenB;
        price = _price;
    }

    function deposit(address _address, uint256 _amount) external onlyOwner validateAddress(_address) {
        require(IERC20(_address).allowance(owner(), address(this)) >= _amount, "sender allowance for the contract is too low");
        require(IERC20(_address).transferFrom(owner(), address(this), _amount), "deposit failed");
    }

    function updatePrice(uint256 _price) external onlyOwner {
        price = _price;
    }

    modifier validateAddress(address _address) {
        require(_address == tokenA || _address == tokenB, "_address param must represent either tokenA or tokenB address from TokenSwap contract");
        _;
    }
}
