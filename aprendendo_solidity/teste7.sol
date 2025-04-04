pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MeuToken is ERC20 {
    constructor() ERC20("MeuToken", "DvdToken"){
        _mint(msg.sender, 100 * 10 ** decimals()); //criando 100 tokens né fi

    }


    
}