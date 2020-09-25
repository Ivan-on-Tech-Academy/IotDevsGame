pragma solidity 0.6.2;

import './Level_1.sol';

contract EntranceDeployer {

  function newInstance () public returns (Entrance) {
    Entrance instance = new Entrance();
    return instance;
  }

  function check (address _instance, address _player) public returns (bool) {
    Entrance instance = Entrance(_instance);
    return instance.getResult(_player) == true;
  }
}
