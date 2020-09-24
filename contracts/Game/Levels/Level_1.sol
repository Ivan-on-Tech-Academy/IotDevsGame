pragma solidity 0.6.2;

interface playerContract {
    function setData(address) external returns (bool);
}

/**
* @dev Player has to create a contract that includes a function setData(),
*      this function will receive a randomly generated address.
*      The player has to send any amount of ether to that address.
*/

contract Entrance {

  struct playerStruct {
    address  targetAddress;
    bool result;
  }
  mapping (address => playerStruct) public player;
  playerContract usr = playerContract (0x0);


  function ent_0 (address _playerContractAddress) internal returns (bool){
    setInterface(_playerContractAddress);
    player[msg.sender].targetAddress = randomAddress();
    usr.setData(player[msg.sender].targetAddress);
    require (address(player[msg.sender].targetAddress).balance > 0,"Target balance should be > than 0");
    player[msg.sender].result = true;
  }

  function setInterface (address _playerContractAddress) private {
      usr = playerContract(_playerContractAddress);
  }

  function randomAddress () private view returns (address){
      return address(uint160(uint256(now)));
  }

  function getResult (address _player) external view returns (bool) {
    return player[_player].result;
  }
}
