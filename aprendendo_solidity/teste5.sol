pragma solidity ^0.8.0;

contract lojas{

    //definindo variaveis de sistema
    mapping(uint => string) public produtos;

    //lista de produtos por id
    uint[] public lista_ids_produtos;

    // definindo o dono da loja
    address public dono_loja;

    constructor(){
        dono_loja = msg.sender;
    }

    function cadastrar_produtos (uint id, string memory produto) public {
        //verificando se é o dono
        require(msg.sender == dono_loja, "voce nao e o dono da loja garai, pode nao");
        // adicioanndo o produto dentro do mapping
        produtos[id] = produto;
        // adicionando o novo id aos ids dos produtos
        lista_ids_produtos.push(id);

    }


    //funcao para ver todos os produtos

    function ver_todos_produtos () view public returns (uint[] memory){
        //listando todos os produtos 
        return (lista_ids_produtos);
    }


    function ver_um_produto (uint id) view public returns(string memory){
        return produtos[id];
    }




}