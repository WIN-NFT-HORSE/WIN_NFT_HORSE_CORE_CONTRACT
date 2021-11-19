pragma solidity ^0.4.19;


import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

import "./WIN_NFT_HORSE_Manager.sol";


// solium-disable-next-line lbrace
contract WIN_NFT_HORSE_ManagerCustomizable is
WIN_NFT_HORSE_SpawningManager,
WIN_NFT_HORSE_RetirementManager,
WIN_NFT_HORSE_MarketplaceManager,
WIN_NFT_HORSE_GeneManager,
Ownable
{

    bool public allowedAll;

    function setAllowAll(bool _allowedAll) external onlyOwner {
        allowedAll = _allowedAll;
    }

    function isSpawningAllowed(uint256, address) external returns (bool) {
        return allowedAll;
    }

    function isRebirthAllowed(uint256, uint256) external returns (bool) {
        return allowedAll;
    }

    function isRetirementAllowed(uint256, bool) external returns (bool) {
        return allowedAll;
    }

    function isTransferAllowed(address, address, uint256) external returns (bool) {
        return allowedAll;
    }

    function isEvolvementAllowed(uint256, uint256) external returns (bool) {
        return allowedAll;
    }
}