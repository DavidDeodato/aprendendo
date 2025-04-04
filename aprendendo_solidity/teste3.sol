// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ConversaMapping {
    // Mapping: cada endereço tem sua lista de mensagens (array de string)
    mapping(address => string[]) public mensagens;

    // Envia uma mensagem (salva na lista do remetente)
    function set_mensagem(string memory _mensagem) public {
        mensagens[msg.sender].push(_mensagem);
    }

    // Retorna todas as mensagens do remetente
    function ver_minhas_mensagens() public view returns (string[] memory) {
        return mensagens[msg.sender];
    }

    // Retorna as mensagens de um endereço específico (caso queira ver de outro)
    function ver_mensagem(address usuario) public view returns (string[] memory) {
        return mensagens[usuario];
    }
}
