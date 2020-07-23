import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

pragma solidity 0.6.2;

contract Bank is ERC20 {

  string tokenName = "IvanRewardToken ";
  string tokenSymbol = "IRT";

  constructor () ERC20(tokenName,tokenSymbol)
  public {
    _mint(msg.sender, 10 ** 18);
  }

  function burnIRT (uint256 _amount) internal returns (bool){
    increaseAllowance (address(this),_amount);
    _burn (msg.sender,_amount);
    return true;
  }

}
