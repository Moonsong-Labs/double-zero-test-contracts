#!/bin/env sh

set -e
set -o xtrace

if [[ -z "${PRIV_KEY}" ]]; then
  echo "missing PRIV_KEY env var"
  exit 1
fi

if [[ -z "${RPC_URL}" ]]; then
  echo "missing RPC_URL env var"
  exit 1
fi

if [[ -z "${VERIFIER_URL}" ]]; then
  echo "missing VERIFIER_URL env var"
  exit 1
fi

forge create --zksync \
    --rpc-url $RPC_URL \
    --private-key $PRIV_KEY \
    --verify \
    --verifier zksync \
    --verifier-url VERIFIER_URL \
    src/PublicScopedBalanceErc20.sol:PublicScopedBalanceErc20 \
    --constructor-args "PublicScopedBalanceErc20" "PEB20";

forge create --zksync \
    --rpc-url $RPC_URL \
    --private-key $PRIV_KEY \
    --verify \
    --verifier zksync \
    --verifier-url VERIFIER_URL \
    src/ShareBalanceErc20.sol:ShareBalanceErc20 \
    --constructor-args "ShareBalanceErc20" "SB20";

forge create --zksync \
    --rpc-url $RPC_URL \
    --private-key $PRIV_KEY \
    --verify \
    --verifier zksync \
    --verifier-url VERIFIER_URL \
    src/ShareScopedBalanceErc20.sol:ShareScopedBalanceErc20 \
    --constructor-args "ShareScopedBalanceErc20" "SSBE20";


forge create --zksync \
    --rpc-url $RPC_URL \
    --private-key $PRIV_KEY \
    --verify \
    --verifier zksync \
    --verifier-url VERIFIER_URL \
    src/PublicSelectionErc721.sol:PublicSelectionErc721 \
    --constructor-args "PublicSelectionErc721" "PC721";

 
