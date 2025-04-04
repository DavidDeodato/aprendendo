// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vendinha {

    address public dono;

    struct Produto {
        string nome;
        uint preco; // em wei
        uint estoque;
    }

    mapping(uint => Produto) public produtos;
    mapping(address => uint[]) public produtosComprados;

    uint public contadorProdutos;

    modifier apenasDono() {
        require(msg.sender == dono, "Apenas o dono pode fazer isso");
        _;
    }

    constructor() {
        dono = msg.sender;
    }

    function cadastrarProduto(string memory nome, uint preco, uint estoque) public apenasDono {
        require(preco > 0, "Preco deve ser maior que 0");
        require(estoque > 0, "Estoque deve ser maior que 0");
        contadorProdutos++;
        produtos[contadorProdutos] = Produto(nome, preco, estoque);
    }

    function alterarPreco(uint id, uint novoPreco) public apenasDono {
        require(produtos[id].preco != 0, "Produto inexistente");
        produtos[id].preco = novoPreco;
    }

    function adicionarEstoque(uint id, uint qtd) public apenasDono {
        require(produtos[id].estoque != 0, "Produto inexistente");
        produtos[id].estoque += qtd;
    }

    function comprarProduto(uint id) public payable {
        Produto storage p = produtos[id];
        require(p.estoque > 0, "Produto sem estoque");
        require(msg.value >= p.preco, "Valor insuficiente para compra");

        // Registra a compra
        produtosComprados[msg.sender].push(id);
        p.estoque--;
    }

    function verProduto(uint id) public view returns (string memory, uint, uint) {
        Produto memory p = produtos[id];
        return (p.nome, p.preco, p.estoque);
    }

    function verCompras() public view returns (uint[] memory) {
        return produtosComprados[msg.sender];
    }

    function verPreco(uint id) public view returns (uint) {
        return produtos[id].preco;
    }
}
