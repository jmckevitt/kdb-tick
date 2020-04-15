import datetime
import numpy
import sys
import time
import csv

from qpython import qconnection
from qpython.qcollection import qlist
from qpython.qtype import QException, QTIME_LIST, QSYMBOL_LIST, QFLOAT_LIST, QTIMESTAMP_LIST, QLONG_LIST, QDOUBLE_LIST



		
def get_trade_data():
		
    my_data = numpy.genfromtxt('trade.csv', delimiter=',', dtype=None)
    time = [row[0] for row in my_data]
    sym = [row[1] for row in my_data]
    size = [row[2] for row in my_data]
    price = [row[3] for row in my_data]
    exchange = [row[4] for row in my_data]

		
    data = [time, qlist(sym, qtype=QSYMBOL_LIST), qlist(size, qtype=QLONG_LIST), qlist(price, qtype=QDOUBLE_LIST), qlist(exchange, qtype=QSYMBOL_LIST)]
		
    return data
		
		
		

if __name__ == '__main__':
    with qconnection.QConnection(host='localhost', port=5010) as q:
        print(q)
        print('IPC version: %s. Is connected: %s' % (q.protocol_version, q.is_connected()))
        
        q.open()
        try:
            q.sendSync('upd_py', numpy.string_("trade"), get_trade_data())
        except:
            print("Check table in tickerplant")


