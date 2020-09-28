pragma solidity 0.6.2;

import './Level_6.sol';

contract VictimDeployer {

  function newInstance () public returns (Victim) {
    Victim instance = new Victim();
    return instance;
  }

  function check (address _instance, address _player) public returns (bool) {
    Victim instance = Victim(_instance);
    return instance.victories() >= 3;
  }
}
