// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "remix_tests.sol";
import "./FreelaManager.sol";

contract TesteFreelaManager {

    FreelaManager contrato;

    function beforeEach() public {
        contrato = new FreelaManager();
    }

    function testeRegistroFreelancerTest() public {
        contrato.registrarFreelancer("Igor", "Solidity, React");
        (string memory nome, string memory hab, bool cadastrado) = contrato.freelancers(address(this));
        Assert.equal(nome, "Igor", "Nome errado");
        Assert.equal(hab, "Solidity, React", "Habilidade errada");
        Assert.ok(cadastrado, "Deveria estar cadastrado");
    }

    function criarProjetoTest() public {
        contrato.criarProjeto("ChatGPT DApp", "Criar uma IA frontend");
        (string memory titulo, , , ) = contrato.verProjeto(1);
        Assert.equal(titulo, "ChatGPT DApp", "Titulo incorreto");
    }

    function candidaturaESelecaoTest() public {
        contrato.registrarFreelancer("Dev", "Fullstack");
        contrato.criarProjeto("Site", "Landing page");

        contrato.candidatar(1);
        address[] memory lista = contrato.verCandidatos(1);
        Assert.equal(lista.length, 1, "Deveria ter 1 candidato");

        contrato.aceitarFreelancer(1, address(this));
        (, , address contratado, FreelaManager.StatusProjeto status) = contrato.verProjeto(1);
        Assert.equal(contratado, address(this), "Contrato errado");
        Assert.equal(uint(status), 1, "Status deveria ser EmAndamento");

        contrato.concluirProjeto(1);
        (, , , FreelaManager.StatusProjeto novoStatus) = contrato.verProjeto(1);
        Assert.equal(uint(novoStatus), 2, "Deveria estar Concluido");
    }
}
