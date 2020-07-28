pragma solidity 0.6.2;

interface playerContract {
    function setData(address) external returns (bool);
}

/**
* @dev Player has to create a contract that includes a function setData(),
*      this function will receive a randomly generated address.
*      The player has to send any amount of ether to that address.
* @notice setData () should return true.
*/

contract Entrance {

  playerContract usr = playerContract (0x0);

  function ent_0 (address _playerContractAddress) public returns (bool){

    address targetAddress;
    bool check;

    setInterface(_playerContractAddress);

    targetAddress = randomAddress();

    check = usr.setData(targetAddress);

    require (check && address(targetAddress).balance > 0,"Target balance should be > than 0");

    return true;
  }

  function setInterface (address _playerContractAddress) internal {
      usr = playerContract(_playerContractAddress);
  }

  function randomAddress () private view returns (address){
      return address(uint160(uint256(now)));
    }

}
