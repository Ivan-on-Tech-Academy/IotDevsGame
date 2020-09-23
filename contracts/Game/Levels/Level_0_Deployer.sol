pragma solidity 0.6.2;

import './Level_0.sol';

contract TakeOwneshipDeployer {

  function newInstance () public returns (address) {
    TakeOwneship instance = new TakeOwneship();
    return address(instance);
  }

  function check (address _instance, address _player) public returns (bool) {
    TakeOwneship instance = TakeOwneship(_instance);
    return instance.owner() == _player;
  }
}
