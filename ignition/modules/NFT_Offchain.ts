// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
require("dotenv").config();

// const TEN_MILLION_TOKENS: bigint = 10_000_000n * (10n ** 18n);

const NFT_offChainModule = buildModule("AirdropToken", (m) => {

  const tokenName = m.getParameter("tokenName", "NFT_Offchain");
  const tokenSymbol = m.getParameter("tokenSymbol", "NFT_O");
//   const totalSupply = m.getParameter("totalSupply", TEN_MILLION_TOKENS);

  // Despliegue del contrato AirdropToken
//   const airdropToken = m.contract("AirdropToken", [tokenName, tokenSymbol, totalSupply]);
  const NFT_offChain = m.contract("AirdropToken", [tokenName, tokenSymbol]);

  return { NFT_offChain };
});

export default NFT_offChainModule;
//npx hardhat run scripts/Deploy.js --network bnbTestnet
//npx hardhat verify                --network bnbTestnet ${PONER LA ADDRESS}
