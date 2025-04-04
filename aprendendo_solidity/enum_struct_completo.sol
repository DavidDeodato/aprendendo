pragma solidity ^0.8.20;


contract multiplosPassageirosPorPessoa{

    enum Categoria { ADULTO_BRASILEIRO, JOVEM_BRASILEIRO, ESTRANGEIRO }

    struct Passageiro {
        string nome;
        uint idade;
        bool brasileiro;
        Categoria categoria;
    }

    mapping(address => Passageiro[]) public listaPassageiros;


    //funcao para classificar e registrar cada passageiro novo (para cada sender)

    function classificarEregistrar (string memory _nome, uint _idade, bool _brasileiro) public {
        //variavel para armazenar o valor da categoria
        Categoria categoriaAtual;

        if (_brasileiro){

            if (_idade >= 18){
                categoriaAtual = Categoria.ADULTO_BRASILEIRO;
                
            }
            else {
                categoriaAtual = Categoria.JOVEM_BRASILEIRO;
            }

        }

        else {
            categoriaAtual = Categoria.ESTRANGEIRO;
        }

        //verificando quantas listas aquele sender tem dentro do mapping
       

        //criando o objeto do passageiro
        Passageiro memory passageiroAtual = Passageiro(_nome, _idade, _brasileiro, categoriaAtual);

        //colocando ele dentro da lista do mapping para aquele sender
       listaPassageiros[msg.sender].push(passageiroAtual);
    }

    //a partir de um id, retornar o passageiro especifico do sender

    function ver_passageiro_por_id (uint id) public view returns(string memory nome, uint idade, bool brasileiro, Categoria){
        return (listaPassageiros[msg.sender][id].nome, listaPassageiros[msg.sender][id].idade, listaPassageiros[msg.sender][id].brasileiro, listaPassageiros[msg.sender][id].categoria);
    }

    //funcao para lsitar todos os passageiros que o sender cadastrou
    function ver_todos_passageiros_do_sender() public view returns (
        string[] memory nomes,
        uint[] memory idades,
        bool[] memory brasileiros,
        Categoria[] memory categorias
    ) {
        uint quantidade = listaPassageiros[msg.sender].length;

        // Criar arrays do tamanho certo
        nomes = new string[](quantidade);
        idades = new uint[](quantidade);
        brasileiros = new bool[](quantidade);
        categorias = new Categoria[](quantidade);

        for (uint i = 0; i < quantidade; i++) {
            Passageiro memory p = listaPassageiros[msg.sender][i];
            nomes[i] = p.nome;
            idades[i] = p.idade;
            brasileiros[i] = p.brasileiro;
            categorias[i] = p.categoria;
        }

        return (nomes, idades, brasileiros, categorias);
    }








}