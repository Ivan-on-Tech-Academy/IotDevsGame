pragma solidity 0.6.2;

import "@openzeppelin/contracts/math/SafeMath.sol";

contract TakeOwneship {

  using SafeMath for uint256;

  address public owner;
  mapping (address => uint256) deposits;

  constructor () public {
    owner = msg.sender;
  }

  modifier onlyOwners () {
    require (owner == msg.sender);
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
    owner = msg.sender;
    _withdraw();
  }
}
