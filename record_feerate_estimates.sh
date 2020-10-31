#!/bin/bash
#need to define environment variables BTCRPCUSER and BTCRPCPASS
while true
do
	date_str=$(date)
	date_unix=$(date '+%s')
	feerate_histogram=$(echo '{"jsonrpc": "2.0", "method": "mempool.get_fee_histogram", "id": 1}' | nc -w 1 127.0.0.1 50001 | awk -F: '{print $3}' | sed 's/^ //' | sed 's/, "id.*//') #call electrumx method mempool.get_fee_histogram
	fee_estimates=$(for x in 4 8 12 16 20 24 28 32 36 40 42 44 46 48 49 100; do hist=$(./bitcoin-0.20.1/bin/bitcoin-cli -rpcuser=$BTCRPCUSER -rpcpassword=$BTCRPCPASS estimatesmartfee $x ECONOMICAL); printf "%s," "$hist"; done | sed 's/},$/}/')
	height=$(./bitcoin-0.20.1/bin/bitcoin-cli -rpcuser=$BTCRPCUSER -rpcpassword=$BTCRPCPASS getblockcount)

	printf '{"date_str": "%s", "date_unix": %d, "height": %s, "histogram": "%s", "estimates": "[%s]"},\n' "$date_str" "$date_unix" "$height" "$feerate_histogram" "$fee_estimates"
	sleep 180
done
