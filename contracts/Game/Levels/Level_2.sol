pragma solidity 0.6.2;

/**
* @dev Read the contract and unlock the next level;
*/

contract TheGreatHall {

  mapping (address => uint8) private doorLockA;
  mapping (address => uint8) private doorLockB;
  mapping (address => bool) private unlocked;
  mapping (address => uint256) private receiver;
  mapping (address => uint256) private randomN;
  mapping (address => uint256) public timer;

  event random (uint256);

  function unlockA () public {
    require (receiver[msg.sender] > 0.1 ether);
    doorLockA[msg.sender] = 50;
  }

  function unlockB (uint8 _n) public {
    require (_n < doorLockA[msg.sender]);

    if (doorLockA[msg.sender] % _n != 0) {revert();}
    doorLockB[msg.sender] = _n;
  }

  function r () public {
    uint256 randomNumber = now%255;
    randomN[msg.sender] = randomNumber;
    emit random (randomNumber);
  }

  function unlockC (uint256 _n) public {
    require (doorLockB[msg.sender] != 0);
    if(_n != randomN[msg.sender]) {r();} else {
      setTimer ();
      unlocked[msg.sender] = true;
    }
  }

  function setTimer () private {
    timer[msg.sender] = now + 5 minutes;
  }

  function reset (address _player) external {
    delete(doorLockA[_player]);
    delete(doorLockB[_player]);
    delete(unlocked[_player]);
    delete(randomN[_player]);
    delete(timer[_player]);
  }

  function getTimer (address _player) external view returns (uint) {
    return timer[_player];
  }

}
