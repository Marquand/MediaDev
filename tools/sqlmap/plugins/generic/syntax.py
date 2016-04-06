#!/usr/bin/env python

"""
$Id: syntax.py 2009 2010-10-14 23:18:29Z stamparm $

Copyright (c) 2006-2010 sqlmap developers (http://sqlmap.sourceforge.net/)
See the file 'doc/COPYING' for copying permission
"""

from lib.core.exception import sqlmapUndefinedMethod

class Syntax:
    """
    This class defines generic syntax functionalities for plugins.
    """

    def __init__(self):
        pass

    @staticmethod
    def unescape(expression, quote=True):
        errMsg  = "'unescape' method must be defined "
        errMsg += "into the specific DBMS plugin"
        raise sqlmapUndefinedMethod, errMsg

    @staticmethod
    def escape(expression):
        errMsg  = "'escape' method must be defined "
        errMsg += "into the specific DBMS plugin"
        raise sqlmapUndefinedMethod, errMsg
