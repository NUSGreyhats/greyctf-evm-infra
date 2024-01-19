# GreyCTF Blockchain Infrastructure

forked from https://github.com/Social-Engineering-Experts/SEETF-2023-Public/blob/main/challs/seetf-evm-infra

## Configuration Reference

| Name                | Default             | Description                                                                                                                 |
| ------------------- | ------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `FLAG`         | `grey{TEST_FLAG}`                | Challenge flag to be given on solving the challenge |
| `PORT`         | `5000`               |   Port number to bind to |
| 


## Setting up the Image

```
docker-compose up --build -d
```

## Challenge Deployment

Using the built docker image, we can easily deploy on-demand blockchain challenges, with just the smart contract code.

```dockerfile
# this doesn't work yet, still W.I.P, but here's a vision of the end product
FROM XXX

# all contracts to be compiled MUST be copied into "/tmp/contracts"
COPY contracts/ /tmp/contracts/
```

The `contracts/` folder **MUST** contain a solidity contract called "Setup" with the `isSolved()` function.

This contract will be deployed on creation of the ethereum node, and will be responsible for:

- Deploying any additional challenge contracts
- Checking if the challenge has been solved by returning a bool on the `isSolved()` function

## TODO

- [ ] **get the image build to work**
- [ ] add an config to get a proof of work 
- [ ] make EVM node timeout configurable
- [ ] make SOLC version configurable
- [ ] update requirements.txt
- [ ] add github workflows to deploy docker image
- [ ] add github workflows to test that docker image works
