pragma solidity ^0.4.19;


import "../WIN_NFT_HORSE_AccessControl.sol";


contract WIN_NFT_HORSE_Pausable is WIN_NFT_HORSE_AccessControl {

    bool public paused = false;

    modifier whenNotPaused() {
        require(!paused);
        _;
    }

    modifier whenPaused {
        require(paused);
        _;
    }

    function pause() external onlyCLevel whenNotPaused {
        paused = true;
    }

    function unpause() public onlyCEO whenPaused {
        paused = false;
    }
}
