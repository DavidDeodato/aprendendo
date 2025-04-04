// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Reclamacoes {

    enum Severidade { Baixa, Media, Alta }

    struct Reclama {
        string descricao;
        Severidade nivel;
    }

    mapping(address => Reclama[]) public reclamacoes;

    function registrarReclamacao(string memory _descricao, uint _nivel) public {
        require(reclamacoes[msg.sender].length < 3, "Limite de 3 reclamacoes atingido");
        require(_nivel <= 2, "Nivel invalido");
        Severidade nivelConvertido = Severidade(_nivel);
        Reclama memory nova = Reclama(_descricao, nivelConvertido);
        reclamacoes[msg.sender].push(nova);
    }

    function verReclamacaoPorId(uint id) public view returns(string memory, Severidade) {
        return (
            reclamacoes[msg.sender][id].descricao,
            reclamacoes[msg.sender][id].nivel
        );
    }

    function totalReclamacoes() public view returns (uint) {
        return reclamacoes[msg.sender].length;
    }
}
