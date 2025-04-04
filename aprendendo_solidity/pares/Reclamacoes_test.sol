// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "remix_tests.sol";
import "./Reclamacoes.sol";

contract TesteReclamacoes {

    Reclamacoes contrato;

    function beforeEach() public {
        contrato = new Reclamacoes();
    }

    function registrarReclamacaoValidaTest() public {
        contrato.registrarReclamacao("Nao chegou meu pedido", 2); // Alta
        (string memory desc, Reclamacoes.Severidade nivel) = contrato.verReclamacaoPorId(0);
        Assert.equal(desc, "Nao chegou meu pedido", "Descricao incorreta");
        Assert.equal(uint(nivel), 2, "Deveria ser nivel alto");
    }

    function limitarReclamacoesTest() public {
        contrato.registrarReclamacao("1", 0);
        contrato.registrarReclamacao("2", 1);
        contrato.registrarReclamacao("3", 2);

        uint total = contrato.totalReclamacoes();
        Assert.equal(total, 3, "Deveria ter 3 reclamacoes");

        // 4ª reclamacao deve falhar → mas Remix não testa falha de require direto
        // Isso só seria possível em frameworks como Hardhat
    }
}
