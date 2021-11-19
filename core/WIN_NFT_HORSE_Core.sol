pragma solidity ^0.4.19;


import "./erc721/WIN_NFT_HORSE_ERC721.sol";


// solium-disable-next-line no-empty-blocks
contract WIN_NFT_HORSE_Core is WIN_NFT_HORSE_ERC721 {
    struct Horse {
        uint256 genes;
        uint256 bornAt;
    }

    Horse[] horses;

    event HorseSpawned(uint256 indexed _horseId, address indexed _owner, uint256 _genes);
    event HorseRebirthed(uint256 indexed _horseId, uint256 _genes);
    event HorseRetired(uint256 indexed _horseId);
    event HorseEvolved(uint256 indexed _horseId, uint256 _oldGenes, uint256 _newGenes);

    function WIN_NFT_HORSE_Core() public {

    }

    function getHorse(
        uint256 _horseId
    )
    external
    view
    mustBeValidToken(_horseId)
    returns (uint256 /* _genes */, uint256 /* _bornAt */)
    {
        Horse storage _horse = horses[_horseId];
        return (_horse.genes, _horse.bornAt);
    }

    function spawnHorse(uint256 _genes, address _owner) external
    onlySpawner
    whenSpawningAllowed(_genes, _owner)
    returns (uint256)
    {
        return _spawnHorse(_genes, _owner);
    }

    function rebirthHorse(
        uint256 _horseId,
        uint256 _genes
    )
    external
    onlySpawner
    mustBeValidToken(_horseId)
    whenRebirthAllowed(_horseId, _genes)
    {
        Horse storage _horse = horses[_horseId];
        _horse.genes = _genes;
        _horse.bornAt = now;
        HorseRebirthed(_horseId, _genes);
    }

    function retireHorse(
        uint256 _horseId,
        bool _rip
    )
    external
    onlyByeSayer
    whenRetirementAllowed(_horseId, _rip)
    {
        _burn(_horseId);

        if (_rip) {
            delete horses[_horseId];
        }

        HorseRetired(_horseId);
    }

    function evolveHorse(
        uint256 _horseId,
        uint256 _newGenes
    )
    external
    onlyGeneScientist
    mustBeValidToken(_horseId)
    whenEvolvementAllowed(_horseId, _newGenes)
    {
        uint256 _oldGenes = horses[_horseId].genes;
        horses[_horseId].genes = _newGenes;
        HorseEvolved(_horseId, _oldGenes, _newGenes);
    }

    function _spawnHorse(uint256 _genes, address _owner) private returns (uint256 _horseId) {
        Horse memory _horse = Horse(_genes, now);
        _horseId = horses.push(_horse) - 1;
        _mint(_owner, _horseId);
        emit HorseSpawned(_horseId, _owner, _genes);
    }
}