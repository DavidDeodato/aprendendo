pragma solidity ^0.8.20;

contract CadastroPassageiros{


    //criando um struct de passageiro
    struct Passageiro {
        string nome;
        uint idade;
        bool brasileiro;

    }

    //mapping para guardar os passageiros
    mapping(uint => Passageiro) public Passageiros;


    function criarPassageiro(uint id, string memory _nome, uint _idade, bool _brasileiro) public returns(uint ,string memory, uint, bool){
        // instanciando as informacoes
        uint idade = _idade;
        string memory nome = _nome;
        bool brasileiro = _brasileiro;

        //criando um objeto passageiro
        Passageiro memory pessoa_atual = Passageiro(nome, idade, brasileiro);

        //colocando essa pessoa no mapping
        Passageiros[id] = pessoa_atual;
        return (id , nome,  idade, brasileiro);
    }


    function verPassageiro (uint id) view public returns(string memory, uint, bool){
        Passageiro memory pessoa = Passageiros[id];
        return (pessoa.nome, pessoa.idade,  pessoa.brasileiro);

        
    }

}