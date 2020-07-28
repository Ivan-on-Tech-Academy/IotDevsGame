pragma solidity 0.6.2;

interface playerContract {
    function setData(address) external;
}

/**
* @dev Player have to set a contract that includes a function setData(),
*      this function will receive a randomly generated address.
*      The player has to send any amount of ether to that address.
*/

contract Entrance {

  playerContract usr = playerContract (0x0);

  function ent_0 (address _playerContractAddress) public returns (bool){

    address targetAddress;

    setInterface(_playerContractAddress);

    (targetAddress) = antiHack();

    usr.setData(targetAddress);

    require (address(targetAddress).balance > 0,"Target balance should be > than 0");

    return true;

  }

  function setInterface (address _playerContractAddress) internal {
      usr = playerContract(_playerContractAddress);

  }

  function antiHack () private view returns (address){

    //@dev address(uint160(uint256(now))) >> generates a random address
      return address(uint160(uint256(now)));
    }

}
