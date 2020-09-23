pragma solidity 0.6.2;

contract FallBack {

    mapping (address => bool) public wins;

    fallback () external payable {
        win();
    }

    function win () private {
        wins[msg.sender] = true;
    }

}
