//SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract BEP20Custom is IERC20{
    string public name; 
    string public symbol;
    uint8 public constant DECIMALS = 18;

    mapping(address user => uint256 balance) balances;
    mapping(address user => mapping(address => uint256 balance)) allowances;

    uint256 totalSupply = 100000000 * 10**18; //100mill

    constructor(string memory _name, string memory _symbol){
        name = _name;
        symbol = _symbol;
        _mint(totalSupply);
    }

    function totalSupply() public view override returns (uint256){
        return totalSupply;
    }
    function balanceOf(address tokenOwner) public view override returns(uint256){
        return balances[tokenOwner];
    }
    function transfer(address receiver, uint256 numTokens) public override returns(bool){
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] -= numTokens;
        balances[receiver] += numTokens;
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }
    function approve(address delegate, uint256 numTokens) public override returns(bool){
        allowances[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }
    function allowance(address owner, address delegate) public view override returns(uint){
        return allowances[owner][delegate];
    }
    function allowance(address owner, address buyer, uint256 numTokens) public override returns(bool){
        require(numTokens <= balances[owner], "Not enough balance");
        require(numTokens <= allowances[owner][msg.sender], "Not enough allowance");

        balances[owner] -= numTokens;
        allowances[owner][msg.sender] -= numTokens;
        balances[buyer] += numTokens;
        emit Transfer(owner, buyer, numTokens);

        return allowances[owner][delegate];
    }
    function _mint(uint amount) internal {
        balances[msg.sender] += amount;
        totalSupply = totalSupply = amount; //weird
        emit Transfer(address(0), msg.sender, amount);

    }

}
//completar el PR