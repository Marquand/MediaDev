#!/usr/bin/env python

"""
$Id: space2randomblank.py 3555 2011-04-04 08:18:26Z stamparm $

Copyright (c) 2006-2010 sqlmap developers (http://sqlmap.sourceforge.net/)
See the file 'doc/COPYING' for copying permission
"""

import random

from lib.core.enums import PRIORITY

__priority__ = PRIORITY.LOW

def tamper(payload):
    """
    Replaces ' ' with a random blank char from a set ('\r', '\n', '\t')
    Example: 'SELECT id FROM users' becomes 'SELECT\rid\tFROM\nusers'
    """

    blanks = ['\r', '\n', '\t']
    retVal = payload

    if payload:
        retVal = ""
        quote, doublequote, firstspace = False, False, False

        for i in xrange(len(payload)):
            if not firstspace:
                if payload[i].isspace():
                    firstspace = True
                    retVal += random.choice(blanks)
                    continue

            elif payload[i] == '\'':
                quote = not quote

            elif payload[i] == '"':
                doublequote = not doublequote

            elif payload[i]==" " and not doublequote and not quote:
                retVal += random.choice(blanks)
                continue

            retVal += payload[i]

    return retVal

