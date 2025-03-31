# Foundry Installation and Usage Guide

**Foundry** is a development framework written in Solidity, commonly used for smart contract development and testing.

## Installation Steps

1. **Download Foundry:**
    ```bash
    curl -L https://foundry.paradigm.xyz | bash
    ```

2. **Source `.bashrc`:**
    ```bash
    source /home/$username/.bashrc
    ```
   Replace `$username` with your actual username.

3. **Install Foundry:**
    ```bash
    foundryup
    ```

## Directory Structure in Foundry

- **`src/`** - This directory is where the Solidity contracts are stored.
- **`test/`** - This directory is where the tests for the contracts are stored.
- **`script/`** - This directory is where deployment and script files are stored. (Note: The original statement incorrectly mentioned tests.)
