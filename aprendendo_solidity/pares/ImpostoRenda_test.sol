// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "remix_tests.sol";
import "./ImpostoRenda.sol";

contract TesteImpostoRenda {

    ImpostoRenda contrato;

    function beforeEach() public {
        contrato = new ImpostoRenda();
    }

    function testarIsencaoTest() public {
        (uint imposto, string memory faixa) = contrato.calcularImposto(20000);
        Assert.equal(imposto, 0, "Deveria ser isento");
        Assert.equal(faixa, "Isento", "Faixa incorreta");
    }

    function testar10PorcentoTest() public {
        (uint imposto, string memory faixa) = contrato.calcularImposto(30000);
        Assert.equal(imposto, 3000, "Imposto deveria ser 10%");
        Assert.equal(faixa, "10%", "Faixa incorreta");
    }

    function testar20PorcentoTest() public {
        (uint imposto, string memory faixa) = contrato.calcularImposto(60000);
        Assert.equal(imposto, 12000, "Imposto deveria ser 20%");
        Assert.equal(faixa, "20%", "Faixa incorreta");
    }

    function testar30PorcentoTest() public {
        (uint imposto, string memory faixa) = contrato.calcularImposto(100000);
        Assert.equal(imposto, 30000, "Imposto deveria ser 30%");
        Assert.equal(faixa, "30%", "Faixa incorreta");
    }
}
