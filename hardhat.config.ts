import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require("dotenv").config();

const MAIN_URL = process.env.BSC_MAIN_URL
const TEST_URL = process.env.BSC_TEST_URL
const BSC_MAIN_PRIVATE_KEY = process.env.BSC_MAIN_PRIVATE_KEY ?? ""
const BSC_TEST_PRIVATE_KEY = process.env.BSC_TEST_PRIVATE_KEY ?? ""

const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY

const config: HardhatUserConfig = {
  // solidity: "0.8.27",
  // solidity: "0.8.19",
  solidity: "0.8.21",
  networks: {
    bscMainnet: {
      url: MAIN_URL,
      accounts: [BSC_MAIN_PRIVATE_KEY],
      gasPrice: 20000000000
    },
    bscTestnet: {
      // url: TEST_URL,
      // accounts: [BSC_TEST_PRIVATE_KEY],
      // gasPrice: 20000000000
      url: TEST_URL,
      chainId: 97, //BNB testnet
      accounts: [BSC_TEST_PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY
  }
};

export default config;
