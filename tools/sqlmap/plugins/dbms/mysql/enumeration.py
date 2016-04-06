#!/usr/bin/env python

"""
$Id: enumeration.py 2963 2011-01-14 11:55:20Z inquisb $

Copyright (c) 2006-2010 sqlmap developers (http://sqlmap.sourceforge.net/)
See the file 'doc/COPYING' for copying permission
"""

from plugins.generic.enumeration import Enumeration as GenericEnumeration

class Enumeration(GenericEnumeration):
    def __init__(self):
        GenericEnumeration.__init__(self)
