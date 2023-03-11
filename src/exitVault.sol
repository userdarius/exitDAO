//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DepositContract {
    mapping(address => uint256) public deposits;
    mapping(address => uint256) public tokens;

    uint256 public totalDeposits;
    uint256 public constant maxDeposits = 100000;

    event Deposit(address indexed user, uint256 amount);
    event Withdrawal(address indexed user, uint256 amount);

    function deposit() public payable {
        require(totalDeposits < maxDeposits, "Maximum deposits reached");
        require(msg.value > 0, "Deposit amount must be greater than 0");
        address user = msg.sender;
        deposits[user] += msg.value;
        tokens[user] += msg.value;
        totalDeposits += msg.value;
        emit Deposit(user, msg.value);
    }

    function withdraw(uint256 amount) public {
        require(amount > 0, "Withdrawal amount must be greater than 0");
        require(amount <= deposits[msg.sender], "Insufficient balance");
        address payable user = payable(msg.sender);
        deposits[user] -= amount;
        tokens[user] -= amount;
        totalDeposits -= amount;
        emit Withdrawal(user, amount);
        (bool success, ) = user.call{value: amount}("");
        require(success, "Transfer failed");
    }

    function getTokenBalance() public view returns (uint256) {
        return tokens[msg.sender];
    }

    function burnTokens(uint256 amount) public {
        require(amount > 0, "Amount to burn must be greater than 0");
        require(amount <= tokens[msg.sender], "Insufficient token balance");
        tokens[msg.sender] -= amount;
    }
}
