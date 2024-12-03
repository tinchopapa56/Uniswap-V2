//SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

// import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IFakeToken{
    function transfer(address _to, uint256 _amount) external;
    function transferFrom(address _from, address _to, uint256 _amount) external;
}

// contract Airdrop is IERC20{
contract Airdrop_Merklee {

    bytes32 merkleRoot;

    constructor(bytes32 _merkleRoot, ){
        merkleRoot = _merkleRoot;
    }

function checkWhitelist(bytes32[] calldata proof, uint64 maxAllowanceToMint)
    public view returns (bool)
{
    bytes32 leaf = keccak256(abi.encode(msg.sender, maxAllowanceToMint));
    bool verified = MerkleeProof.verify(proof, merkleRoot, leaf);
    return verified;   
}
function airdropWithTransferFrom(IFakeToken _token, address[] memory _addressArr, uint[] memory _amountArr) public
{
    for(uint8 i = 0; i < _addressArr.length; i++){
        _token.transferFrom(msg.sender, _addressArr[i], _amountArr[i]);
    }
}

}