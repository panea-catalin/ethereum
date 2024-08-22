// SPDX-License-Identifier: MIT

//state the version
pragma solidity 0.8.24;

//definine the contract
contract SimpleStorage {
    uint256 public myFavoriteNumber; // defaults to 0
    //bool defaults to false
    //functions and variables can have 1 of 4
    //visibility specifiers: public, private,
    //external and internal //defaults to internal

    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    // Person public cat = Person({favoriteNumber: 7, name: "Cat"});
    //dynamic array Person[]; static array Person[3]
    Person[] public listOfPeople;

    mapping(string => uint256) public nameToFavoriteNumber;

    //view, pure
    function store(uint256 _favoriteNumber) public {
        myFavoriteNumber = _favoriteNumber;
        retrieve();
    }

    function retrieve() public view returns (uint256) {
        return myFavoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push(Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
