// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract loja{
    //definindo variaveis de estado
    address public dono;

    uint public historico_comprador;
    
    //criando lista de produtos

    uint[] public produtos;


    constructor(){
        //definindo quem é o dono
        dono = msg.sender;

    }

    function definir_produtos(string produto) public{
    // colocando o produto passado na lista, mas antes, verifiacando se é o dono chamando
    require(msg.sender == dono, "oshi pae, vc nao e o dono nao");

    }




    


}



