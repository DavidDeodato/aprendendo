// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CadastroNotas {

    struct Aluno {
        string nome;
        uint nota;
        bool aprovado;
    }

    mapping(uint => Aluno) public alunos;

    address public professor;

    constructor() {
        professor = msg.sender;
    }

    modifier apenasProfessor() {
        require(msg.sender == professor, "Apenas o professor pode cadastrar");
        _;
    }

    function cadastrarNota(uint id, string memory _nome, uint _nota) public apenasProfessor {
        require(_nota <= 100, "Nota invalida");
        bool status = _nota >= 60;
        alunos[id] = Aluno(_nome, _nota, status);
    }

    function verAluno(uint id) public view returns(string memory, uint, bool) {
        Aluno memory a = alunos[id];
        return (a.nome, a.nota, a.aprovado);
    }
}
