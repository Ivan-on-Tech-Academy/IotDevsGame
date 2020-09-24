pragma solidity 0.6.2;

import './Level_3.sol';

contract ThinkBigDeployer {

  function newInstance () public returns (ThinkBig) {
    ThinkBig instance = new ThinkBig();
    return instance;
  }

  function check (address _instance, address _player) public returns (bool) {
    ThinkBig instance = ThinkBig(_instance);
    return instance.completed() == true;
  }
}
