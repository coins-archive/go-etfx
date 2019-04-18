## Go Ethereum Fx

Official Golang implementation of the Ethereum protocol.

Binary archives are published at https://github.com/etfx-dev/go-etfx/releases.

## Building the source

Building getfx requires both a Go (version 1.10 or later) and a C compiler.
You can install them using your favourite package manager.
Once the dependencies are installed, run

    make getfx

or, to build the full suite of utilities:

    make all

## Running getfx

### Full node on the main Ethereum network

By far the most common scenario is people wanting to simply interact with the Ethereum Fx network:
create accounts; transfer funds; deploy and interact with contracts. For this particular use-case
the user doesn't care about years-old historical data, so we can fast-sync quickly to the current
state of the network. To do so:

```
$ getfx console
```

This command will:

 * Start getfx in fast sync mode (default, can be changed with the `--syncmode` flag), causing it to
   download more data in exchange for avoiding processing the entire history of the Ethereum Fx network,
   which is very CPU intensive.
 * Start up Getfx's built-in interactive JavaScript console,
   (via the trailing `console` subcommand) through which you can invoke all official `web3` methods
   as well as Getfx's own management APIs.
   This tool is optional and if you leave it out you can always attach to an already running Getfx instance
   with `getfx attach`.

### A Full node on the Ethereum Fx test network

Transitioning towards developers, if you'd like to play around with creating Ethereum Fx contracts, you
almost certainly would like to do that without any real money involved until you get the hang of the
entire system. In other words, instead of attaching to the main network, you want to join the **test**
network with your node, which is fully equivalent to the main network, but with play-EtherFx only.

```
$ getfx --testnet console
```

The `console` subcommand has the exact same meaning as above and they are equally useful on the
testnet too. Please see above for their explanations if you've skipped here.

Specifying the `--testnet` flag, however, will reconfigure your Getfx instance a bit:

 * Instead of using the default data directory (`~/.ethereum` on Linux for example), Getfx will nest
   itself one level deeper into a `testnet` subfolder (`~/.ethereum/testnet` on Linux). Note, on OSX
   and Linux this also means that attaching to a running testnet node requires the use of a custom
   endpoint since `getfx attach` will try to attach to a production node endpoint by default. E.g.
   `getfx attach <datadir>/testnet/geth.ipc`. Windows users are not affected by this.
 * Instead of connecting the main Ethereum Fx network, the client will connect to the test network,
   which uses different P2P bootnodes, different network IDs and genesis states.
   
*Note: Although there are some internal protective measures to prevent transactions from crossing
over between the main network and test network, you should make sure to always use separate accounts
for play-money and real-money. Unless you manually move accounts, Getfx will by default correctly
separate the two networks and will not make any accounts available between them.*


### Configuration

As an alternative to passing the numerous flags to the `getfx` binary, you can also pass a configuration file via:

```
$ getfx --config /path/to/your_config.toml
```

To get an idea how the file should look like you can use the `dumpconfig` subcommand to export your existing configuration:

```
$ getfx --your-favourite-flags dumpconfig
```

*Note: This works only with getfx v1.6.0 and above.*


### Programmatically interfacing Getfx nodes

As a developer, sooner rather than later you'll want to start interacting with Getfx and the Ethereum Fx
network via your own programs and not manually through the console. To aid this, Getfx has built-in
support for a JSON-RPC based APIs. These can be
exposed via HTTP, WebSockets and IPC (UNIX sockets on UNIX based platforms, and named pipes on Windows).

The IPC interface is enabled by default and exposes all the APIs supported by Geth, whereas the HTTP
and WS interfaces need to manually be enabled and only expose a subset of APIs due to security reasons.
These can be turned on/off and configured as you'd expect.

HTTP based JSON-RPC API options:

  * `--rpc` Enable the HTTP-RPC server
  * `--rpcaddr` HTTP-RPC server listening interface (default: "localhost")
  * `--rpcport` HTTP-RPC server listening port (default: 8545)
  * `--rpcapi` API's offered over the HTTP-RPC interface (default: "eth,net,web3")
  * `--rpccorsdomain` Comma separated list of domains from which to accept cross origin requests (browser enforced)
  * `--ws` Enable the WS-RPC server
  * `--wsaddr` WS-RPC server listening interface (default: "localhost")
  * `--wsport` WS-RPC server listening port (default: 8546)
  * `--wsapi` API's offered over the WS-RPC interface (default: "eth,net,web3")
  * `--wsorigins` Origins from which to accept websockets requests
  * `--ipcdisable` Disable the IPC-RPC server
  * `--ipcapi` API's offered over the IPC-RPC interface (default: "admin,debug,eth,miner,net,personal,shh,txpool,web3")
  * `--ipcpath` Filename for IPC socket/pipe within the datadir (explicit paths escape it)

You'll need to use your own programming environments' capabilities (libraries, tools, etc) to connect
via HTTP, WS or IPC to a Getfx node configured with the above flags and you'll need to speak [JSON-RPC](https://www.jsonrpc.org/specification)
on all transports. You can reuse the same connection for multiple requests!

**Note: Please understand the security implications of opening up an HTTP/WS based transport before
doing so! Hackers on the internet are actively trying to subvert Ethereum Fx nodes with exposed APIs!
Further, all browser tabs can access locally running web servers, so malicious web pages could try to
subvert locally available APIs!**

## License

The go-ethereumfx library (i.e. all code outside of the `cmd` directory) is licensed under the
[GNU Lesser General Public License v3.0](https://www.gnu.org/licenses/lgpl-3.0.en.html), also
included in our repository in the `COPYING.LESSER` file.

The go-ethereumfx binaries (i.e. all code inside of the `cmd` directory) is licensed under the
[GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html), also included
in our repository in the `COPYING` file.
