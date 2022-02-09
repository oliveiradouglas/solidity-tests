// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.7.0 < 0.9.0;

contract Bolao {
    address private gerente;
    address[] private jogadores;
    address payable private vencedor;
    
    constructor() {
        gerente = msg.sender;
    }

    function entrar() public payable {
        require(msg.value == .1 ether);
        jogadores.push(msg.sender);
    }

    function descobrirGanhador() public restricted {
        uint index = randomico() % jogadores.length;
        uint160 enderedoVencedor = uint160(jogadores[index]);
        vencedor = payable(address(enderedoVencedor));
        uint saldoContrato = address(this).balance;
        vencedor.transfer(saldoContrato);
        vencedor = payable(address(uint160(0x0)));
    }

    modifier restricted() {
        require(msg.sender == gerente);
        _;
    }

    function randomico() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, jogadores)));
    }

    function getSaldo() public view returns (uint) {
        return uint(address(this).balance);
    }
}