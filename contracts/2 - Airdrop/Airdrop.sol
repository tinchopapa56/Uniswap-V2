//SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

// import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IFakeToken{
    function transfer(address _to, uint256 _amount) external;
    function transferFrom(address _from, address _to, uint256 _amount) external;
}

contract AirdropToken {

function airdropWithTransfer(
    IFakeToken _token, 
    address[] memory _addressArr, 
    uint[] memory _amountArr
) 
public
{
    for(uint8 i = 0; i < _addressArr.length; i++){
        _token.transfer(_addressArr[i], _amountArr[i]);
    }
}
function airdropWithTransferFrom(IFakeToken _token, address[] memory _addressArr, uint[] memory _amountArr) public
{
    for(uint8 i = 0; i < _addressArr.length; i++){
        _token.transferFrom(msg.sender, _addressArr[i], _amountArr[i]);
    }
}

}


//Airdrop Contract & Interface implementation

//Retrieving events
/*
JS
const contract = new web3.eth.Contract(abi, contractAddress);

try {
    const pastMintEvents = contract.getPastEvents("Minted Soldier", {
        filter: {sender: userAddress, amount: 100}, //100eth
        fromBlock: 0,
        toBlock: "latest" 
    })
    return pastMintEvents;
} catch(err) {
    console.error(err)
}
/////////////////
//subscribe to a event
    contract.events.MintedSoldier()
    .on("data", (event) => {
        console.log("viendo", event)
    })
    .on("error", (err) => {
        console.error("viendo", err)
    })


*/