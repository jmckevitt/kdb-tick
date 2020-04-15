userVar:.z.u;
h:neg hopen `:localhost:5010 /connect to tickerplant

file:hsym `$ f:.z.x 0;

if[f like "*trade*";tflag:1b;colTypes:"psjfs"];
if[f like "*quote*";tflag:0b;colTypes:"psffjjs"];

data:(colTypes;enlist ",") 0: file;

$[tflag;h("upd1";`trade;data);h("upd1";`quote;data)];

exit[0]