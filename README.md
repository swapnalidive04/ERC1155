# ERC1155
Buy and Sell NFTs using ERC1155

Assignment Question:Create a Marketplace Smart contract to buy and sell NFT with your custom ERC1155 Standard.

(Note: Strictly Use ERC1155 only, No plagiarism allowed, can use OpenZeppelin)

The candidate can use the standard library if needed.

-- Functionalities: --
1) Create Fungible Tokes with ERC1155 Standard
2) Create Non-Fungible Tokens ERC1155 Standard
3) Need to add 2.5% of Sell Price/Token(s) to Platform Fees.
4) Users can set Fractional Royalties of Multiple Owner(s) for the NFT’s Selling Price.
5) Users can Buy & Sell NFT using Fungible Token generated as mentioned above (Marketplace)

Generalized solution to set Frational Royalties : 
Solidity do not accept the fractional number so if we have to pass 2.5% then we have to pass it like 25 / 1000

Formula to set Fractional Royalties : 
n : number of digits of the number
d : decimal point 
O : output

O = n / 10<sup>n-d</sup>

For Example : 

n = 2
d = 1 
O = 25 / 10<sup>2-1</sup> 
O = 2.5





