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
