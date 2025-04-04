pragma solidity ^0.8.20;


//criando o smart contract

contract PassageiroEnum {

    //criar um enum de categorias

    enum Categoria {
        ADULTO_BRASILEIRO,
        JOVEM_BRASILEIRO,
        ESTRANGEIRO
    }

    //criar struct de passageiro, passango o tipo categoria em categoria

    struct Passageiro {
        string nome;
        uint idade;
        bool brasileiro;
        Categoria categoria;
    }

    //variavel de controle para ids
    uint public contadorID;


    //instanciar um mapping com id por passageiro

    mapping(uint => Passageiro) public passageiros;

    //criar funcao classificadora que recebe (nome, idade, se é brasileiro ou nao) e te cria um objeto struct já com a categoria classificada

    function classificarPassageiro (string memory _nome, uint _idade, bool _brasileiro) public{
        //condicionais para classificar a categoria do passageiro
        //definindo variavel categoria termporaria para salvar a categoria dele
        Categoria categoriaAtual;

        if (_brasileiro){
            if (_idade >=18){
                categoriaAtual = Categoria.ADULTO_BRASILEIRO;
            }
            else {
                if (_idade < 18){
                    categoriaAtual = Categoria.JOVEM_BRASILEIRO;
                }
            }
        }
        
         else {
            categoriaAtual = Categoria.ESTRANGEIRO;

        }

        //variavel de controle para ids
        contadorID ++;


        //criando o objeto passageiro com classificao, com base no que foi fornecido
        Passageiro memory passageiroAtual = Passageiro(_nome, _idade, _brasileiro, categoriaAtual);
        //colocando ele dentro do mapping
        passageiros[contadorID] = passageiroAtual;



        }


        //criar função para, a partir de um id, retorna os dados do passageiro (incluindo a classificacao)
        
        function verPassageiro (uint id) public view returns(string memory, uint, bool, Categoria){

        //criando um novo objeto passageiro
        Passageiro memory passageiroAtual = passageiros[id];

        //retornando os dados

        return (passageiroAtual.nome, passageiroAtual.idade, passageiroAtual.brasileiro, passageiroAtual.categoria);

        }




    }



    

















