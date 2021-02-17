// SPDX-License-Identifier: MIT

pragma solidity ^0.7.1;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Artist is ERC721 {
    address artist;

    // mapping for address to paintings
    mapping(uint256 => Painting) paintings;

    modifier onlyArtist() {
        require(msg.sender == artist, "Only artist can call this function");
        _;
    }

    constructor() ERC721("Artist", "ATC") {}

    // create new painting
    function createPainting(
        uint256 _id,
        string memory _title,
        uint256 price
    ) public returns (Painting) {
        Painting painting = new Painting(_id, _title, price);
        // assign new painting to mapping
        paintings[_id] = painting;

        return painting;
    }

    // function to retrieve painting by id
    function getPainting(uint256 _id) public view returns (Painting) {
        return paintings[_id];
    }
}

// https://github.com/deepcrazy/tokenFactory-exercise2/blob/master/tokenFactory.sol

contract Painting is ERC721 {
    // properties for the painting
    uint256 public id;
    address public artist;
    string public title;
    uint256 public price;

    constructor(
        uint256 _id,
        string memory _title,
        uint256 _price
    ) ERC721("Painting", "PTC") {
        id = _id;
        artist = msg.sender;
        title = _title;
        price = _price;
    }
}
