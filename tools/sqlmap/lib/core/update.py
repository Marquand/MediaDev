#!/usr/bin/env python

"""
$Id: update.py 3434 2011-03-18 16:35:30Z stamparm $

Copyright (c) 2006-2010 sqlmap developers (http://sqlmap.sourceforge.net/)
See the file 'doc/COPYING' for copying permission
"""

import os
import re
import shutil
import sys
import time

from distutils.dir_util import mkpath

from subprocess import PIPE
from subprocess import Popen as execute

from lib.core.common import dataToStdout
from lib.core.common import getUnicode
from lib.core.common import readInput
from lib.core.data import conf
from lib.core.data import logger
from lib.core.data import paths
from lib.core.exception import sqlmapFilePathException
from lib.core.settings import IS_WIN
from lib.core.settings import UNICODE_ENCODING
from lib.core.subprocessng import pollProcess
from lib.request.connect import Connect as Request

def update():
    if not conf.updateAll:
        return

    rootDir = paths.SQLMAP_ROOT_PATH

    infoMsg = "updating sqlmap to latest development version from the "
    infoMsg += "subversion repository"
    logger.info(infoMsg)

    try:
        import pysvn

        debugMsg = "sqlmap will update itself using installed python-svn "
        debugMsg += "third-party library, http://pysvn.tigris.org/"
        logger.debug(debugMsg)

        def notify(event_dict):
            action = getUnicode(event_dict['action'])
            index = action.find('_')
            prefix = action[index + 1].upper() if index != -1 else action.capitalize()

            if action.find('_update') != -1:
                return

            if action.find('_completed') == -1:
                dataToStdout("%s\t%s\n" % (prefix, event_dict['path']))
            else:
                revision = getUnicode(event_dict['revision'], UNICODE_ENCODING)
                index = revision.find('number ')

                if index != -1:
                    revision = revision[index+7:].strip('>')

                logger.info('updated to the latest revision %s' % revision)

        client = pysvn.Client()
        client.callback_notify = notify
        client.update(rootDir)

    except ImportError, _:
        debugMsg = "sqlmap will try to update itself using 'svn' command"
        logger.debug(debugMsg)

        process = execute("svn update %s" % rootDir, shell=True, stdout=PIPE, stderr=PIPE)

        dataToStdout("\r[%s] [INFO] update in progress " % time.strftime("%X"))
        pollProcess(process)
        svnStdout, svnStderr = process.communicate()

        if svnStderr:
            errMsg = getUnicode(svnStderr, system=True).strip()
            logger.error(errMsg)

            if IS_WIN:
                infoMsg = "for Windows platform it's recommended "
                infoMsg += "to use a TortoiseSVN GUI client for updating "
                infoMsg += "purposes (http://tortoisesvn.net/)"
                logger.info(infoMsg)

        elif svnStdout:
            revision = re.search("revision\s+([\d]+)", svnStdout, re.I)

            if revision:
                logger.info('updated to the latest revision %s' % revision.group(1))
