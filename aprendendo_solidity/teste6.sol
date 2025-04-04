// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract multiplicacao{
    //setando variaveis de sistema
    address dono;

    //setnado variavel saldo
    uint public saldo;

    //variavel para armazenar o valor da multiplicacao atual
    uint public multiplicacao_atual;


    constructor(){
        dono = msg.sender;
        saldo = 0;
    }


    // função para ver quem é o dono dessa porra
    function ver_dono () view public returns (address){
        return(dono);
        
    }

    function ver_multiplicacao_atual () view public returns(uint){
        return(multiplicacao_atual);
    }

    


    //funcao para multiplicar dois numeros
    function multiplicar(uint x, uint y) public returns(uint){

        //fazendo a multiplicacao
        saldo = saldo + (x*y);
        multiplicacao_atual = (x * y);
        //retornando a multiplicação - chamando a funcao ver_multiplicacao_atual
        ver_multiplicacao_atual();


        return x * y;


    }

    


    function zerar() public {
        //vendo se voce é o dono
        require(msg.sender == dono, "opa fera, vc nao e o dono, pode isso nao");
        saldo = 0;
    }
}