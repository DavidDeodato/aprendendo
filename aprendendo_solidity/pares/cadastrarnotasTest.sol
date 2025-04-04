// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "remix_tests.sol";
import "./CadastroNotas.sol";

contract TesteCadastroNotas {

    CadastroNotas contrato;

    function beforeEach() public {
        contrato = new CadastroNotas();
    }

    function cadastrarAlunoAprovadoTest() public {
        contrato.cadastrarNota(1, "Igor", 85);
        (string memory nome, uint nota, bool aprovado) = contrato.verAluno(1);
        Assert.equal(nome, "Igor", "Nome deveria ser Igor");
        Assert.equal(nota, 85, "Nota deveria ser 85");
        Assert.ok(aprovado, "Deveria estar aprovado");
    }

    function cadastrarAlunoReprovadoTest() public {
        contrato.cadastrarNota(2, "Bruno", 50);
        (, uint nota, bool aprovado) = contrato.verAluno(2);
        Assert.equal(nota, 50, "Nota deveria ser 50");
        Assert.ok(!aprovado, "Deveria estar reprovado");
    }
}
