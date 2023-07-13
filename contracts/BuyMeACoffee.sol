// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract BuyMeACoffee {
    // Events notify external users, such as a listening frontend website that something has happenned on the blockchain.
    event NewMemo (
        address indexed from,
        uint256 timestamp,
        string name, 
        string message,
        string CoffeeType
    );
    // Creating a struct
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
        string CoffeeType;
    }

    address payable owner;

    // creating memos
    Memo[] memos;

    constructor(){
        owner = payable(msg.sender);
    }
    // fetching all stored memos
    function getMemos() public view returns (Memo[] memory){
        return memos;
    }

    function buyCoffee(string memory _name, string memory _message, string memory _CoffeeType) public payable{
        require(msg.value > 0, "Can't buy Coffee for free");

        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message, 
            _CoffeeType
        ));

        emit NewMemo(msg.sender, block.timestamp, _name, _message, _CoffeeType);
    }
    // sends the entire balance stored in this contract to the owner
    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    function updateWithdraw(address _newAddress) public {
        require(msg.sender == owner, "Only owner can call this method");
        owner = payable(_newAddress);
    }

    function buyLargeCoffee (
        string memory _name,
        string memory _message,
        string memory _coffeeType
    ) public payable {
        require(msg.value == 0.03 ether, "Pay 0.03 to buy coffee");
        memos.push(
            Memo(msg.sender, block.timestamp, _name, _message, _coffeeType)
        );

        emit NewMemo(msg.sender, block.timestamp, _name, _message, _coffeeType);
    }
}
