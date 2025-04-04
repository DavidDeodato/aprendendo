//definindo a versão do smart contact
pragma solidity ^0.8.20;

contract MeuContrato {
    // tipo básico de dado para armazenar na blockchain 1: uint
    uint public numero;

    // outro tipo básico de dado para blockchain

    address public bigfodase_dono;

    // outro tipo básico de dado para blockchain

    string public fodase;

    uint public valor_produto;



    constructor(){
        numero = 10;
        bigfodase_dono = msg.sender;


    }


    function fodase_numerozinho(uint x) public returns(uint){
        //calculando algo com o x, mas só se ele for o dono porra kkk
        require(msg.sender == bigfodase_dono, "nao pode");
        numero = numero + x;
      
        return numero;

    }


    function somar_fodasehehe(uint numero_fodase, uint numero_fodase2) public pure returns (uint){
        return numero_fodase + numero_fodase2;
    }

    //vendo o valor de numero
    function ver_numero() public {
        numero = numero + 100;
        
    }

    function ver_numero_memo() public view returns(uint){
        require(msg.sender == bigfodase_dono, "pode nao man");
        return numero;
    }

    //funcao de definir o imposto

    function definir_imposto(uint imposto) private pure returns(uint){
        return imposto;
    }

    //calcular valor do produto, com base no imposto

    function calcular_preco_produto (uint imposto, uint valor_atual_produti) public returns (uint){
        //chamando a funcao que defini o imposto
    
        valor_produto = definir_imposto(imposto) * valor_atual_produti;
        return valor_produto;
    }

    function ver_valor_produto_agora () public view returns (uint){
        return valor_produto;
    }

    





}