## Useful Commands and Functions

# Initialise a Foundry Project
```bash
forge --init 
```

# forge - used for compiling, testing, and deploying smart contracts.
# cast - used for interacting with the blockchain and performing various operations.
# anvil - used for running a local Ethereum node.
# chisel - used for quick calculations and data manipulation.

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