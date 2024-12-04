#!/bin/env sh

set -e
set -o xtrace

forge create --zksync \
    --rpc-url http://localhost:3050 \
    --private-key 0x87ce66d9f787696d21af61750c1c3310099f27fb7e7259a193a8c514293a7c0c \
    --verify \
    --verifier zksync \
    --verifier-url http://localhost:3070/contract_verification \
    src/PublicScopedBalanceErc20.sol:PublicScopedBalanceErc20 \
    --constructor-args "PublicScopedBalanceErc20-posta" "PEB20P";

forge create --zksync \
    --rpc-url http://localhost:3050 \
    --private-key 0x87ce66d9f787696d21af61750c1c3310099f27fb7e7259a193a8c514293a7c0c \
    --verify \
    --verifier zksync \
    --verifier-url http://localhost:3070/contract_verification \
    src/ShareBalanceErc20.sol:ShareBalanceErc20 \
    --constructor-args "ShareBalanceErc20-posta" "SB20P";

forge create --zksync \
    --rpc-url http://localhost:3050 \
    --private-key 0x87ce66d9f787696d21af61750c1c3310099f27fb7e7259a193a8c514293a7c0c \
    --verify \
    --verifier zksync \
    --verifier-url http://localhost:3070/contract_verification \
    src/ShareScopedBalanceErc20.sol:ShareScopedBalanceErc20 \
    --constructor-args "ShareScopedBalanceErc20-posta" "SSBE20P";


forge create --zksync \
    --rpc-url http://localhost:3050 \
    --private-key 0x87ce66d9f787696d21af61750c1c3310099f27fb7e7259a193a8c514293a7c0c \
    --verify \
    --verifier zksync \
    --verifier-url http://localhost:3070/contract_verification \
    src/PublicSelectionErc721.sol:PublicSelectionErc721 \
    --constructor-args "PublicSelectionErc721-posta" "PC721P";

 
