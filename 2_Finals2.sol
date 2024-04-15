// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract SelfDestructAndSendEther {
    event Deposit(address indexed sender, uint amount);
    event Withdraw(address indexed receiver, uint amount);

    address public owner = msg.sender;

    receive() external payable { 
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner, "Not Owner!");
        emit Withdraw(msg.sender, address(this).balance);
        payable(msg.sender).transfer(address(this).balance);
    }

    function sendEtherViaTransfer(address payable _to) external payable {
        _to.transfer(100);
    }

    function sendEtherViaSend(address payable _to) external payable {
        bool sent = _to.send(100);
        require(sent, "Sending Failed.");
    }

    function sendEtherViaCall(address payable _to) external payable {
        (bool success, ) = _to.call{value: 100}("");
        require(success, "Call failed.");
    }
}
