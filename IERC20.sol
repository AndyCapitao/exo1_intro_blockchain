// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;


// Définition du standard IERC20, définition du standard qui va être utilisé par les tokens
interface IERC20 {
    function totalSupply() external view returns (uint256); // Retourne le nombre total de tokens existants
    function balanceOf(address account) external view returns (uint256); // Retourne le solde d'une adresse donnée
    function transfer(address to, uint256 amount) external returns (bool); // On envoi des tokens à une autre adresse

    function allowance(address owner, address spender) // Retourne combien on autorise à être dépenser
        external
        view
        returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);  // Donne une autorisation pour pouvoir dépenser des tokens

    function transferFrom(address sender, address recipient, uint256 amount) // Permet à une autre adresse d'envoyer des tokens appartenant à celui qui envoie
        external
        returns (bool);
}
