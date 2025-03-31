## Blockchain Technology Overview

### Core Concepts

**Oracle - Chainlink**  
An Oracle is a service that allows smart contracts to interact with off-chain data. Chainlink is a decentralized oracle network that enables smart contracts to securely connect to external data sources, APIs, and payment systems.

**Smart Contracts = Hybrid Smart Contracts**  
Hybrid smart contracts combine on-chain and off-chain components to create more versatile and practical decentralized applications (DApps). They allow agreements that are partly executed on the blockchain and partly handled off-chain, where necessary.

### Layered Blockchain Architecture

**Layer 1 (L1)**  
- **Description**: The base layer or settlement layer blockchain. This is where the primary state of the blockchain resides, and consensus is achieved.
  
**Layer 2 (L2)**  
- **Description**: L2 solutions are built on top of L1 to improve scalability by handling transactions off-chain while still benefiting from the security of L1.

### Layer 2 Solutions

**Optimistic Rollups**  
- **Mechanism**: Assume transactions are legitimate by default. Operators propose what they believe to be the valid state of the rollup chain.
- **Challenge Period**: A period where other operators can challenge the rollup transaction if they believe it's invalid.
- **Examples**: Arbitrum, Optimism

**Zero Knowledge (ZK) Rollups**  
- **Mechanism**: Use ZK proofs to verify the correctness of transactions. These proofs involve two participants:
  - **Prover**: The entity that tries to prove they know the answer to a problem (e.g., an Operator).
  - **Verifier**: The entity that verifies the prover's knowledge (e.g., an L1 Contract).
  - **Witness**: The answer being proven.
- **Examples**: ZKSync, Polygon’s ZK EVMs

### DApp (Decentralized Application)

- **Definition**: A decentralized application or protocol that operates as a smart contract on the blockchain.
- **Characteristics**: DApps are trust-minimized agreements that are:
  - **Immutable**: Cannot be altered once deployed.
  - **Decentralized**: No central point of control.
  - **Transparent**: Operations and rules are visible to all participants.

### Key Concepts in Blockchain

**Consensus Algorithm**  
- **Nakamoto Consensus**: A combination of Proof of Work (PoW) and the longest chain rule to achieve consensus on the state of the blockchain.

**Attacks**  
- **Sybil Attack**: Where an attacker creates multiple identities to gain a disproportionate influence over the network.
- **51% Attack**: Where an entity gains control of more than 50% of the network's computing power, potentially leading to double-spending.

### Rollups: A Scaling Solution

**Definition**  
Rollups aggregate multiple transactions into a single one, which is then posted to the L1 blockchain. This enhances scalability by reducing the amount of data that needs to be processed on L1.

### Blockchain Trilemma

The blockchain trilemma is the challenge of balancing the following three aspects:
- **Security**
- **Decentralization**
- **Scalability**

Optimistic and ZK rollups attempt to address this trilemma by providing scalability without compromising security and decentralization.

### ZK Rollup Stages: Towards Decentralization

ZK Rollups progress through stages of maturity, moving towards complete decentralization:

1. **Stage 0: Full Training Wheels**
   - **Characteristics**: Centralized management, a security council for decision-making, open-source software for data availability, and a ~7-day exit period for users.
  
2. **Stage 1: Enhanced Rollup Governance**
   - **Characteristics**: Governed by smart contracts, decentralized fraud/validity proof systems, and a >7-day exit period.

3. **Stage 2: No Training Wheels**
   - **Characteristics**: Completely decentralized, managed by smart contracts, and features a fully decentralized and permissionless fraud/validity proof system. Users have ample time to exit, and errors are adjudicated on-chain with user protection against governance attacks.

### Risk Analysis for Rollups

- **Data Availability**: Can the L2 state be reconstructed from the data submitted to L1? Has the state difference been published?
- **State Validation**: Have the state differences been validated as correct?
- **Sequencer Status**: Can transactions be pushed to the sequencer?
- **Proposer Status**: Can new states be proposed/pushed to the rollup?
- **Exit Window**: How long do users have to exit the system?

### Bridging Between Blockchains

- **Locking and Unlocking**: Assets are locked on one chain and unlocked on another.
- **Minting and Burning**: New tokens are minted on the destination chain, and the corresponding tokens are burned on the source chain.

## Ethereum Virtual Machine (EVM) - Read and Write Operations

### Write & Read Locations
- **Stack**
- **Memory**: Temporary variable that can be modified.
- **Storage**: Permanent variable that can be modified.
- **Transient Storage**
- **Calldata**: Temporary variable that can't be modified.
- **Code**
- **Returndata**

### Write (Not Read)
- **Logs**

### Read (Not Write)
- **Transaction Data** (and Blobhash)
- **Chain Data**
- **Gas Data**
- **Program Counter**
- **Other**
