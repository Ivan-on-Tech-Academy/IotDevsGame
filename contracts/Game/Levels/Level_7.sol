pragma solidity 0.6.2;

// Set win to true;

contract Visibility {

  address public owner;
  bool public win;

  constructor () public {
    owner = msg.sender;
    win = false;
  }

  function play () private {
    win = true;
  }

  function play (uint8 _number) public payable {
    if(msg.value > 0.1 ether
    &&
    _number > 10)
    play();
  }

}
