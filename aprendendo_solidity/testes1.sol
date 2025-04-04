// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "remix_tests.sol"; // permite usar as funções assert
import "contracts/teste5.sol";

contract TesteContrato {

    lojas contrato; // lojas' é o nome do meu contrato dentro do arquivo 'teste5.sol'

    //função especial que roda antes de cada teste (inicializa uma instancia do contrato principal)

    function beforeEach() public {
        contrato = new lojas(); // uma nova instancia do meu smart contract (meu contrato)
    }

//verificando a funcionalidade do dono_loja, vendo se tá pegando realmente o endereço de quem tá fazendo o deploy
    function donoEhCorretoTest() public {
        Assert.equal(contrato.dono_loja(), address(this), "O dono, nesse contexto, deveria ser o endereco do contrato, mas nao foi");

    }

//testando a funcao de cadastro de produtos
    function cadastrarProdutosTeste() public {
        //criando as condições
        contrato.cadastrar_produtos(1, "banana");
        //verificando se realmente retorna 1 e banana
        Assert.equal(contrato.ver_um_produto(1), "banana", "o retorno deveria ser 'banana', mas nao foi");
    }

//verificando se a funcao de ver todos produtos está funcionando

    function verTodosProdutosTest() public{
        contrato.cadastrar_produtos(1, "banana");
        contrato.cadastrar_produtos(2, "cebola");

        //chamando a funcao ver todos os produtos
        uint[] memory produtos = contrato.ver_todos_produtos();

    

        //vendo se o array tem o tamanho correto
        Assert.equal(produtos.length, 2, "a lista de produtos deveria ter apenas 2 indices");
    }

//testar se o mapping estar guardando os itens corretamente

    function validarMappingTest() public {
        contrato.cadastrar_produtos(1, "banana");
        contrato.cadastrar_produtos(2, "cebola");

    //verificando se o mapping ta certo
    Assert.equal(contrato.produtos(1), "banana", "o retorno deveria ser banana");
    Assert.equal(contrato.produtos(2), "cebola", "o retorno deveria ser cebola");
    }


//testando se o dono_loja nao é vazio

    function donoLojaNaoVazioTest() public {
        Assert.notEqual(contrato.dono_loja(), address(0), "o dono deveria ser um endereco valido");
    }

//vendo se o valor teste é maior que 9

    function vervalortesteTest () public {
        uint valorteste = contrato.valorteste();
        Assert.ok(valorteste <= 10, "deveria ser igual ou menor que dez");
    }

    


}



    












