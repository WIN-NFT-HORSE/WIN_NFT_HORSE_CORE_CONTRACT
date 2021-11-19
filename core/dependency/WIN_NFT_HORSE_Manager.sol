pragma solidity ^0.4.19;


interface WIN_NFT_HORSE_SpawningManager {
    function isSpawningAllowed(uint256 _genes, address _owner) external returns (bool);
    function isRebirthAllowed(uint256 _horseId, uint256 _genes) external returns (bool);
}

interface WIN_NFT_HORSE_RetirementManager {
    function isRetirementAllowed(uint256 _horseId, bool _rip) external returns (bool);
}

interface WIN_NFT_HORSE_MarketplaceManager {
    function isTransferAllowed(address _from, address _to, uint256 _horseId) external returns (bool);
}

interface WIN_NFT_HORSE_GeneManager {
    function isEvolvementAllowed(uint256 _horseId, uint256 _newGenes) external returns (bool);
}