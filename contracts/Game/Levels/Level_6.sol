pragma solidity 0.6.2;

import "@openzeppelin/contracts/math/SafeMath.sol";

contract RollTheDice {

  using SafeMath for uint256;

  address owner;
  mapping (address => uint256) public victories;

  constructor () public {
      owner = msg.sender;
  }

  function roll (uint8 _n) public {
    uint256 randomFace = (now % 6).add(1);
    if(_n == randomFace) {
      victories[msg.sender] = victories[msg.sender].add(1);
    }
  }

  function roll (uint256 _randomFace, uint8 _n) private {
    if(_n == _randomFace) {
     victories[msg.sender] = victories[msg.sender].add(1);
    }
  }

  function help (uint8 _n) public payable {
      uint256 randomFace = msg.value.div(1 ether);
      roll (randomFace, _n);
  }

  function done (address _player) public view returns (bool) {
      return (victories[_player] >= 3);
  }

}
