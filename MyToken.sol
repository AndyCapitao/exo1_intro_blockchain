// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "./IERC20.sol";

contract MyToken is IERC20 {

    string public tokenName;
    string public tokenSymbol;
    uint8 public tokenDecimals;

    uint256 private tokenSupply;

    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowances;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor() {
        tokenName = "MyToken";
        tokenSymbol = "MTK";
        tokenDecimals = 18;

        uint256 startSupply = 1000000 * (10 ** tokenDecimals);
        tokenSupply = startSupply;
        balances[msg.sender] = startSupply;

        emit Transfer(address(0), msg.sender, startSupply);
    }

    function totalSupply() external view override returns(uint256) {
        return tokenSupply;
    }

    function balanceOf(address account) external view override returns(uint256) {
        return balances[account];
    }

    function transfer(address to, uint256 value) external override returns(bool) {
        require(msg.sender != address(0));
        require(to != address(0));
        require(balances[msg.sender] >= value);

        balances[msg.sender] -= value;
        balances[to] += value;

        emit Transfer(msg.sender, to, value);
        return true;
    }

    function allowance(address owner, address spender)
        external
        view
        override
        returns(uint256)
    {
        return allowances[owner][spender];
    }

    function approve(address spender, uint256 amount)
        external
        override
        returns(bool)
    {
        require(spender != address(0));

        allowances[msg.sender][spender] = amount;

        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 value)
        external
        override
        returns(bool)
    {
        require(from != address(0));
        require(to != address(0));
        require(balances[from] >= value);
        require(allowances[from][msg.sender] >= value);

        balances[from] -= value;
        balances[to] += value;
        allowances[from][msg.sender] -= value;

        emit Transfer(from, to, value);
        return true;
    }
}
