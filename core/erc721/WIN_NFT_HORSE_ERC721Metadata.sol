pragma solidity ^0.4.19;


import "../../erc/erc721/IERC721Metadata.sol";
import "./WIN_NFT_HORSE_ERC721BaseEnumerable.sol";


contract WIN_NFT_HORSE_ERC721Metadata is WIN_NFT_HORSE_ERC721BaseEnumerable, IERC721Metadata {
    string public tokenURIPrefix = "https://api.winnfthorse.io/api/erc/721/horse/";
    string public tokenURISuffix = ".json";

    function WIN_NFT_HORSE_ERC721Metadata() internal {
        supportedInterfaces[0x5b5e139f] = true; // ERC-721 Metadata
    }

    function name() external pure returns (string) {
        return "WIN_NFT_HORSE";
    }

    function symbol() external pure returns (string) {
        return "WNH";
    }

    function setTokenURIAffixes(string _prefix, string _suffix) external onlyCEO {
        tokenURIPrefix = _prefix;
        tokenURISuffix = _suffix;
    }

    function tokenURI(
        uint256 _tokenId
    )
    external
    view
    mustBeValidToken(_tokenId)
    returns (string)
    {
        bytes memory _tokenURIPrefixBytes = bytes(tokenURIPrefix);
        bytes memory _tokenURISuffixBytes = bytes(tokenURISuffix);
        uint256 _tmpTokenId = _tokenId;
        uint256 _length;

        do {
            _length++;
            _tmpTokenId /= 10;
        } while (_tmpTokenId > 0);

        bytes memory _tokenURIBytes = new bytes(_tokenURIPrefixBytes.length + _length + 5);
        uint256 _i = _tokenURIBytes.length - 6;

        _tmpTokenId = _tokenId;

        do {
            _tokenURIBytes[_i--] = byte(48 + _tmpTokenId % 10);
            _tmpTokenId /= 10;
        } while (_tmpTokenId > 0);

        for (_i = 0; _i < _tokenURIPrefixBytes.length; _i++) {
            _tokenURIBytes[_i] = _tokenURIPrefixBytes[_i];
        }

        for (_i = 0; _i < _tokenURISuffixBytes.length; _i++) {
            _tokenURIBytes[_tokenURIBytes.length + _i - 5] = _tokenURISuffixBytes[_i];
        }

        return string(_tokenURIBytes);
    }
}