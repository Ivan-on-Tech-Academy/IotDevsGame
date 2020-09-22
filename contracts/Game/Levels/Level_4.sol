pragma solidity 0.6.2;

// owner of USDT: 0xdAC17F958D2ee523a2206206994597C13D831ec7

/**
* @dev Because the blockchain is public, you can see who's the owner of the contract
* address above.
* One way to do this is to call the function getOwner().
* The function below accepts a parameter _address which has to be the owner of the contract.
* The level is completed if the hashing of the address is equal to: 0x61251af2a34c4b856276127a6d85e236c257545c8bd5011ac4f0c05c15327a7d
*/


contract FindTheOwner {

  bytes32 constant result = 0x61251af2a34c4b856276127a6d85e236c257545c8bd5011ac4f0c05c15327a7d;

  function findIt (address _owner) internal pure returns (bool) {
    bytes32 res = hash(_owner);
    require (res == result,"not matching");
    return true;
  }

  function hash (address _owner) private pure returns (bytes32) {
    return keccak256(abi.encodePacked(_owner));
  }
}
