pragma solidity ^0.4.4;

contract People {
  Person[] public people;

  struct Person {
    bytes32 name;
    uint age;
  }

  function addPerson(bytes32 name, uint age) returns (bool addSucceed) {

    Person memory newPerson; // Create new struct in memory
    newPerson.name = name;
    newPerson.age = age;

    people.push(newPerson); 
    return true;
  }

  // Solidity doesnt let you return struct so need to return array for name and age
  function listAllPerson() constant returns (bytes32[], uint[]) {
    uint length = people.length;
    bytes32[] memory names = new bytes32[](length);
    uint[] memory ages = new uint[](length);

    // Loop through our people array
    for (uint i = 0; i < people.length; i++) {
      Person memory curPerson;
      curPerson = people[i];
      names[i] = curPerson.name;
      ages[i] = curPerson.age;
    }
    return (names, ages);
  }

}