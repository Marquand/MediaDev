#!/usr/bin/env python

"""
$Id: rangehandler.py 2318 2010-11-09 09:42:43Z stamparm $

Copyright (c) 2006-2010 sqlmap developers (http://sqlmap.sourceforge.net/)
See the file 'doc/COPYING' for copying permission
"""

import urllib
import urllib2

from lib.core.exception import sqlmapConnectionException

class HTTPRangeHandler(urllib2.BaseHandler):
    """
    Handler that enables HTTP Range headers.

    Reference: http://stackoverflow.com/questions/1971240/python-seek-on-remote-file

    This was extremely simple. The Range header is a HTTP feature to
    begin with so all this class does is tell urllib2 that the 
    "206 Partial Content" reponse from the HTTP server is what we 
    expected.

    Example:
        import urllib2
        import byterange

        range_handler = range.HTTPRangeHandler()
        opener = urllib2.build_opener(range_handler)

        # install it
        urllib2.install_opener(opener)

        # create Request and set Range header
        req = urllib2.Request('http://www.python.org/')
        req.header['Range'] = 'bytes=30-50'
        f = urllib2.urlopen(req)
    """

    def http_error_206(self, req, fp, code, msg, hdrs):
        # 206 Partial Content Response
        r = urllib.addinfourl(fp, hdrs, req.get_full_url())
        r.code = code
        r.msg = msg
        return r

    def http_error_416(self, req, fp, code, msg, hdrs):
        # HTTP's Range Not Satisfiable error
        errMsg = "Invalid range"
        raise sqlmapConnectionException, errMsg
