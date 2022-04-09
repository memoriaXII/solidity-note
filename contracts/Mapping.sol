pragma solidity 0.5.1;

contract MyContract {
    uint256 peopleCount = 0;

    modifier onlyOwner() {
    require(msg.sender == owner);
    _;
    }

    mapping(uint => Person) public people;

    struct Person {
        uint _id;
        string _firstName;
        string _lastName;
    }

    function addPerson(string memory _firstName, string memory _lastName) public {
        peopleCount += 1;
        people[peopleCount] = Person(peopleCount, _firstName, _lastName);
    }
}