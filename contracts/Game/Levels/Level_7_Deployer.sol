pragma solidity 0.6.2;

import './Level_7.sol';

contract VisibilityDeployer {

  function newInstance () public returns (Visibility) {
    Visibility instance = new Visibility();
    return instance;
  }

  function check (address _instance, address _player) public returns (bool) {
    Visibility instance = Visibility(_instance);
    return instance.win() == true;
  }
}
