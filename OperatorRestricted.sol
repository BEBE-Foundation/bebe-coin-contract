// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";

abstract contract OperatorRestricted  is Ownable{    


    mapping(address => bool) internal _operators;
    
    
    modifier onlyOperators() {
        require(
            owner() == _msgSender() || _operators[_msgSender()] == true,
            "CALLER_NOT_OPERATOR"
        );
        _;
    }
    
    function isOperator(address user) external view returns (bool) {
        return _operators[user];
    }

    function setOperator(address operator , bool value) external onlyOwner {
        _operators[operator] = value;
    }

}
