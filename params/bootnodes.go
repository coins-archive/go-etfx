// Copyright 2015 The go-ethereum Authors
// This file is part of the go-ethereum library.
//
// The go-ethereum library is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// The go-ethereum library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with the go-ethereum library. If not, see <http://www.gnu.org/licenses/>.

package params

// MainnetBootnodes are the enode URLs of the P2P bootstrap nodes running on
// the main Ethereum network.
var MainnetBootnodes = []string{
	"enode://cff5bfc41540631b5147c1c83b999d334bdd646e4edbc416774993e2e4a807356b53ac69f0f4724c632c1b572f13223fb7d4f1668066203386c4ffd11fe325bf@139.162.156.208:30303", //EU
	"enode://6ce8772eecae63dfaac429c5e0bb2d0316012825a5d37a9bccfbdd2f88f13606bd041a1cf64e98a6fffde4e2bd45757fb09d81564ea5c13c927a3ba0c920e09b@172.104.211.193:30303", //US
}

// TestnetBootnodes are the enode URLs of the P2P bootstrap nodes running on the
// test network.
var TestnetBootnodes = []string{
	"enode://e4e0656cf4fd9de516bad3cf93262f01848c8c5eab52ca957951262898eb84034d184154c07e8962716ff36e0146fb99b2b1ced29c839aa1dca221fa0e93e7a1@172.104.135.252:30303",
}

// DiscoveryV5Bootnodes are the enode URLs of the P2P bootstrap nodes for the
// experimental RLPx v5 topic-discovery network.
var DiscoveryV5Bootnodes = []string{
}
