# Advanced Token Management with ERC-777 Smart Contract
This smart contract implements the ERC-777 token standard, offering enhanced functionalities beyond the ERC-20 standard.

## Key Features:

- **Transfer Operators:** Delegate token transfers to third-party accounts for streamlined management.
- **Sending & Receiving Hooks:** Leverage customizable hooks for actions before and after token transfers.
- **Increased Flexibility:** Explore a wider range of use cases compared to ERC-20 tokens.

## Benefits:

- **Enhanced Control:** Manage token transfers with more granular control through operators.
- **Customizable Behavior:** Implement custom logic for sending and receiving tokens using hooks.
- **Streamlined Operations:** Automate workflows and simplify complex token interactions.

## Getting Started:

### Installation and Deployment

1. Clone the repository:
   ```bash
   git clone https://github.com/mishraji874/ERC-777-Smarrt-Contract.git
2. Navigate to the project directory:
    ```bash
    cd ERC-777-Smart-Contract
3. Initialize Foundry and Forge:
    ```bash
    forge init
4. Create the ```.env``` file and paste the [Alchemy](https://www.alchemy.com/) api for the Sepolia Testnet and your Private Key from the Metamask.

5. Compile and deploy the smart contracts:

    If you want to deploy to the local network anvil then run this command:
    ```bash
    forge script script/DeployERC777Token.s.sol --rpc-url {LOCAL_RPC_URL} --private-key {PRIVATE_KEY}
    ```
    If you want to deploy to the Sepolia testnet then run this command:
    ```bash
    forge script script/DeployERC777Token.s.sol --rpc-url ${SEPOLIA_RPC_URL} --private-key ${PRIVATE_KEY}
### Running Tests

Run the automated tests for the smart contract:

```bash
forge test
```

## Configuration:

- The contract can be configured with the initial token supply and name.
- Implement custom logic within the provided hooks (optional).

## Additional Notes:

- This is a base implementation and can be extended to include additional features specific to your use case.
- Refer to the ERC777Token.sol and TestERC777Token.t.sol files for detailed contract logic and test cases.

## Security Considerations:

- Smart contract audits by reputable security firms are highly recommended.
- Carefully review the implementation of transfer operators and hooks to ensure secure interactions.

## ERC-777 Advantages:

This ERC-777 smart contract provides a powerful foundation for building innovative tokenized applications with advanced functionalities beyond the limitations of ERC-20.