# Double Zero test contracts

This repo contains a series of contracts meant to be use to test and showcase the [double zero framework](https://github.com/Moonsong-Labs/double-zero).

In order to deploy the contracts in this repo you are going to need [foundry zksync](https://foundry-book.zksync.io/getting-started/installation).

## Contracts

The contracts in this repo are variations of well known standards taking adventage of the privacy and access control
provided by double zero. Each contracts has comments in the source code explaining how they work and why they work.

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

Inside the `/permission-templates` folder there are several double zero permission files templates.
These are example permission restrictions for each contract to work as they re meant to work. These
can be modified to achieve different levels of privacy over each contract.