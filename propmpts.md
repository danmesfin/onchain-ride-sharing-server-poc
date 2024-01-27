```
npx hardhat get-ride-details --contract 0x1608b6FF78aCEeEfA2E2CF9Fbe1E07995dc240F1 --rideid 1 --network fuji

```
npx hardhat start-ride --contract 0x1608b6FF78aCEeEfA2E2CF9Fbe1E07995dc240F1 --user 0x6c4Ea5141AEE745Ab3FE06C887e34914f8C7b097 --estimatedendtime 1620000000 --network fuji

```
npx hardhat complete-ride --contract 0x4fDBd4C17B12f555E8bc44a1182e2e7cF85386F3 --rideid 1 --distance 15 --network fuji

```
npx hardhat set-emission-factor --contract <Contract_Address> --vehicletype "car" --emissionfactor 100 --network fuji

```
npx hardhat process-payment --contract <Contract_Address> --rideId 1 --user 0xUserAddress --distanceTraveled 1000 --vehicleType "car" --value 1000000000000000000 --network <Network_Name>

```
npx hardhat set-emission-factor --contract 0x24E2Ad92147651fCF22aB4a0C5AF25b42bdEFF83 --vehicletype "car" --emissionfactor 100 --network fuji

```

```
--------------------------------------------
Addresses
----------
reward contract = 0x24E2Ad92147651fCF22aB4a0C5AF25b42bdEFF83
----------
RideTransactions deployed to: 0x4fDBd4C17B12f555E8bc44a1182e2e7cF85386F3 on chain: 43113
----------