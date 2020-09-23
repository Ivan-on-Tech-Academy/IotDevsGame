pragma solidity 0.6.2;

import './Level_4.sol';

contract FindTheOwnerDeployer {

  function newInstance () public returns (address) {
    FindTheOwner instance = new FindTheOwner();
    return address(instance);
  }

  function check (address _instance, address _player) public returns (bool) {
    FindTheOwner instance = FindTheOwner(_instance);
    return instance.completed() == true;
  }
}
