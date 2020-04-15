r:-11!(-2;.u.L);
-11!(r;.u.L);

agg:-5#agg;
quoteCols:`,((cols quote)except `time`sym);
tradeCols:`,((cols trade)except `time`sym);
aggCols:`,((cols trade)except `time`sym);

count aggCols
date:.z.d;

(hsym ` sv (`:hdb;`$(string date);`trade);tradeCols!((17;2;9);(17;2;6);(17;2;6);(17;2;6))) set .Q.en[`:hdb]trade;
(hsym ` sv (`:hdb;`$(string date);`quote);quoteCols!((17;2;9);(17;2;6);(17;2;6);(17;2;6);(17;2;6);(17;2;6))) set .Q.en[`:hdb]quote;
(hsym ` sv (`:hdb;`$(string date);`agg);aggCols!((17;2;9);(17;2;6);(17;2;6);(17;2;6))) set .Q.en[`:hdb]agg;


