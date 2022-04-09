import "./App.css";
import { useState } from "react";
import { ethers } from "ethers";
import Greeter from "./artifacts/contracts/Greeter.sol/Greeter.json";
import Token from "./artifacts/contracts/Token.sol/Token.json";
import LEM from "./artifacts/contracts/LEMToken.sol/LEMToken.json";
import Fallback from "./artifacts/contracts/FallbackSample.sol/FallbackSample.json";

const greeterAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
const tokenAddress = "0x5FC8d32690cc91D4c39d9d3abcBD16989F875707";

const lemAddress = "0x68B1D87F95878fE05B998F19b66F4baba5De1aed";

const fallbackSampleAddress = "0x610178dA211FEF7D417bC0e6FeD39F05609AD788";

//0x70997970C51812dc3A010C7d01b50e0d17dc79C8

function App() {
  const [greeting, setGreetingValue] = useState("");
  const [userAccount, setUserAccount] = useState("");
  const [amount, setAmount] = useState(0);

  async function requestAccount() {
    await window.ethereum.request({ method: "eth_requestAccounts" });
  }

  async function fetchGreeting() {
    if (typeof window.ethereum !== "undefined") {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      console.log({ provider });
      const contract = new ethers.Contract(
        greeterAddress,
        Greeter.abi,
        provider
      );
      try {
        const data = await contract.greet();
        console.log("data: ", data);
      } catch (err) {
        console.log("Error: ", err);
      }
    }
  }

  const receiveMoney = async () => {
    if (typeof window.ethereum !== "undefined") {
      const [account] = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const contract = new ethers.Contract(
        fallbackSampleAddress,
        Fallback.abi,
        signer
      );
      const transaction = await contract.receiveMoney();
      await transaction.wait();
      console.log(transaction, "trigger");
    }
  };

  async function getBalance() {
    if (typeof window.ethereum !== "undefined") {
      const [account] = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const contract = new ethers.Contract(tokenAddress, Token.abi, provider);
      //to get the token balance from the contract
      const balance = await contract.balanceOf(account);
      console.log("Balance: ", contract, balance.toString());
    }
  }

  const getLEMBalance = async () => {
    if (typeof window.ethereum !== undefined) {
      const [account] = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const contract = new ethers.Contract(lemAddress, LEM.abi, provider);
      const balance = await contract.balanceOf(account);

      console.log(balance.toString(), contract, "contract");
    }
  };

  async function setGreeting() {
    if (!greeting) return;
    if (typeof window.ethereum !== "undefined") {
      await requestAccount();
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      console.log({ provider });
      const signer = provider.getSigner();
      console.log(signer, "signer");
      const contract = new ethers.Contract(greeterAddress, Greeter.abi, signer);
      const transaction = await contract.setGreeting(greeting);
      await transaction.wait();
      fetchGreeting();
    }
  }

  async function sendCoins() {
    if (typeof window.ethereum !== "undefined") {
      await requestAccount();
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      // to sign the transaction so we need to create signature on the blockchain
      const contract = new ethers.Contract(tokenAddress, Token.abi, signer);
      const transaction = await contract.transfer(userAccount, amount);
      await transaction.wait();
      console.log(`${amount} Coins successfully sent to ${userAccount}`);

      // props.binamonBoosterContract.methods
      //   .openBooster(params.id)
      //   .send(
      //     { from: props.walletAddress, gas: 1000000 },
      //     async (err, txHash) => {
      //       if (err) {
      //         props.setMessages({ error: err.message, success: "" });
      //         return;
      //       }
      //       props.setMessages({
      //         error: "",
      //         success: "Booster opening is in progress...",
      //       });
      //       await watchTransaction(txHash);
      //       props.setMessages({ error: "", success: "" });
      //     }
      //   );
    }
  }

  return (
    <div className="App">
      <header className="App-header">
        <button onClick={fetchGreeting}>Fetch Greeting</button>
        <button onClick={setGreeting}>Set Greeting</button>
        <input
          onChange={(e) => setGreetingValue(e.target.value)}
          placeholder="Set greeting"
        />

        <br />
        <button onClick={receiveMoney}>receiveMoney</button>
        <button onClick={getBalance}>Get Balance</button>
        <button onClick={getLEMBalance}>Get LEM balance</button>
        <button onClick={sendCoins}>Send Coins</button>
        <input
          onChange={(e) => setUserAccount(e.target.value)}
          placeholder="Account ID"
        />
        <input
          onChange={(e) => setAmount(e.target.value)}
          placeholder="Amount"
        />
      </header>
    </div>
  );
}

export default App;
