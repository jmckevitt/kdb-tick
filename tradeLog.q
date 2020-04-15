/   tradeLog.q

r:get .u.L;

LL:`:journal/tradeIBMLog;
if[not type key LL;.[LL;();:;()]];
ll::hopen LL

{ll enlist x} each filtered:t where {`IBM.N in x[2][1]} each t:r where {`trade in x}each r