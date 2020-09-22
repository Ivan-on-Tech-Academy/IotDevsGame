pragma solidity 0.6.2;

import "@openzeppelin/contracts/math/SafeMath.sol";

contract TakeOwneship {

  using SafeMath for uint256;

  mapping (address => bool) owners;
  mapping (address => uint256) deposits;

  modifier onlyOwners () {
    require (owners[msg.sender] == true);
    _;
  }

  function deposit () public payable {
    deposits[msg.sender] = deposits[msg.sender].add(msg.value);
  }

  function _withdraw () private onlyOwners {
    msg.sender.transfer(deposits[msg.sender]);
  }

  function claimOwnership () public {
    require (deposits[msg.sender] > 0.1 ether);
    owners[msg.sender] = true;
    _withdraw();
  }
}
