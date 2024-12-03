// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/Strings.sol";
import "@openzeppelin/contracts/access/Base64.sol"; //for ON_CHAIN imgs 

contract NFT_Human is ERC721, ERC721Enumerable, Ownable(msg.sender) {

    using String for uint256;

    error NFTOffChain__ExceedsMaxSupply();
    error NFTOffChain__NotEnoughEth();
    error NFTOffChain__TxError();
    error NFTOffChain__OnlyOwnerCanDoThis();
    error NFTOffChain__OnlyTokenOwnerCanDoThis(); 


    uint256 constant MINT_COST = 0.00001 ether;
    // uint256 constant IMG = '<svg xmlns="http://www.w3.org/2000/svg" width="200" height="200"> <rect width="200" height="200" fill="white"/><circle cx="100" cy="100" r="50" fill="blue"/><text>getAge(tokenId)</text></svg>';
    address immutable i_owner;
   
    uint256 maxSupply = 100;
    string baseURI = "ipfs://QmUAvFtsqW8XsBAJvaQEbFWybYKn9irVokrBJnnYPYB165";
    address private tokenIds;

    mapping(uint256 => uint256) public tokenIdToAges;

    constructor(address initialOwner) ERC721("HumanNFT", "HNFT")
    {
        i_owner = msg.sender;
    }


    function generateCharacter(uint256 tokenId)
    public view returns(string memory)
    {
        //Encode var into bytes
        bytes memory svg = abi.encodePacked('<svg xmlns="http://www.w3.org/2000/svg" width="200" height="200"><rect width="200" height="200" fill="white"/><circle cx="100" cy="100" r="50" fill="blue"/>
        '<text>', getAge(tokenId),'</text>'
        "</svg>"); 
        return string(abi.encodePacked("data:image/svg+xml;base64,",Base64.encode(svg) ))
    }

    function getAge(uint256 tokenId) public view returns(string memory){
        uint256 age = tokenIdToAges[tokenId];
        return age.toString();
    }
    function getTokenURI(uint256 tokenId) public view returns(string memory){
        bytes memory dataURI = abi.encodePacked(
            "(",
            '"name: BNB Human character #"',
            tokenId.toString(),
            '",',
            '"description: "Collectible Characters",',
            '"image: ", generateCharacter(tokenId),
            '"',
            ")"
        )
        return string(abi.encodePacked("data:application/json;base64,", Base64.encode(dataURI)));
    }

    function mint() public {
        if(msg.sender != owner"){
            revert NFTOffChain__OnlyOwnerCanDoThis();
        }
        tokenIds++;
        uint256 newItemId = tokenIds;
        tokenIdToAges[newItemId] = 0;
        _safeMint(msg.sender, newItemId):
        _setTokenURi(newItemId, getTokenURI(newItemId));
    }
    function growUp(uint256 tokenId) public {
        if(ownerOf(tokenId) == address(0)){
           revert NFTOffChain__TokenDoNotExist(); 
        }
        if(ownerOf(tokenId) == msg.sender){
           revert NFTOffChain__OnlyTokenOwnerCanDoThis(); 
        }
        uint256 currAge = tokenIdToAges[tokenId];
        tokenIdToAges[tokenId] = currAge + 1;
        _setTokenURi(tokenId, getTokenUri(tokenId)); 
    }
    
}
