pragma solidity 0.6.2;

/**
* @dev Shoot for the moon. Even if you miss, you'll land among the stars.
*/

contract ThinkBig {
    uint256 a = 2;

    function go (uint256 _n) internal returns (bool) {
        require (_n > 0 && _n*a < a, "failed");
        return true;
    }
}
