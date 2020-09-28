pragma solidity 0.6.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

// victories needs to be 3 or more.

contract Victim is ERC20 {

  using SafeMath for uint256;

  uint256 public victories;
  uint256 public i;
  address public owner;
  bool public claimed;

  constructor ()
  ERC20('Game Token','GMT')
  public
  {
    owner = msg.sender;
    claimed = false;
    i = 0;
    victories = 0;
  }

  function claim () public {
    require (!claimed);
    _mint(msg.sender,5 ether);
    claimed = true;
  }

  function play () public returns (bool) {

    increaseAllowance(msg.sender,1 ether);
    transferFrom(msg.sender,address(this), 1 ether);

    if(i == 0){
      i = now.add(30 seconds);
      return true;
    }

    if(i < i.add(30 seconds)) {
      victories = victories.add(1);
      i = i + victories.mul(30 seconds);

    } else {
      victories = victories.sub(1);
    }
    return true;
  }

  function unlock () public {
    if(balanceOf(msg.sender) == 0) {
      claimed = false;
      victories = 0;
    }
  }

}
