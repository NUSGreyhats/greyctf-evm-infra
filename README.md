# GreyCTF Blockchain Infrastructure

Forked from https://github.com/Social-Engineering-Experts/SEETF-2023-Public/blob/main/challs/seetf-evm-infra.

Makes use of [anvil](https://book.getfoundry.sh/reference/anvil/) from the foundry toolchain to create blockchain nodes.

## Configuration Reference

| Name                      | Default                       | Description                                                                       |
| ------------------------- | ----------------------------- | --------------------------------------------------------------------------------- |
| `FLAG`                    | `grey{TEST_FLAG}`             | Challenge flag to be given on solving the challenge                               |
| `PORT`                    | `5000`                        | Port number to bind to (for the challenge deployer service)                       |
| `HTTP_PORT`               | `8545`                        | Port number to bind to (to host the web3 interface)                               |
| `PER_SOURCE`              | `4`                           | Maximum concurrent connections for each IP                                        |
| `CPS_RATE`                | `200`                         | Maximum connections per second                                                    |
| `CPS_DELAY`               | `5`                           | Service timeout when CPS_RATE has been hit                                        |
| `RLIMIT_CPU`              | `5`                           | Maximum number of CPU seconds that the service may use                            |
| `CONTRACT_DEPLOY_ARGS`    | `""`                          | Arguments that will be used in deploying the Setup contract                       |
| `CONTRACT_DEPLOY_VALUE`   | `0`                           | Amount of Ether to deploy the Setup contract with                                 |
| `PLAYER_VALUE`            | `10`                          | Amount of Ether to grant to the player                                            |
| `ETH_RPC_URL`             | `https://eth.llamarpc.com`    | Ethereum chain that will be forked                                                |
| `RPC_KILL_TIMEOUT`        | `3600`                        | Amount of seconds until Anvil node is terminated                                  |

## Setting up the Image

```
docker build ./eth_container -t grey.ctf/evm-infra
```

## Challenge Deployment

Using the built docker image, we can easily deploy on-demand blockchain challenges, with just the smart contract code.

```dockerfile
FROM grey.ctf/evm-infra

COPY contracts/ /tmp/contracts/
```

The `contracts/` folder **MUST** contain a file `Setup.sol`, with a solidity contract called "Setup" that has the `isSolved()` function.

This contract will be deployed on creation of the ethereum node, and will be responsible for:

- Deploying any additional challenge contracts
- Checking if the challenge has been solved by returning a bool on the `isSolved()` function

## TODO

- [X] **get the image build to work**
- [ ] add a config to ask for a redpwn proof of work (prevent DoS but idk if necessary)
- [X] make EVM node timeout configurable (default now is 1 hour)
- [ ] make SOLC version configurable
- [ ] update requirements.txt
- [ ] add github workflows to deploy docker image
- [ ] add github workflows to test that docker image works
