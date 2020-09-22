pragma solidity 0.6.2;

contract Welcome {

  mapping (address => uint256) private passwords;

  function setPassword () public {
    uint256 password = block.timestamp + now;
    passwords[msg.sender] = password;
  }

  function getPassword () public view returns (uint256) {
    return passwords[msg.sender];
  }

  function _welcomePlayer (uint256 _password) internal view returns (bool) {
    require (passwords[msg.sender] == _password);
    return true;
  }

}
