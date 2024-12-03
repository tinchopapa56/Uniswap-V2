// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
require("dotenv").config();

const TEN_MILLION_TOKENS: bigint = 10_000_000n * (10n ** 18n);

const AirdropTokenModule = buildModule("AirdropToken", (m) => {
  // Parámetros configurables
  const tokenName = m.getParameter("tokenName", "Airdrop Token");
  const tokenSymbol = m.getParameter("tokenSymbol", "ADT");
  const totalSupply = m.getParameter("totalSupply", TEN_MILLION_TOKENS);

  // Despliegue del contrato AirdropToken
  const airdropToken = m.contract("AirdropToken", [tokenName, tokenSymbol, totalSupply]);

  return { airdropToken };
});

export default AirdropTokenModule;
//npx hardhat run scripts/Deploy.js --network bnbTestnet
//npx hardhat verify                --network bnbTestnet ${PONER LA ADDRESS}
