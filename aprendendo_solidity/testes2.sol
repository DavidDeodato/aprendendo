pragma solidity ^0.8.0;

import "remix_tests.sol"; // permite usar as funções assert
import "contracts/teste9.sol";


contract TesteContrato2{

    CadastroPassageiros contrato;


    function beforeEach() public {
        contrato = new CadastroPassageiros(); // uma nova instancia do meu smart contract (meu contrato)
    }

    //testar cadastro de passageiro
    function testarCadastroPassageiroTest() public{
        contrato.criarPassageiro(1, "david", 19, true);

        //pegando os valores retornados 
        (string memory nome, uint idade, bool brasileiro) = contrato.verPassageiro(1);
        //testando valor por valor
        Assert.equal(nome, "david", "o nome deveria ser david");
        Assert.equal(idade, 19, "a idade deveria ser 19");
        Assert.equal(brasileiro, true, "o brasileiro deveria vir como true");

    }

    //testando o delete de passgeiro
    function testarDeletePassageiroTest() public{
        contrato.criarPassageiro(1, "david", 19, true);

        //deletar esses dados criados
        contrato.deletarPassageiro(1);

        //chamar a funcao verpassageiro, para ver se tudo vai tar vazio msm
        (string memory nome, uint idade, bool brasileiro) = contrato.verPassageiro(1);

        //comparando compao a campo
        Assert.equal(nome, "", "o nome deveria estar vazio");
        Assert.equal(idade, 0, "a idade deveria ser zero");
        Assert.equal(brasileiro, false, "o estado de brasileiro deveria ser false");
    }

    //testando subscrita de passageiros
    function testarsobrescricaopassageirosTest() public{
        contrato.criarPassageiro(1, "david", 19, true);
        //tentando sobscrever
        contrato.criarPassageiro(1, "ana", 15, false);

        //pegando os valores retornados
        (string memory nome, uint idade, bool brasileiro) = contrato.verPassageiro(1);

        //comparando valores
        Assert.equal(nome, "ana", "o nome deveria ter sido sobscrito");
        Assert.equal(idade, 15, "a idade deveria ter sido sobscrita");
        Assert.equal(brasileiro, false, "O estado de brasileiro deveria ser false");
    }



}