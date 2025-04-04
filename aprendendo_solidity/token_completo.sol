// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Importando as implementações padrões do OpenZeppelin:
// ERC20Burnable: Permite que tokens sejam queimados (burn) pelo dono ou por quem possui autorização.
// Ownable: Proporciona um controle de acesso, definindo o dono do contrato que pode executar funções restritas.
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Contrato AdvancedToken: Este contrato é um exemplo completo com diversas operações sobre tokens.
contract AdvancedToken is ERC20Burnable, Ownable {
    
    // Variável de controle para registrar a quantidade de tokens mintados diretamente para o contrato
    uint public totalMintedFromContract;

    /*
      CONSTRUTOR:
      - Inicializa o token com nome "AdvancedToken" e símbolo "ATK".
      - Mint inicial de 100 tokens para o endereço que implanta o contrato (owner).
      - Inicializa a variável de controle de mintados.
    */
    constructor() ERC20("AdvancedToken", "ATK") {
        // Mint inicial para o dono (owner) do contrato
        // Multiplicamos por 10 elevado aos decimais definidos (padrão: 18) para ajustar a unidade
        _mint(msg.sender, 100 * 10 ** decimals());
        // Inicializando o contador de tokens mintados via funções do contrato
        totalMintedFromContract = 0;
    }

    /*
      MINT PARA O CONTRATO:
      Função exclusiva do dono (owner) para mintar tokens e enviar para o próprio contrato.
      Essa função pode ser utilizada para armazenar tokens no contrato, que poderão ser enviados posteriormente.
      - amount: quantidade de tokens (em unidades inteiras) a serem mintados.
    */
    function mintToContract(uint amount) external onlyOwner {
        // Converte a quantidade para as menores unidades (considerando os decimais)
        uint mintAmount = amount * 10 ** decimals();
        // Mintando os tokens para o endereço do próprio contrato
        _mint(address(this), mintAmount);
        // Atualiza a variável de controle somando a quantidade mintada
        totalMintedFromContract += mintAmount;
    }

    /*
      MINT DIRETO PARA UM ENDEREÇO:
      Função para mintar novos tokens e enviá-los diretamente para um endereço específico.
      - recipient: endereço que receberá os tokens.
      - amount: quantidade de tokens (em unidades inteiras) a serem mintados.
      Somente o dono pode chamar esta função.
    */
    function mintToAddress(address recipient, uint amount) external onlyOwner {
        // Converte a quantidade para a unidade correta
        uint mintAmount = amount * 10 ** decimals();
        // Mintando os tokens para o endereço especificado
        _mint(recipient, mintAmount);
    }

    /*
      TRANSFERÊNCIA DE TOKENS DO CONTRATO:
      Função para enviar tokens que estão armazenados no contrato para um endereço de destinatário.
      Apenas o dono (owner) pode executar esta função para evitar manipulação indevida.
      - recipient: endereço para onde os tokens serão enviados.
      - amount: quantidade de tokens (em unidades inteiras) a serem transferidos.
    */
    function transferFromContract(address recipient, uint amount) external onlyOwner {
        uint transferAmount = amount * 10 ** decimals();
        // Verifica se o contrato possui tokens suficientes
        require(balanceOf(address(this)) >= transferAmount, "Nao ha tokens suficientes no contrato.");
        // Transfere os tokens do contrato para o destinatario
        _transfer(address(this), recipient, transferAmount);
        // Atualiza a variável de controle, se os tokens transferidos forem provenientes dos mintados via contrato
        if (totalMintedFromContract >= transferAmount) {
            totalMintedFromContract -= transferAmount;
        }
    }

    /*
      QUEIMA DE TOKENS DO CONTRATO:
      Permite que o dono queime tokens que estejam armazenados no próprio contrato.
      Essa função é útil para reduzir o supply de tokens armazenados.
      - amount: quantidade de tokens (em unidades inteiras) a serem queimados.
    */
    function burnFromContract(uint amount) external onlyOwner {
        uint burnAmount = amount * 10 ** decimals();
        // Verifica se há tokens suficientes no contrato para a queima
        require(balanceOf(address(this)) >= burnAmount, "Nao ha tokens suficientes no contrato para queima.");
        // Queima os tokens do endereço do contrato
        _burn(address(this), burnAmount);
        // Atualiza a variável de controle dos tokens mintados via contrato
        totalMintedFromContract -= burnAmount;
    }

    /*
      TRANSFERÊNCIA ENTRE USUÁRIOS UTILIZANDO ALLOWANCE:
      Esta função demonstra o uso manual do mecanismo de allowance (aprovação) para transferir tokens de um usuário para outro.
      - from: endereço do usuário que possui os tokens e autorizou a transferência.
      - to: endereço do destinatário que receberá os tokens.
      - amount: quantidade de tokens (em unidades inteiras) a serem transferidos.
      Observação: A função padrão transferFrom já implementa essa lógica, mas este exemplo mostra como funcionaria "por debaixo dos panos".
    */
    function transferFromUser(address from, address to, uint amount) external {
        uint transferAmount = amount * 10 ** decimals();
        // Verifica se o chamador (msg.sender) tem permissão para transferir os tokens do endereço 'from'
        uint currentAllowance = allowance(from, msg.sender);
        require(currentAllowance >= transferAmount, "Transfer amount exceeds allowance");
        
        // Executa a transferência utilizando a função interna _transfer
        _transfer(from, to, transferAmount);
        
        // Atualiza a permissão (allowance) reduzindo a quantidade transferida.
        // OBS: Na implementação padrão de transferFrom, essa redução já é feita automaticamente.
        _approve(from, msg.sender, currentAllowance - transferAmount);
    }

    /*
      QUEIMA DE TOKENS DE UM USUÁRIO VIA ALLOWANCE:
      Permite ao dono queime tokens de um endereço específico, desde que este endereço tenha concedido a devida autorização (allowance).
      - account: endereço do usuário que terá seus tokens queimados.
      - amount: quantidade de tokens (em unidades inteiras) a serem queimados.
      Essa função utiliza o método burnFrom do ERC20Burnable, que já verifica a permissão.
    */
    function burnFromUser(address account, uint amount) external onlyOwner {
        uint burnAmount = amount * 10 ** decimals();
        // Chama a função burnFrom do ERC20Burnable, que desconta a allowance e queima os tokens do account
        burnFrom(account, burnAmount);
    }

    /*
      FUNÇÃO DE CONSULTA:
      Retorna a quantidade de tokens que estão armazenados no endereço do contrato.
      Pode ser usada para verificar quantos tokens estão disponíveis para transferência ou queima.
    */
    function tokensInContract() external view returns (uint) {
        return balanceOf(address(this));
    }

    /*
      OBSERVAÇÕES IMPORTANTES:
      - As funções approve, transfer e transferFrom padrão já estão implementadas na ERC20 do OpenZeppelin, 
        então não é necessário reimplementá-las. Estas funções permitem:
          • approve: autorizar que outro endereço gaste tokens em seu nome.
          • transfer: enviar tokens para outro endereço.
          • transferFrom: transferir tokens de um endereço para outro, utilizando a autorização concedida por approve.
      - A função burn (para queimar tokens do próprio chamador) também está herdada do ERC20Burnable.
      - Todos os cálculos de quantidades levam em conta os "decimals" definidos, garantindo a precisão dos valores.
      - O uso de "require" garante que as operações só ocorram se as condições necessárias forem atendidas, protegendo
        contra comportamentos indesejados ou ataques.
    */
}
