#!/usr/bin/env python

"""
$Id: connector.py 2246 2010-11-03 10:08:27Z stamparm $

Copyright (c) 2006-2010 sqlmap developers (http://sqlmap.sourceforge.net/)
See the file 'doc/COPYING' for copying permission
"""

import os

from lib.core.data import conf
from lib.core.data import logger
from lib.core.exception import sqlmapFilePathException
from lib.core.exception import sqlmapUndefinedMethod

class Connector:
    """
    This class defines generic dbms protocol functionalities for plugins.
    """

    def __init__(self):
        self.connector = None
        self.cursor = None

    def initConnection(self):
        self.user = conf.dbmsUser
        self.password = conf.dbmsPass if conf.dbmsPass is not None else ""
        self.hostname = conf.hostname
        self.port = conf.port
        self.db = conf.dbmsDb

    def connected(self):
        infoMsg = "connection to %s server %s" % (conf.dbms, self.hostname)
        infoMsg += ":%d established" % self.port
        logger.info(infoMsg)

    def closed(self):
        infoMsg = "connection to %s server %s" % (conf.dbms, self.hostname)
        infoMsg += ":%d closed" % self.port
        logger.info(infoMsg)

        self.connector = None
        self.cursor = None

    def setCursor(self):
        self.cursor = self.connector.cursor()

    def getCursor(self):
        return self.cursor

    def close(self):
        self.cursor.close()
        self.connector.close()
        self.closed()

    def checkFileDb(self):
        if not os.path.exists(self.db):
            errMsg = "the provided database file '%s' does not exist" % self.db
            raise sqlmapFilePathException, errMsg

    def connect(self):
        errMsg  = "'connect' method must be defined "
        errMsg += "into the specific DBMS plugin"
        raise sqlmapUndefinedMethod, errMsg

    def fetchall(self):
        errMsg  = "'fetchall' method must be defined "
        errMsg += "into the specific DBMS plugin"
        raise sqlmapUndefinedMethod, errMsg

    def execute(self, query):
        errMsg  = "'execute' method must be defined "
        errMsg += "into the specific DBMS plugin"
        raise sqlmapUndefinedMethod, errMsg

    def select(self, query):
        errMsg  = "'select' method must be defined "
        errMsg += "into the specific DBMS plugin"
        raise sqlmapUndefinedMethod, errMsg
