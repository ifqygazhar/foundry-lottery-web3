Traces:
[8531944] → new FundSubscription@0x9f7cF1d1F558E57ef88a59ac3D47214eF25B6A06
└─ ← [Return] 42490 bytes of code

[7792442] FundSubscription::run()
├─ [7693859] → new HelperConfig@0x5aAdFB43eF8dAF45DD80F4676345b7676f1D70e3
│ └─ ← [Return] 37739 bytes of code
├─ [3018] HelperConfig::getConfig()
│ └─ ← [Return] NetworkConfig({ enterenceFee: 10000000000000000 [1e16], interval: 30, vrfCoordinator: 0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B, keyHash: 0x787d74caea10b2b357790d5b5247c2f63d1d91572a9846f780606e4d953677ae, subscriptionId: 0, callbackGasLimit: 500000 [5e5], link: 0x779877A7B0D9E8603169DdbD7836e478b4624789 })
├─ [3018] HelperConfig::getConfig()
│ └─ ← [Return] NetworkConfig({ enterenceFee: 10000000000000000 [1e16], interval: 30, vrfCoordinator: 0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B, keyHash: 0x787d74caea10b2b357790d5b5247c2f63d1d91572a9846f780606e4d953677ae, subscriptionId: 0, callbackGasLimit: 500000 [5e5], link: 0x779877A7B0D9E8603169DdbD7836e478b4624789 })
├─ [3018] HelperConfig::getConfig()
│ └─ ← [Return] NetworkConfig({ enterenceFee: 10000000000000000 [1e16], interval: 30, vrfCoordinator: 0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B, keyHash: 0x787d74caea10b2b357790d5b5247c2f63d1d91572a9846f780606e4d953677ae, subscriptionId: 0, callbackGasLimit: 500000 [5e5], link: 0x779877A7B0D9E8603169DdbD7836e478b4624789 })
├─ [0] console::log("Funding subscription on chain Id: ", 11155111 [1.115e7], " with ID: ", 0) [staticcall]
│ └─ ← [Stop]
├─ [0] console::log("using VRF Coordinator: ", VRFCoordinatorV2_5: [0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B]) [staticcall]
│ └─ ← [Stop]
├─ [0] console::log("on chain id", 11155111 [1.115e7]) [staticcall]
│ └─ ← [Stop]
├─ [0] VM::startBroadcast()
│ └─ ← [Return]
├─ [26656] LinkToken::transferAndCall(VRFCoordinatorV2_5: [0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B], 3000000000000000000 [3e18], 0x0000000000000000000000000000000000000000000000000000000000000000)
│ ├─ emit Transfer(from: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, to: VRFCoordinatorV2_5: [0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B], amount: 3000000000000000000 [3e18])
│ ├─ emit Transfer(from: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, to: VRFCoordinatorV2_5: [0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B], value: 3000000000000000000 [3e18], data: 0x0000000000000000000000000000000000000000000000000000000000000000)
│ ├─ [7285] VRFCoordinatorV2_5::onTokenTransfer(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, 3000000000000000000 [3e18], 0x0000000000000000000000000000000000000000000000000000000000000000)
│ │ └─ ← [Revert] InvalidSubscription()
│ └─ ← [Revert] InvalidSubscription()
└─ ← [Revert] InvalidSubscription()
