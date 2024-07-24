// SPDX-License-Identifier: ISC
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import  "./OperatorRestricted.sol";

contract BEBE is ERC20Burnable, Ownable, OperatorRestricted {    
    uint8 constant DECIMALS = 6;
    uint256 constant MWEI = 10** DECIMALS;
    uint256 constant TOTAL_SUPPLY = 10_000_000_000_000 * MWEI;
    uint256 constant PRE_MINT = 500_000_000_000 * MWEI;         

    constructor() ERC20("BEBE", "BEBE") Ownable(msg.sender) {
        super._mint(msg.sender,PRE_MINT);
    }

    function decimals() public pure override returns (uint8) {
        return DECIMALS;
    }

    function operatorMint(address recipient, uint256 amount) external onlyOperators {
        mint(recipient, amount);
    }

    function mint(address recipient, uint256 amount) internal {
        require(
            this.totalSupply() + amount <= TOTAL_SUPPLY,
            "Total Supply Exceeded"
        );
        super._mint(recipient, amount);
    }    
}
