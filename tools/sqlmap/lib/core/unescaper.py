#!/usr/bin/env python

"""
$Id: unescaper.py 3245 2011-02-06 22:32:44Z inquisb $

Copyright (c) 2006-2010 sqlmap developers (http://sqlmap.sourceforge.net/)
See the file 'doc/COPYING' for copying permission
"""

from lib.core.common import Backend
from lib.core.datatype import advancedDict
from lib.core.settings import EXCLUDE_UNESCAPE

class Unescaper(advancedDict):
    def unescape(self, expression, quote=True, dbms=None):
        if expression is None:
            return expression

        for exclude in EXCLUDE_UNESCAPE:
            if exclude in expression:
                return expression

        identifiedDbms = Backend.getIdentifiedDbms()

        if dbms is not None:
            return self[dbms](expression, quote=quote)
        elif identifiedDbms is not None:
            return self[identifiedDbms](expression, quote=quote)
        else:
            return expression

unescaper = Unescaper()
