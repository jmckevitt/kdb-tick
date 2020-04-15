
# Advanced kdb+

Repository for Advanced KDB+ CMTP. Built on kdb tick repository.


## Ports

Tickerplant: 5010  

RDB 1:       5011  

RDB 2:       5013  

HDB:         5012  

CEP:         5015

feedhandler: 5014


## Instructions for running

`python start.py [start|stop|test][tickerplant|rdb1|rdb2|hdb|cep|feedhandler|all] `  

You can kick off all the processes with the following command:  
```
C:\Users\Joseph\Documents\kdb-tick-master>python start.py start all
Enter project directory: C:\Users\Joseph\Documents\kdb-tick-master
Batching mode? **0 for non batching, >0 for batching**: 1000
```
For the first prompt enter the working directory, for the second, set the timer

And now testing the result:
```
C:\Users\Joseph\Documents\kdb-tick-master>python start.py test all
tickerplant : UP

rdb1 : UP

hdb : UP

rdb2 : UP

feedhandler : UP

cep : UP
```
---
Open a q session and connect to each of the processes to test the result, for example, taking both RDBs:
```
q)h:hopen 5011 /rdb 1, which subscribes to trade and quote
q)h"select from trade"
time                          sym   size price    exchange
----------------------------------------------------------
2019.04.23D20:40:25.866584000 BA.N  24   128.0466 LSE
2019.04.23D20:40:25.866584000 VOD.L 40   341.3296 CME
2019.04.23D20:40:26.866243000 VOD.L 40   341.319  LSE
2019.04.23D20:40:26.866243000 VOD.L 20   341.3377 TSE
2019.04.23D20:40:27.866827000 BA.N  12   128.0449 HKSE
..
q)h"select from quote"
time                          sym    bid      ask      bidSize askSize exchange
-------------------------------------------------------------------------------
2019.04.23D20:40:24.966139000 GS.N   178.493  178.5151 3       21      NYSE
2019.04.23D20:40:24.966139000 VOD.L  341.2972 341.3133 45      0       LSE
2019.04.23D20:40:25.066842000 IBM.N  191.0963 191.1003 10      4       CME
2019.04.23D20:40:25.066842000 GS.N   178.4984 178.5128 12      12      TSE
2019.04.23D20:40:25.166716000 MSFT.O 45.14983 45.15049 3       1       TSE
..
q)hclose h
q)hopen 5013 / rdb 2, which subscribes to agg table
q)h"select from agg"
time                          sym    maxTrade maxBid   minAsk   tradeVolume
---------------------------------------------------------------------------
2019.04.23D20:40:25.766505000 BA.N   128.0603 128.0549 127.8468 6292
2019.04.23D20:40:24.966139000 GS.N   178.538  178.5379 177.9855 5883
2019.04.23D20:40:25.066842000 IBM.N  191.1314 191.1258 190.7725 3046
2019.04.23D20:40:25.166716000 MSFT.O 45.16717 45.16484 45.09669 1944
2019.04.23D20:40:24.966139000 VOD.L  341.5426 341.5388 340.7407 10240
q)hclose h
```
E1 P9 (compressing the data and saving it to the HDB) does not run on my machine, as my q install doesn't seem to have zlib (`The specified module could not be found.zlib` is the error message I get), so I'm going to have to hope that it would work otherwise

To run E1 P7 and E1 P9 you'll have to load the script into the tickerplant session (port 5010), just loading the scripts asynchronously should suffice (tradeLog.q and eodHDB.q) , you should see the new trade log at `journal/tradeIBMlog`.

For E1 P5 (iv),  the language isn't very clear, I've included an error log function that isn't used across the application, but could be used by the user (although that's not really useful).

For E1 P8:
It's probably best to stop the feedhandler process before testing this:
`python start.py stop feedhandler`
We do this so that we can see the result at the end of the table in RDB 1
 The load can be performed with `q csvLoad.q quote.csv`  

Also, despite the script being made to also use trade.csv, it will no longer work with it, as I modified trade.csv to work with the Python and Java scripts in exercise 3 (I removed the column names).

---

Exercise 2 should be contained within the word document.

---
Python script:
```
C:\Users\Joseph\Documents\kdb-tick-master>python csvLoad.py
:localhost:5010
IPC version: 3. Is connected: True
Check table in tickerplant
```
The Java script has already been compiled, so you can just call the class:
```
C:\Users\Joseph\Documents\kdb-tick-master>java csvLoad
Sent records to KDB server
2019.04.09D15:25:03.727042998
```

For the HTML script, I modified a script I found on code.kx.com to query the trade table in RDB 1 for a specific symbol (e.g. VOD.L), just enter a symbol in the text box and the press 'Go'.


