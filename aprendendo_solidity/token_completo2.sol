// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

/**
 * @title AdvancedToken
 * @dev Token ERC20 completo com funcionalidades avançadas:
 * - Mint e Burn
 * - Transferências comuns e utilizando Allowance
 * - Pausabilidade (parar todas as operações em caso de emergência)
 * - Blacklist (bloquear endereços maliciosos)
 * - Eventos para auditoria
 */
contract AdvancedToken is ERC20Burnable, Ownable, Pausable {
    mapping(address => bool) private _blacklist;
    event BlacklistUpdated(address indexed account, bool isBlacklisted);

    constructor() ERC20("AdvancedToken", "ATK") {
        _mint(msg.sender, 1000000 * 10 ** decimals()); // Mint inicial
    }

    // Modifier para impedir ações de endereços bloqueados
    modifier notBlacklisted(address account) {
        require(!_blacklist[account], "Endereco bloqueado");
        _;
    }

    // Adiciona ou remove um endereço da blacklist
    function updateBlacklist(address account, bool isBlacklisted) external onlyOwner {
        _blacklist[account] = isBlacklisted;
        emit BlacklistUpdated(account, isBlacklisted);
    }

    // Pausar todas as transações
    function pause() external onlyOwner {
        _pause();
    }

    // Retomar todas as transações
    function unpause() external onlyOwner {
        _unpause();
    }

    // Mint para um endereço específico
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    // Transferência bloqueando endereços na blacklist e pausando o contrato
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal override whenNotPaused notBlacklisted(from) notBlacklisted(to) {
        super._beforeTokenTransfer(from, to, amount);
    }
}
