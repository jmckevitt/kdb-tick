/ tick/log.q,can be loaded into the script to facilitate logging functionality

connectionLog:`:connectionLog;

if[not type key connectionLog;.[connectionLog;();:;()]];

conLog::hopen connectionLog

.z.po:{user:string x"userVar";usage:string x".Q.w[][`used]";conLog"Port opened, handle:",(string x),", user:",user,", memory usage:",usage,"\n";};

.z.pc:{user:string x"userVar";usage:string x".Q.w[][`used]";conLog"Port closed, handle:",(string x),", user:",user,", memory usage:",usage,"\n";};

errorLog:`:errorLog;

.sys.logError:{if[not type key errorLog;.[errorLog;();:;()]];(errLog:hopen errorLog);errLog x;hclose errLog};