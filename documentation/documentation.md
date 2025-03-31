### Solidity Programming Concepts

### Default Storage for Variables
- Variables defined outside of functions default to **storage**.

### Structs, Mappings, and Arrays
- **Structs**, **mappings**, and **arrays** must be given the `memory`, `calldata`, or `storage` keyword.

### Composability
- The ability of smart contracts to seamlessly interact with one another is called **composability**.

### Creating Smart Contracts from Other Smart Contracts
- You can create a new smart contract from within another using the `new` keyword:
    ```solidity
    SimpleStorage newSimpleStorage = new SimpleStorage();
    ```

### Importing Contracts
- Contracts can be imported from other `.sol` files using a **named import**:
    ```solidity
    import {SimpleStorage} from "./SimpleStorage.sol";
    ```
    *Note*: This imports a specific contract from the file, not the entire file.

### Inheritance in Solidity
- You can create a child contract that inherits the functionality of a base contract using the `is` keyword:
    ```solidity
    contract SecondContract is SimpleStorage {}
    ```

### Function Overrides
- To override a function in a derived contract:
    - The function in the base contract must be marked with the `virtual` keyword.
    - The function in the derived contract must use the `override` keyword.

    Example:
    ```solidity
    contract BaseContract {
        function someFunction() public virtual {}
    }

    contract DerivedContract is BaseContract {
        function someFunction() public override {}
    }
    ```

In Solidity, **memory** and **storage** are two distinct data locations used for handling variables. Understanding the difference between them is crucial for efficient smart contract development, especially given the gas costs associated with each.

### Memory

- **Temporary Storage**: Memory is a temporary storage area that is erased after the function execution ends. Variables stored in memory are only available during the execution of the function in which they are declared.
  
- **Volatile**: Since memory is volatile, any data stored here does not persist between external function calls or transactions. After the function completes execution, the memory is cleared.
  
- **Usage**: Typically used for variables that are needed temporarily, such as within functions. When dealing with complex data types like arrays or structs, you need to explicitly specify `memory` if you want the data to be stored in memory.

- **Cost**: Accessing and manipulating data in memory is cheaper in terms of gas compared to storage because it doesn't persist beyond the current function's execution.

- **Example**:
    ```solidity
    function doSomething(uint[] memory tempArray) public {
        // tempArray is stored in memory and will be discarded after function execution
    }
    ```

### Storage

- **Persistent Storage**: Storage is a persistent data location that retains data even after the execution of a function or the completion of a transaction. Variables stored in storage remain available for as long as the contract exists.

- **Non-Volatile**: Data in storage is not cleared after function execution; it persists between function calls and even across different transactions. This is where the contract's state variables are stored.

- **Usage**: Storage is used for state variables that need to be kept and used across different function calls or transactions. By default, all state variables (those declared outside of functions) are stored in storage.

- **Cost**: Storage operations are much more expensive in terms of gas than memory operations because storage data must be permanently recorded on the blockchain.

- **Example**:
    ```solidity
    uint[] public persistentArray;  // Stored in storage by default

    function updateArray(uint newValue) public {
        persistentArray.push(newValue);  // persistentArray is stored in storage
    }
    ```

### Key Differences

- **Persistence**:
  - **Memory**: Data is temporary and cleared after function execution.
  - **Storage**: Data is permanent and persists as long as the contract exists.

- **Gas Cost**:
  - **Memory**: Cheaper to read and write because it doesn't involve permanent storage.
  - **Storage**: More expensive due to the cost of permanently recording data on the blockchain.

- **Use Case**:
  - **Memory**: Ideal for temporary data manipulation within functions.
  - **Storage**: Used for storing contract state variables and data that need to be preserved.

## Useful Commands and Functions

### Convert Hexadecimal to Decimal

To convert a hexadecimal value to a decimal using `cast`:

```bash
cast --to-base "value" dec
```

**Example:**
```bash
cast --to-base 0x72ccc dec
```

### Using Private Keys in Different Environments

- **Development and Test Environment:**  
  You can use a `$PRIVATE_KEY` stored in a `.env` file.

- **Production Environment:**  
  In production, you should use the `--interactive` keyword or a keystore file encrypted with a password.

### Storing and Managing Private Keys with `cast`

1. **Create a Wallet (Interactive Mode):**

    ```bash
    cast wallet import defaultKey --interactive
    ```

    You will be prompted to enter your private key and password:

    ```
    Enter private key:
    Enter password: 
    ```

    Upon successful creation, you will see:
    
    ```
    `defaultKey` keystore was saved successfully. Address: 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266
    ```

2. **List Wallets:**

    To view the list of wallets:

    ```bash
    cast wallet list
    ```

    **Output Example:**
    ```
    defaultKey (Local)
    ```

### Sending a Transaction from the Command Line

To send a transaction using `cast`:

```bash
cast send 0x5FbDB2315678afecb367f032d93F642f64180aa3 "store(uint256)" 123 --rpc-url $RPC_URL --private-key $PRIVATE_KEY
```

### Reading Data from the Blockchain

1. **Call a Function on a Smart Contract:**

    ```bash
    cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "retrieve()"
    ```

    **Example Output:**
    ```
    0x000000000000000000000000000000000000000000000000000000000000007b
    ```

2. **Convert the Output:**

    To convert the hexadecimal output to decimal:

    ```bash
    cast --to-base 0x000000000000000000000000000000000000000000000000000000000000007b dec
    ```

## Deploying to Sepolia Testnet via Alchemy

1. **Setup Alchemy:**  
   Create an application in Alchemy and obtain the Sepolia RPC URL. Use a private key from your MetaMask browser extension.

2. **Deploy a Contract:**

    ```bash
    forge script script/DeploySimpleStorage.s.sol --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast
    ```

## Formatting Solidity Code

To format your Solidity code:

```bash
forge fmt
```

## Foundry-ZKSync

If you're working with ZKSync, you can install the `foundry-zksync` plugin. It functions similarly to Foundry, with some differences in the usage of `--zksync` and `--legacy` flags.

For more details, check out the [foundry-zksync GitHub repository](https://github.com/matter-labs/foundry-zksync).

## Additional Command: `forge create`

The `forge create` command is used to deploy contracts directly, and it works with various flags depending on your environment and requirements.

Deploying smart contracts locally using Foundry is straightforward. Below are the steps and commands you'll need to follow to deploy a contract on a local Ethereum network.

### 1. Set Up a Local Ethereum Node

First, you'll need a local Ethereum node to deploy your contract to. You can use a tool like **Anvil**, which is included with Foundry.

#### Using Anvil (Recommended with Foundry)

Anvil is a fast Ethereum development node that comes with Foundry.

- Start Anvil:

    ```bash
    anvil
    ```

    This command will spin up a local Ethereum node with a set of pre-funded accounts.

- Take note of the RPC URL (usually `http://127.0.0.1:8545`) and the private key of one of the accounts.

### 2. Write Your Smart Contract

Ensure your contract is located in the `src/` directory of your Foundry project. For example:

```solidity
// src/SimpleStorage.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    uint256 public storedData;

    function store(uint256 _data) public {
        storedData = _data;
    }

    function retrieve() public view returns (uint256) {
        return storedData;
    }
}
```

### 3. Create a Deployment Script

In the `script/` directory, create a script to deploy your contract:

```solidity
// script/DeploySimpleStorage.s.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/SimpleStorage.sol";

contract DeploySimpleStorage is Script {
    function run() external {
        vm.startBroadcast();
        new SimpleStorage();
        vm.stopBroadcast();
    }
}
```

### 4. Deploy the Contract Locally

To deploy your contract on the local Anvil node:

1. **Start Anvil** if you haven't already:
    ```bash
    anvil
    ```

2. **Deploy the contract:**

    ```bash
    forge script script/DeploySimpleStorage.s.sol --rpc-url http://127.0.0.1:8545 --private-key <YOUR_PRIVATE_KEY> --broadcast
    ```

    Replace `<YOUR_PRIVATE_KEY>` with the private key from one of the pre-funded accounts provided by Anvil.

### 5. Verify Deployment

After running the deployment script, you can verify that the contract was deployed by interacting with it:

- **Check the contract address:** The address of the deployed contract should be displayed in the terminal after deployment.

- **Interact with the contract using `cast`:**

    - **Store a value:**

        ```bash
        cast send <CONTRACT_ADDRESS> "store(uint256)" 123 --rpc-url http://127.0.0.1:8545 --private-key <YOUR_PRIVATE_KEY>
        ```

    - **Retrieve the stored value:**

        ```bash
        cast call <CONTRACT_ADDRESS> "retrieve()"
        ```

        The output should be the value you stored (in this case, `123`).

### 6. Optional: Running Tests

Foundry makes it easy to test your contracts locally:

```bash
forge test
```

This command runs the tests in your `test/` directory against your local node.

---
