// contracts/GameItems.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract MarketPlace is ERC1155 {
    uint256 public constant COINS = 0;   
    address owner; 
    address coldWallet;

    //mapping to store nft with selling price
    mapping(uint => uint) sellingPrice; 
    //mapping of nft owner with nft id
    mapping(uint => address) nftOwner;

    //modifier       
    modifier onlyOwner {
      require(msg.sender == owner);
      _;
    }

    constructor(address _coldWallet) public ERC1155("") {
        _mint(msg.sender, COINS, 10**18, "");  
        owner = msg.sender;      
        coldWallet = _coldWallet;
    }

    //function to create new nft
     function createToken(uint _id) public{
        _mint(msg.sender, _id, 1, "");
        nftOwner[_id] = msg.sender;
    }

    //function to get nft owner
    function getNftOwner(uint _id) public view returns(address){
        return nftOwner[_id];
    }

    //function to set selling price
    function setSellingPrice(uint _nftId, uint _sellingPrice) public {
        require(nftOwner[_nftId] == msg.sender , "Address is not nft owner");
        sellingPrice[_nftId] = _sellingPrice;
    }

    //function to get selling price for nft
    function getSellingPrice(uint _nftId) public view returns(uint){
        return sellingPrice[_nftId];
    }

    //function to transfer fungible tokens from owner to other address
    function transferCoins(address _address, uint _amount) public onlyOwner {
        safeTransferFrom(msg.sender, _address, 0, _amount, "0x00");
    }

    // sell NFT 
    // only the nft owner can sell it
    function sellNFT(uint _nftId, address _newOwner) public {
        require(nftOwner[_nftId] == msg.sender , "Address is not nft owner");
        safeTransferFrom(msg.sender, _newOwner, _nftId, 1, "0x00");
        nftOwner[_nftId] =  _newOwner;        
    }

    // buy NFT
    function buyNFT(uint _nftId) public {        
        uint fees = sellingPrice[_nftId] * 25 / 1000; // 2.5% 
        uint amount = sellingPrice[_nftId] - fees;
        safeTransferFrom(msg.sender, nftOwner[_nftId], 0, amount, "0x00"); 
        safeTransferFrom(msg.sender, coldWallet , 0, fees, "0x00"); 
    }  

}