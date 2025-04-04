//criando contracto de depositar saldo
pragma solidity ^0.8.0;

contract depositarsaldo{
    //definindo as variaveis de estado
    mapping(address => uint) public saldos;
    uint public saldo;

    //depositando saldo
    function depositar () payable public {
        require(msg.value <= 10 ether, "voce nao pode depositar mais que isso");
        saldos[msg.sender] = saldos[msg.sender] + msg.value;


    }

    function ver_saldo () view public returns (uint) {
        return saldos[msg.sender];
    }

    

    
}