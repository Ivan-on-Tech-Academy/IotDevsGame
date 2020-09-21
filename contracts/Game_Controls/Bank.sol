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
    increaseAllowance(msg.sender,_amount);
    transferFrom(msg.sender,address(this),_amount);
    _startStaking (_amount,_nOfDays);
  }

  function endStaking () public {
    uint256 toMint = _endStaking();
    mintIRT(address(this),toMint);
    uint256 toTransfer = staking[msg.sender].amountStaked.add(toMint);
    delete (staking[msg.sender]);
    this.transfer(msg.sender,toTransfer);
  }

  // Mock functions for testing purpose //

  function testEndStaking (uint _days) public {
    uint256 toMint = _endStakingTest(_days);
    mintIRT(address(this),toMint);
    uint256 toTransfer = staking[msg.sender].amountStaked.add(toMint);
    delete (staking[msg.sender]);
    this.transfer(msg.sender,toTransfer);
  }

  function mintLotsOfTokens () public {
    verifyCapOverflow (100000000 * (10 ** 18) + 1);
  }

  // End of mock functions //

  function mintIRT (address _to, uint256 _amount) internal {
    verifyCapOverflow(_amount);
    _mint(_to,_amount);
  }

  /**
  * @dev Verify that mint() does not exceed the total token cap.
  */
  function verifyCapOverflow (uint256 _amount) private {
    require (totalSupply().add(_amount) <= totalCap, "Cap overlow, mint reversed");
  }

  function burnIRT (uint256 _amount) internal {
    increaseAllowance(msg.sender,_amount);
    _burn (msg.sender,_amount);
    totalCap = totalCap.sub(_amount);
  }

}
