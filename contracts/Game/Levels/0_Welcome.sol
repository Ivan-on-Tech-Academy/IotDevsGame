pragma solidity 0.6.2;

contract Welcome {

  address public owner;
  mapping (address => uint256) private passwords;

  constructor () public {
    owner = msg.sender;
  }

  function setPassword () public {
    uint256 password = block.timestamp + now;
    passwords[msg.sender] = password;
  }

  function getPassword () public view returns (uint256) {
    return passwords[msg.sender];
  }

  function setOwnership (uint256 _password) public {
    require (passwords[msg.sender] == _password);
    owner = msg.sender;
  }

}
