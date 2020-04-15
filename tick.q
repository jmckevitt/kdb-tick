
/q tick.q SRC [DST] [-p 5010] [-o h]
system"l tick/",(src:first .z.x,enlist"schema"),".q"   // load schema file

system"l tick/log.q";
upd:insert;
userVar:.z.u;
upd1:insert;
upd_py:{y[0]:"P"$string y[0]; x insert y}
upd_java:{[t;x]x:update time:"P"$ string time from x;t insert x}
if[not system"p";system"p 5010"] / test comment


\l tick/u.q
\d .u
ld:{if[not type key L::`$(-10_string L),string x;.[L;();:;()]];i::j::-11!(-2;L);if[0<=type i;-2 (string L)," is a corrupt log. Truncate to length ",(string last i)," and restart";exit 1];hopen L};
log1:{L1::hsym `$"log_",string x;hopen L1};
tick:{init[];if[not min(`time`sym~2#key flip value@)each t;'`timesym];@[;`sym;`g#]each t;d::.z.D;if[l::count y;L::`$":",y,"/",x,10#".";l::ld d;l1::log1 d]};

endofday:{end d;d+:1;if[l;hclose l;l::0(`.u.ld;d)]};
ts:{if[d<x;if[d<x-1;system"t 0";'"more than one day?"];endofday[]]};

rep:{$[all 2 2=count each x;(.[;();:;].)each x;(.[;();:;].)x];if[null first y;:()];-11!y};

if[system"t";
 .z.ts:{pub'[t;value each t];@[`.;t;@[;`sym;`g#]0#];i::j;ts .z.D};
 upd:{[t;x]
 / if[not -16=type first first x;if[d<"d"$a:.z.P;.z.ts[]];a:"n"$a;x:$[0>type first x;a,x;(enlist(count first x)#a),x]];/ Removed,not needed
   $[t=`agg;[delete from t;t insert x];[t insert x;if[l;l enlist (`upd;t;x);j+:1]]];if[l1;l1 "subscribers: ",(";" sv {raze (raze string x)," - ",("," sv first each string w[x])}each key w),"; number of messages: ",(string i),"\n"];}];

   
   
if[not system"t";system"t 60000";
 .z.ts:{ts .z.D; if[l1;l1 "subscribers: ",("; " sv {raze (raze string x)," - ",("," sv first each string w[x])}each key w),"; number of messages: ",(string i),"\n"]};
 upd:{[t;x]ts"d"$a:.z.P;
  / if[not -16=type first first x;a:"n"$a;x:$[0>type first x;a,x;(enlist(count first x)#a),x]]; / Removed, not needed
 f:key flip value t;pub[t;$[0>type first x;enlist f!x;flip f!x]];if[l;l enlist (`upd;t;x);i+:1];}];

\d .
.u.tick[src;.z.x 1];
/system"timeout 10 > NUL";
/.u.rep .(h:hopen 5015)"(.u.sub[`agg;`];`)";

\
 globals used
 .u.w - dictionary of tables->(handle;syms)
 .u.i - msg count in log file
 .u.j - total msg count (log file plus those held in buffer)
 .u.t - table names
 .u.L - tp log filename, e.g. `:./sym2008.09.11
 .u.l - handle to tp log file
 .u.d - date


