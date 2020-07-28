import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

pragma solidity 0.6.2;

contract Bank is ERC20 {

  string tokenName = "IvanRewardToken";
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

  /**
  * @dev This function is called by levelUp.
  * @param _n The amount of token to burn.
  * @notice This function will round the result to a multiple of 10 ** 18.
  */
  function isMultiple (uint256 _n) internal view returns (uint256) {
    uint256 p = 10 ** 18;
    uint256 t = p;
    while(true) {
        if (_n >= t+p) {t= t +p; } else {return t;}
    }
  }

}
