/q tick/r.q [host]:port[:usr:pwd] [host]:port[:usr:pwd]
/2008.09.09 .k ->.q

if[not "w"=first string .z.o;system "sleep 1"];

upd:insert;

userVar:.z.u;

/ get the ticker plant and history ports, defaults are 5010,5012
.u.x:.z.x,(count .z.x)_(":5010";":5012");

/ end of day: save, clear, hdb reload
.u.end:{t:tables`.;t@:where `g=attr each t@\:`sym;.Q.hdpf[`$":",.u.x 1;`:./hdb;x;`sym];@[;`sym;`g#] each t;};

/ init schema and sync up from log file;cd to hdb(so client save can run)
.u.rep:{$[all 2 2=count each x;(.[;();:;].)each x;(.[;();:;].)x];if[null first y;:()];-11!y};
/ HARDCODE \cd if other than logdir/db

.u.createAgg:{[trade;quote]t1:select maxTrade:max price, tradeVolume:sum size by sym  from trade; t2:select maxBid:max bid, minAsk:min ask ,first time by sym from quote; :`time`sym`maxTrade`maxBid`minAsk`tradeVolume xcols 0!t1 lj t2};

/ connect to ticker plant for (schema;(logcount;log))
if[5011=system"p";.u.rep .(hopen `$":",.u.x 0)"(.u.sub[;`]each `trade`quote;`.u `i`L)";.z.ws:{neg[.z.w].Q.s value x;};activeWSConnections: ([] handle:(); connectTime:());.z.wo:{`activeWSConnections upsert (x;.z.t)};.z.wc:{ delete from `activeWSConnections where handle =x};];
if[5013=system"p";upd:{[t;x]$[t=`agg;[delete from t;t insert x];t insert x]};.u.rep .(hopen `$":",.u.x 0)"(.u.sub[`agg;`];`.u `i`L)"];

if[5015=system"p";
	system "l tick/u.q";
	system "l tick/schema.q";
	.u.rep .(h:hopen `$":",.u.x 0)"(.u.sub[;`]each `trade`quote;`.u `i`L)";
	(neg[h])".u.rep .(hopen 5015)\"(.u.sub[`agg;`];`)\"";
	.z.ts:{if[all `trade`quote in tables`;`agg set .u.createAgg[(select from trade);(select from quote)];.u.pub1[`agg;flip value each value `agg]]};
	/.z.ts:{if[all `trade`quote in tables`;`agg set .u.createAgg[(select from trade);(select from quote)];.u.pub1[`agg;flip value each value `agg];@[`.;.u.t;@[;`sym;`g#]0#]]};
	/.z.ts:{if[all `trade`quote in tables`;`agg set .u.createAgg[(select from trade);(select from quote)]]};
	system"t 1000";
	.u.init[];]

