import "../../Game_Controls/Players.sol";

pragma solidity 0.6.2;

interface playerContract {
    function setStructData(address,uint256,string calldata,uint8 [5] calldata) external;
    function getStructData() external returns (address,uint256,string memory, uint8[5] memory);
}


contract Entrance {

  function ent_0 (address _player, address _playerContractAddress) public returns (bool) {
    /**
     * @dev Write a contract that has a function setStructData().
     * @dev In the same contract, write also a function getStructData().
     * @dev Create a struct that must contain: uint256 a && string b && uint8 c [5]
     * @dev The struct must be accessible via a mapping (key => address)
     * @dev The function setStructData() must allow to set the struct variables.
     * @dev The function getStructData() must return the content of the struct.
     */

     /**
     * @dev Declaring variables that will contain player data returned.
     */
     address a;
     uint256 b;
     string memory c;
     uint8 [5] memory d;


     /**
      * @dev Declaring the control variables.
     */
     address check0;
     uint256 check1;
     string memory check2;
     uint8 [5] memory check3;

     (check0,check1,check2,check3) = antiHack();
     playerContract(_playerContractAddress).setStructData(check0,check1,check2,check3);
     (a,b,c,d) = playerContract(_playerContractAddress).getStructData();

     require (
       keccak256(abi.encodePacked(check0,check1,check2,check3))
       ==
       keccak256(abi.encodePacked(a,b,c,d)), "Failed"
     );
     return true;
  }

  function antiHack () private returns (address,uint256,string memory,uint8 [5] memory){

    // 3 random strings
    string memory x = "Ivan on tech bootcamp";
    string memory y = "on Ivan bootcamp tech";
    string memory z = "tech Ivan on bootcamp";
    uint256 shuffleStrings = now%3;

    // Creating a randomly populated array
    uint8[5] memory a;
    uint8 i = 0;

    while (i < 5){
      if (now%2 == 0) {
        a[i] = 0;
      } else {
        a[i] = 1;
      }
      i++;
    }

    //@dev address(uint160(uint256(now))) >> generates a random address

    if (shuffleStrings == 0) {
      return (address(uint160(uint256(now))),now,x,a);
    } else if (shuffleStrings == 1) {
      return (address(uint160(uint256(now))),now,y,a);
    } else if (shuffleStrings == 2) {
      return (address(uint160(uint256(now))),now,z,a);
    }

  }
}
