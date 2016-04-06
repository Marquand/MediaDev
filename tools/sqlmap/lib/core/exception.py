#!/usr/bin/env python

"""
$Id: exception.py 3126 2011-01-28 16:15:45Z stamparm $

Copyright (c) 2006-2010 sqlmap developers (http://sqlmap.sourceforge.net/)
See the file 'doc/COPYING' for copying permission
"""

class sqlmapConnectionException(Exception):
    pass

class sqlmapDataException(Exception):
    pass

class sqlmapFilePathException(Exception):
    pass

class sqlmapGenericException(Exception):
    pass

class sqlmapMissingDependence(Exception):
    pass

class sqlmapMissingMandatoryOptionException(Exception):
    pass

class sqlmapMissingPrivileges(Exception):
    pass

class sqlmapNoneDataException(Exception):
    pass

class sqlmapNotVulnerableException(Exception):
    pass

class sqlmapSilentQuitException(Exception):
    pass

class sqlmapUserQuitException(Exception):
    pass

class sqlmapRegExprException(Exception):
    pass

class sqlmapSyntaxException(Exception):
    pass

class sqlmapThreadException(Exception):
    pass

class sqlmapUndefinedMethod(Exception):
    pass

class sqlmapUnsupportedDBMSException(Exception):
    pass

class sqlmapUnsupportedFeatureException(Exception):
    pass

class sqlmapValueException(Exception):
    pass

exceptionsTuple = (
                    sqlmapConnectionException,
                    sqlmapDataException,
                    sqlmapFilePathException,
                    sqlmapGenericException,
                    sqlmapMissingDependence,
                    sqlmapMissingMandatoryOptionException,
                    sqlmapNoneDataException,
                    sqlmapRegExprException,
                    sqlmapSyntaxException,
                    sqlmapUndefinedMethod,
                    sqlmapMissingPrivileges,
                    sqlmapNotVulnerableException,
                    sqlmapThreadException,
                    sqlmapUnsupportedDBMSException,
                    sqlmapUnsupportedFeatureException,
                    sqlmapValueException,
                  )
