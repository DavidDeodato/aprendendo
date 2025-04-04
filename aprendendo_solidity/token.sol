pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MeuToken is ERC20 {

    //dono
    address public dono;
    //variavel para armazenar a quantidade de tokens mintados
    uint public quantidadeMintados;

    constructor() ERC20("MeuToken", "TCO2"){
        _mint(msg.sender, 100 * 10 ** decimals()); //criando 100 tokens né fi
        dono = msg.sender;
        quantidadeMintados = 0;

    }

    function enviarRestante (uint quantidade) public {
        _mint(dono, quantidade * 10 ** decimals());
    }


    function mintarNovosTokens (uint quantidade) public {
        require(msg.sender == dono, "ou, apenas o dono pode mintar tokens, fera");
        _mint(address(this), quantidade * 10 ** decimals());
        //atualizando a variavel de controle dos tokens
        quantidadeMintados = quantidadeMintados + (quantidade * 10 ** decimals());
    }

    function enviar_tokens_do_contrato (address destinatario, uint quantidade) public {
        //qualqeur um pode pegar tokens
        //verificando se tem tokens o suficiente
        require(balanceOf(address(this)) >= quantidade * 10 ** decimals(), "Nao ha tokens suficientes no contrato.");
        //transferindo
        // Transferindo tokens do contrato para o destinatário
        _transfer(address(this), destinatario, quantidade * 10 ** decimals());

        //atualizando a variavel de controle
        quantidadeMintados = quantidadeMintados - (quantidade * 10 ** decimals());

    }

    function ver_tokens_no_smart_contract () view public returns(uint){
        //quantos tokens tem no contrato
        return balanceOf(address(this));
    }



    
}