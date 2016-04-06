#!/usr/bin/env python

"""
$Id: randomcomments.py 3555 2011-04-04 08:18:26Z stamparm $

Copyright (c) 2006-2010 sqlmap developers (http://sqlmap.sourceforge.net/)
See the file 'doc/COPYING' for copying permission
"""

import re

from lib.core.common import randomRange
from lib.core.data import kb
from lib.core.enums import PRIORITY

__priority__ = PRIORITY.LOW

def tamper(payload):
    """
    Add random comments to SQL keywords
    Example: 'INSERT' becomes 'IN/**/S/**/ERT'
    """

    retVal = payload

    if payload:
        for match in re.finditer(r"[A-Za-z_]+", payload):
            word = match.group()

            if len(word) < 2:
                continue

            if word.upper() in kb.keywords:
                newWord = word[0]

                for i in xrange(1, len(word) - 1):
                    newWord += "%s%s" % ("/**/" if randomRange(0, 1) else "", word[i])

                newWord += word[-1]
                retVal = retVal.replace(word, newWord)

    return retVal
