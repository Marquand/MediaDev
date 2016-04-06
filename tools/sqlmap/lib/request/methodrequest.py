#!/usr/bin/env python

"""
$Id: methodrequest.py 2018 2010-10-15 10:28:34Z inquisb $

Copyright (c) 2006-2010 sqlmap developers (http://sqlmap.sourceforge.net/)
See the file 'doc/COPYING' for copying permission
"""

import urllib2


class MethodRequest(urllib2.Request):
    '''
    Used to create HEAD/PUT/DELETE/... requests with urllib2
    '''

    def set_method(self, method):
        self.method = method.upper()

    def get_method(self):
        return getattr(self, 'method', urllib2.Request.get_method(self))
