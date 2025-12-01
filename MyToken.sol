// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "./IERC20.sol"; // On importe le fichier IERC20.sol

contract MyToken is IERC20 {
//On déclare les infos du token
    string public tokenAndy;
    string public tokenSymbol;
    uint8 public tokenDecimals;

    uint256 private tokenSupply; // Quantité totale de tokens

    mapping(address => uint256) public balances; // Solde des adresses
    mapping(address => mapping(address => uint256)) public allowances; //Autorisations pour le token nécessaire pour que ce soit un ERC-20 aide via https://ethereum.org/fr/developers/docs/standards/tokens/erc-20/ + forums
    // impact Approve, Allowance et transferFrom

    //Normes ERC-20
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // On définie le constructeur
    constructor() {
        tokenAndy = "TokenAndy";
        tokenSymbol = "TA";
        tokenDecimals = 18;

        uint256 supply = 1000000 * 10 ** tokenDecimals;  // Création de 1000000 de tokens
        tokenSupply = supply; // Définition du total supply
        balances[msg.sender] = supply; // On attribue ensuite les tokens au créateur du contrat

        emit Transfer(address(0), msg.sender, supply);
    }
    // Retourne le total de tokens existants
    function totalSupply() external view override returns (uint256) {
        return tokenSupply;
    }
    // Retourne le solde d'une adresse
    function balanceOf(address account) external view override returns (uint256) {
        return balances[account];
    }
     // Transfert depuis msg.sender
    function transfer(address to, uint256 amount) external override returns (bool) {
        require(to != address(0));
        require(balances[msg.sender] >= amount);

        // Débit et crédit
        balances[msg.sender] -= amount;
        balances[to] += amount;

        emit Transfer(msg.sender, to, amount);
        return true;
    }
    // Retourne l'allowance enregistrée
    function allowance(address owner, address spender) external view override returns (uint256) {
        return allowances[owner][spender];
    }
    // Autorise à dépenser un montant donné
    function approve(address spender, uint256 amount) external override returns (bool) {
        require(spender != address(0));

        allowances[msg.sender][spender] = amount;

        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external override returns (bool) {
        require(to != address(0));
        require(balances[from] >= amount);
        require(allowances[from][msg.sender] >= amount);

        // Mise à jour des soldes
        balances[from] -= amount;
        balances[to] += amount;
        allowances[from][msg.sender] -= amount; // Réduction de l'allowance

        emit Transfer(from, to, amount);
        return true;
    }
}
