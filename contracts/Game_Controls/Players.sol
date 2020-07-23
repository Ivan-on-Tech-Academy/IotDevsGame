pragma solidity 0.6.2;

contract Players {

  /**
  * isPlayer is true if player is registered. False otherwise.
  */
  mapping (address => bool) isPlayer;

  /**
  * @dev Each IRT grants 1 level.
  */
  mapping (address => uint256) playerLevel;

  /**
  * @dev Require player is registered.
  */
  modifier onlyPlayer () {
    require (isPlayer[msg.sender] == true,"No such player");
    _;
  }

  /**
  * @dev Enable a new player.
  * @notice Registration cost is 1 ether.
  */
  function addPlayer () public payable {
    require (msg.value == 1 ether,"Register a new player costs 1 ether");
    isPlayer[msg.sender] = true;
  }

  /**
  * @dev A player can disable itself.
  */
  function removePlayer () public onlyPlayer {
    isPlayer[msg.sender] = false;
  }

  /**
  * @dev Each IRT grants 1 level.
  * @param _amount Has to be 10 ** 18 or mutiple.
  * @notice _amount 1.2 IRT will result in 1 ERT burnt.
  */
  function levelUp (uint256 _amount) public onlyPlayer {
    require (_amount >= 10 ** 18);
    uint256 amountToBurn = isMultiple(_amount);
    require (burnIRT(amountToBurn));
    uint256 increase = amountToBurn / 10 ** 18;
    playerLevel[msg.sender] += increase;

  }

  /**
  * @dev This function is called by levelUp.
  * @param _n The amount of token to burn.
  * @notice This function will round the result to a multiple of 10 ** 18.
  */
  function isMultiple (uint256 _n) public view returns (uint256) {
    uint256 p = 10 ** 18;
    uint256 t = 10 ** 18;
    while(true) {
        if (_n >= t+p) {t= t +p; } else {return t;}
    }
  }
}
