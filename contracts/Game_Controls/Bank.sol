import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./Stake.sol";

pragma solidity 0.6.2;

contract Bank is ERC20, Stake {

  string tokenName = "IvanRewardToken";
  string tokenSymbol = "IRT";
  uint256 private totalCap = 100000000 * (10 ** 18); //Max amount of tokens. ( 100 millions).
                                                     //Wheneven tokens are burnt to level up,
                                                     //the total supply decreases.

  constructor () ERC20(tokenName,tokenSymbol)
  public {
    _mint(msg.sender, 10 ** 18);
  }

  /**
  * @dev Returns the total IRT cap.
  */
  function getTotalCap () public view returns (uint256) {
    return totalCap;
  }

  function startStaking (uint256 _amount, uint256 _nOfDays) public {
    increaseAllowance(address(this),_amount);
    transfer(address(this),_amount);
    _startStaking (_amount,_nOfDays);
  }

  function endStaking () public {
    uint256 toMint = _endStaking();
    _mint(address(this),toMint);
    staking[msg.sender].amountStaked = staking[msg.sender].amountStaked.add(toMint);
    uint256 toTransfer = staking[msg.sender].amountStaked;
    delete (staking[msg.sender]);
    transfer(msg.sender,toTransfer);
  }


  /**
  * @dev Verify that mint() does not exceed the total token cap.
  */
  function verifyCapOverflow (uint256 _amountToMint) internal {
    require (totalSupply().add(_amountToMint) <= totalCap, "Cap overlow, mint reversed");
  }

  function burnIRT (uint256 _amount) internal returns (bool){
    increaseAllowance (address(this),_amount);
    _burn (msg.sender,_amount);
    totalCap = totalCap.sub(_amount);
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
