pragma solidity 0.6.2;
import "@openzeppelin/contracts/math/SafeMath.sol";

contract Stake {

  using SafeMath for uint256;

  uint256 constant YearlyStakeInterest = 10;

  struct StakeIt {
    uint256 startTime;
    uint256 endTime;
    uint256 amountStaked;
  }

  mapping (address => StakeIt) public staking;

  function _startStaking (uint256 _amount, uint256 _nOfDays) internal {
    staking[msg.sender].startTime = now;
    staking[msg.sender].endTime = now + (_nOfDays.mul(1 days));
    staking[msg.sender].amountStaked = _amount;
  }

  function _endStaking () internal returns (uint256) {
    require (staking[msg.sender].endTime >= now);
    uint256 timeStakedDays = (staking[msg.sender].endTime.sub(staking[msg.sender].startTime)).div(1 days);
    uint256 toMint = ((staking[msg.sender].amountStaked*YearlyStakeInterest/100)/365)*timeStakedDays;
    return toMint;
  }
}
