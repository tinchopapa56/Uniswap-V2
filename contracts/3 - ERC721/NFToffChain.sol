// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/Strings.sol";

contract NFT_Offchain is ERC721, ERC721Enumerable, Ownable(msg.sender) {

    error NFTOffChain__ExceedsMaxSupply();
    error NFTOffChain__NotEnoughEth();
    error NFTOffChain__TxError();

    using String for uint256;
    uint256 maxSupply = 10;
    uint256 constant MINT_COST = 0.00001 ether;
    sttring baseURI = "ipfs://QmUAvFtsqW8XsBAJvaQEbFWybYKn9irVokrBJnnYPYB165";

    constructor(address initialOwner)
        ERC721("IconsNFT", "MTK")
        // Ownable(initialOwner)
    {}

    function _baseUri() internal view override returns (string memory){
        return BASE_URI;
    }
    function tokenURI (uint256 tokenId) public view override returns(stirng memory){
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json")) : "";
    } 
    function safeMint(address to) public payable {
        uint256 currentSupply = totalSupply();
        if(currentSupply > maxSupply){
            revert NFTOffChain__ExceedsMaxSupply();
        }
        if(msg.value < MINT_COST){
            revert NFTOffChain__NotEnoughEth();
        }
        _safeMint(to, tokenId)
    }
    function withdraw public onlyOwner() {
        (bool success,) = payable(msg.sender).call{value: addres(this).balance}("");
        if(!success) {
            revert NFTOffChain__TxError()
        }
    }
    function _update(address to, uint256 tokenId, address auth) internal 
    override(ERC721, ERC721Enumerable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }
    function _increaseBalance(address account, uint128 value)
    internal 
    override(ERC721, ERC721Enumerable)
    {
        super._increaseBalance(account, value);
    }
    function supportsInterface(bytes32 interfaceId) public view
    override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        returns super.supportsInterface(interfaceId);
    }

}
