pragma solidity 0.6.2;

import './Level_2.sol';

contract TheGreatHallDeployer {

  function newInstance () public returns (address) {
    TheGreatHall instance = new TheGreatHall();
    return address(instance);
  }

  function check (address _instance, address _player) public returns (bool) {
    TheGreatHall instance = TheGreatHall(_instance);
    if(instance.getTimer(_player) < now){
      return true;
    } else {
      instance.reset(_player);
    }
  }
}
