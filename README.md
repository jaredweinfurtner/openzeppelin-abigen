# openzeppelin-abigen

The out-of-the-box [go-ethereum's abigen](https://github.com/ethereum/go-ethereum) allows a `combined-json` flag to extract the `abi` and `bin` data from the solidity compiler (solc); however this is not the same json format as a compiled [OpenZeppelin's compiler](https://docs.openzeppelin.com/cli/2.6/compiling).  This docker container aims to allow developers to generate go-wrappers for solidity files that contain references to imported OpenZeppelin contracts via `npm`.

## Run it

2 simple arguments
- -o [the output directory of the generated go-wrappers]
- -p [the package name of the generated go-wrappers] 

Run the following in the root directory of your projects:

```commandline
 docker run -u $(id -u ${USER}):$(id -g ${USER}) --rm -v $(pwd):/sources jaredweinfurtner/openzeppelin-abigen -o /sources/internal/contracts -p contracts
```
