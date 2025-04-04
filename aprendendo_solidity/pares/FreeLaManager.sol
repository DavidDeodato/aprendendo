// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FreelaManager {

    address public admin;

    enum StatusProjeto { Aberto, EmAndamento, Concluido }

    struct Projeto {
        uint id;
        string titulo;
        string descricao;
        address contratado;
        StatusProjeto status;
    }

    struct Freelancer {
        string nome;
        string habilidades;
        bool cadastrado;
    }

    uint public contadorProjetos;
    mapping(address => Freelancer) public freelancers;
    mapping(uint => Projeto) public projetos;
    mapping(uint => address[]) public candidatos; // projetoId => lista de candidatos

    modifier apenasAdmin() {
        require(msg.sender == admin, "Apenas o admin pode fazer isso");
        _;
    }

    modifier apenasFreelancerCadastrado() {
        require(freelancers[msg.sender].cadastrado, "Voce precisa se registrar como freelancer");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function registrarFreelancer(string memory nome, string memory habilidades) public {
        require(!freelancers[msg.sender].cadastrado, "Ja registrado");
        freelancers[msg.sender] = Freelancer(nome, habilidades, true);
    }

    function criarProjeto(string memory titulo, string memory descricao) public apenasAdmin {
        contadorProjetos++;
        projetos[contadorProjetos] = Projeto(contadorProjetos, titulo, descricao, address(0), StatusProjeto.Aberto);
    }

    function candidatar(uint idProjeto) public apenasFreelancerCadastrado {
        require(projetos[idProjeto].id != 0, "Projeto inexistente");
        candidatos[idProjeto].push(msg.sender);
    }

    function aceitarFreelancer(uint idProjeto, address escolhido) public apenasAdmin {
        require(projetos[idProjeto].status == StatusProjeto.Aberto, "Projeto nao esta aberto");
        projetos[idProjeto].contratado = escolhido;
        projetos[idProjeto].status = StatusProjeto.EmAndamento;
    }

    function concluirProjeto(uint idProjeto) public apenasAdmin {
        require(projetos[idProjeto].status == StatusProjeto.EmAndamento, "Projeto nao esta em andamento");
        projetos[idProjeto].status = StatusProjeto.Concluido;
    }

    function deletarProjeto(uint idProjeto) public apenasAdmin {
        delete projetos[idProjeto];
    }

    function verProjeto(uint idProjeto) public view returns (
        string memory titulo,
        string memory descricao,
        address contratado,
        StatusProjeto status
    ) {
        Projeto memory p = projetos[idProjeto];
        return (p.titulo, p.descricao, p.contratado, p.status);
    }

    function verCandidatos(uint idProjeto) public view returns (address[] memory) {
        return candidatos[idProjeto];
    }
}
