pragma solidity 0.6.2;

import './Level_4.sol';

contract FindTheOwnerDeployer {

  function newInstance () public returns (FindTheOwner) {
    FindTheOwner instance = new FindTheOwner();
    return instance;
  }

  function check (address _instance, address _player) public returns (bool) {
    FindTheOwner instance = FindTheOwner(_instance);
    return instance.completed() == true;
  }
}
