// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ImpostoRenda {

    // Calcula imposto com base na renda
    function calcularImposto(uint rendaAnual) public pure returns (uint imposto, string memory faixa) {
        if (rendaAnual <= 24000) {
            return (0, "Isento");
        } else if (rendaAnual <= 48000) {
            uint valor = (rendaAnual * 10) / 100;
            return (valor, "10%");
        } else if (rendaAnual <= 96000) {
            uint valor = (rendaAnual * 20) / 100;
            return (valor, "20%");
        } else {
            uint valor = (rendaAnual * 30) / 100;
            return (valor, "30%");
        }
    }
}
