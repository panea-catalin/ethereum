-include .env

build:; forge build

anvil:; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

deploy-sepolia:
	forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url $SEPOLIA_RPC_URL

deploy:
	forge script script/DeployFundMe.s.sol:DeployFundMe $(NETWORK_ARGS)