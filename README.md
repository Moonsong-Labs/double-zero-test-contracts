# Double Zero test contracts

This repo contains a series of contracts meant to be use to test and showcase the [double zero framework](https://github.com/Moonsong-Labs/double-zero).

In order to deploy the contracts in this repo you are going to need [foundry zksync](https://foundry-book.zksync.io/getting-started/installation).

## Contracts

The contracts in this repo are variations of well known standards taking adventage of the privacy and access control
provided by double zero. Each contracts has comments in the source code explaining how they work and why they work.

At the moment we have 4 example contracts, that are variations of erc20 and erc721:


### PublicSelectionErc721

This is a variation of ERC721 where where the inventory of each user is private (secured by double zewro layer)
and then each user can select a sub set of their inventory to make public.

**source code:** [PublicSelectionErc721.sol](./src/PublicSelectionErc721.sol)
**permission template:** [erc721-public-selection.yaml](./permission-templates/erc721-public-selection.yaml)

### PublicScopedBalanceErc20

Variation of ERC20 where each user can select a threshold. And then anyone can check if the user has more or less balance
than that threshold.

**source code:** [PublicScopedBalanceErc20.sol](./src/PublicScopedBalanceErc20.sol)
**permission template:** [erc20-public-scoped-balance.yaml](./permission-templates/erc20-public-scoped-balance.yaml)


### ShareBalanceErc20

Variation of ERC20 where each user can select individual addresses to share their balance with.

**source code:** [ShareBalanceErc20.sol](./src/ShareBalanceErc20.sol)
**permission template:** [erc20-share-balance-with-users.yaml](./permission-templates/erc20-share-balance-with-users.yaml)


### ShareScopedBalanceErc20

Variation of ERC20 where each user can share their balance to specific addresses, but with an upper limit.


**source code:** [ShareScopedBalanceErc20.sol](./src/ShareScopedBalanceErc20.sol)
**permission template:** [erc20-share-scoped-balance.yaml](./permission-templates/erc20-share-scoped-balance.yaml)

## Deploy

You can deploy all the contracts by running:

``` bash
export RPC_URL=<your_rpc_url> # i.e.: http://localhost:3050
export VERIFIER_URL=<your_rpc_url> # i.e.: http://localhost:3070/contract_verification
 export PRIV_KEY=<your_depoyment_priv_key> # space at the beggining to avoid save pk in shell history.
./bash_scripts/deploy_tokens.sh
```

Once the contracts are deployed you can use the double zero explorer to check their status and interact with them.

## Double zero permissions

Each file inside the `/permission-templates` folder is a an example double zero configuration
for each contract in this repo:

- `erc20-public-scoped-balance.yaml` -> `PublicScopedBalanceErc20`.
- `erc20-public-scoped-balance.yaml` -> `PublicScopedBalanceErc20`.