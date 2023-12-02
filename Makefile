-include .env

.PHONY: all test clean deploy fund help install snapshot format anvil 

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

help:
	@echo "Usage:"
	@echo "  make deploy [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""
	@echo ""
	@echo "  make fund [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""

all: clean remove install update build

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :; forge install Cyfrin/foundry-devops@0.0.11 --no-commit && forge install foundry-rs/forge-std@v1.5.3 --no-commit && forge install openzeppelin/openzeppelin-contracts@v4.8.3 --no-commit

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test 

snapshot :; forge snapshot

format :; forge fmt

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --gas-limit 2000000000000000 --gas-price 1200000000000000000 --broadcast

ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --gas-limit 200000000000 --gas-price 12000000000000 --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

deploy:
	@forge script script/DeployMyNFT.s.sol:DeployMyNFT $(NETWORK_ARGS)

mint:
	@forge script script/Interactions.s.sol:MintMyNFT ${NETWORK_ARGS}

deployAnimalFlip:
	@forge script script/DeployAnimalNFT.s.sol:DeployAnimalNFT $(NETWORK_ARGS)

mintLovedAnimalNFT:
	@forge script script/Interactions.s.sol:MintLovedAnimalNFT $(NETWORK_ARGS)

flipLovedAnimalNFT:
	@forge script script/Interactions.s.sol:FlipLovedAnimalNFT $(NETWORK_ARGS)

