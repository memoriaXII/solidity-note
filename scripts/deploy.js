// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const FallbackSample = await hre.ethers.getContractFactory("FallbackSample");
  const fallbackSample = await FallbackSample.deploy();
  await fallbackSample.deployed();

  console.log("address", fallbackSample.address);

  const Greet = await hre.ethers.getContractFactory("Greet");
  const greet = await Greet.deploy();
  await greet.deployed();

  // const Greeter = await hre.ethers.getContractFactory("Greeter");
  // const greeter = await Greeter.deploy("greeting");
  // await greeter.deployed();

  // const Token = await hre.ethers.getContractFactory("Token");
  // const token = await Token.deploy();
  // await token.deployed();

  // const LEMToken = await hre.ethers.getContractFactory("LEMToken");
  // const lemToken = await LEMToken.deploy("Lemonde", "LEM");
  // await lemToken.deployed();

  // const QuizToken = await hre.ethers.getContractFactory("Quiz");
  // const quizToken = await QuizToken.deploy();
  // await quizToken.deployed();

  // console.log("token deployed to", token.address);
  // console.log("greeter deployed to", greeter.address);
  // console.log("lem deployed to", lemToken.address);
  // console.log("quic", quizToken.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
