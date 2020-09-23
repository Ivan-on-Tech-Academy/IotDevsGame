pragma solidity 0.6.2;

interface ERC20Game {
  function symbol() external view returns (string memory);
  function balanceOf(address tokenOwner) external view returns (uint balance);
}

/**
* @dev Create a contract that mints 1 ERC20 token to the address of this contract.
* @dev Once your contract has been created and the erc minted, call the function in main.
* @notice your ERC20 token symbol must be 'XYZ'.
*
*/

contract TestERC20  {

  bool public completed;
  bytes32 constant symbolResult = 0x27fd9bb70fcea8125f7e0ba4eaeda4fb5ff28f5535e452dc1b70a42f567f4d75;

  function playERC (address _ercImplementation) internal {
    ERC20Game impl = ERC20Game(_ercImplementation);
    bytes32 sym = keccak256(abi.encodePacked(impl.symbol()));
    uint balance = impl.balanceOf(address(this));
    require (sym == symbolResult && balance == 10**18 );
    completed = true;
  }
}
