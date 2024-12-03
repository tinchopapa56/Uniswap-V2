// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/Strings.sol";

//stake NFTs for tokens
contract Staking is Ownable {

    error Staking_NoNftsToStake();
    error Staking_YouMustOwnTheNft();
    error Staking_NoTokensStaked();
    error Staking_NotYourStakedToken();
    error Staking_TokenNotFound();

    IERC20 public immutable rewardsToken;
    IERC721 public immutable nftCollection;
    uint256 private rewardsPerHour = 10;
    mappint(address => Staker) public stakers;

    struct Staker {
        uint256[] stakedTokenIds;
        uint256 lastUpdatedTime;
        uint256 unclaimedRewards;
    }

    constructor(IERC721 _nftCollection, IERC20 rewardsToken) 
        Ownable(msg.sender)
    {
        nftCollection = _nftCollection; //address
        rewardsToken = _rewardsToken; //address
    }

    function stake(uint256[] calldata _tokenIds) external {
        Staker storage staker = stakers[msg.sender];
        if(_tokenIds.length <= 0){
            revert Staking_NoNftsToStake();
        }
        for(uint256 i = 0; i < _tokenIds.length; i++){
            uint256 tokenId = _tokenIds[i];
            if(nftCollection.ownerOf(tokenId) !== msg.sender){
                revert Staking_YouMustOwnTheNft();
            }
            nftCollection.transferFrom(msg.sender, address(this), tokenId)
            staker.stakedTokenIds.oush(tokenId);
        }
        updateRewarrds(msg.sender);
    }
    function withdraw(uint256[] calldata _tokenIds) external {
        Staker storage staker = stakers[msg.sender];
        if(staker.stakedTokenIds.length <= 0){
            revert Staking_NoTokensStaked();
        }
        updateRewarrds(msg.sender);

        for(uint256 i = 0; i < _tokenIds.length; i++){
            uint256 tokenId = _tokenIds[i];
            if(!isStaked(msg.sender,tokenId)){
                revert Staking_NotYourStakedToken();
            }
            uint256 index = getTokenIndex(msg.sender, tokenId);
            uint256 lastIndex = staker.stakedTokenIds.length-1;

            if(index != lastIndex){
                staker.stakedTokenIds[index] = staker.stakedTokenIds[lastIndex];
            }
            staker.stakedTokenIds.pop();
            nftCollection.transferFrom(address(this), msg.sender, tokenId);

        }
    }
    function claimRewards() external {
        Staker storage stkaer = stakers[msg.sender];
        uint256 rewards = calculateRewards(msg.sender) +  staker.unclaimedRewards;
        if (rewards == 0){
            revert Staking_NoRewardsToClaim();
        }
        staker.lastUpdatedTime = block.timestamp;
        staker.unclaimedRewards = 0;
        rewardsToken.transfer(msg.sender, rewards);
    }
    function setRewardsPerHour(uint256 _newRewardPerHour) external onlyOwner {
        rewardsPerHour = _newRewardPerHour
    }
    function isStaked(address _user, uint256 _tokenId) public view returns(bool){
        Staker storage staker = stakers[_user];
        for (uint256 i=0; i < staker.stakedTokenIds.length; i++){
            if(staker.stakedTokenIds[i] == _tokenId){
                return true;
            }
        }
        return false;
    }
    function getTokenIndex(address _user, uint256 _tokenId) public view returns(uint256){
        Staker storage staker = stakers[_user];
        for(uint256 i=0; i < staker.stakedTokenIds.length; i++){
            if(staker.stakedTokenIds[i] == _tokenId){
                return i;
            }
        }
        revert Staking_TokenNotFound();
    }
    function calculateRewards(addres _staker) internal view returns (uint256) {
        Staker storage staker = stakers[_staker];
        uint256 timePassed = block.timestamp - staker.lastUpdatedTime;
        uint256 completeReward = timePassed * rewardsPerHour * staker.stakedTokenIds.length; 
        return (completeReward) / 3600;
    }
    function updateRewarrds(address _staker) internal {
        Staker storage staker = stakers[_staker];
        uint256 rewardsEarned = calculateRewards(_staker);
        staker.unclaimedRewards += rewardsEarned;
        staker.lastUpdatedTime = block.timestamp;
    }

/*
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
    function _increaseBalance(address account, uint128 value) internal 
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

*/

}