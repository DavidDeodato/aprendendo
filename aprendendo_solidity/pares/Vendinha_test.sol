// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "remix_tests.sol";
import "./Vendinha.sol";

contract TesteVendinha {

    Vendinha loja;

    function beforeEach() public {
        loja = new Vendinha();
    }

    function cadastroProdutoTest() public {
        loja.cadastrarProduto("Banana", 1 ether, 5);
        (string memory nome, uint preco, uint estoque) = loja.verProduto(1);
        Assert.equal(nome, "Banana", "Nome errado");
        Assert.equal(preco, 1 ether, "Preco errado");
        Assert.equal(estoque, 5, "Estoque errado");
    }

    function alteraPrecoTest() public {
        loja.cadastrarProduto("Melancia", 2 ether, 3);
        loja.alterarPreco(1, 3 ether);
        uint preco = loja.verPreco(1);
        Assert.equal(preco, 3 ether, "Preco nao atualizado corretamente");
    }

    function estoqueTest() public {
        loja.cadastrarProduto("Pera", 1 ether, 2);
        loja.adicionarEstoque(1, 3);
        (, , uint estoque) = loja.verProduto(1);
        Assert.equal(estoque, 5, "Estoque nao atualizado corretamente");
    }

    function comprarProdutoTest() public payable {
        loja.cadastrarProduto("Laranja", 1 ether, 1);
        loja.comprarProduto{value: 1 ether}(1);
        (, , uint estoque) = loja.verProduto(1);
        Assert.equal(estoque, 0, "Estoque deveria ser 0");
    }

    function verComprasTest() public payable {
        loja.cadastrarProduto("Morango", 1 ether, 1);
        loja.comprarProduto{value: 1 ether}(1);
        uint[] memory compras = loja.verCompras();
        Assert.equal(compras.length, 1, "Deveria ter 1 item comprado");
        Assert.equal(compras[0], 1, "ID comprado deveria ser 1");
    }
}
