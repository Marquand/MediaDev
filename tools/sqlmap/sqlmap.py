#!/usr/bin/env python

"""
$Id: sqlmap.py 3162 2011-01-31 21:22:39Z inquisb $

Copyright (c) 2006-2010 sqlmap developers (http://sqlmap.sourceforge.net/)
See the file 'doc/COPYING' for copying permission
"""

import codecs
import os
import sys
import time
import traceback
import warnings

warnings.filterwarnings(action="ignore", message=".*was already imported", category=UserWarning)

try:
    import psyco
    psyco.full()
    psyco.profile()
except ImportError:
    pass

from lib.controller.controller import start
from lib.core.common import banner
from lib.core.common import dataToStdout
from lib.core.common import getUnicode
from lib.core.common import setPaths
from lib.core.common import weAreFrozen
from lib.core.data import cmdLineOptions
from lib.core.data import conf
from lib.core.data import kb
from lib.core.data import logger
from lib.core.data import paths
from lib.core.common import unhandledExceptionMessage
from lib.core.exception import exceptionsTuple
from lib.core.exception import sqlmapSilentQuitException
from lib.core.exception import sqlmapUserQuitException
from lib.core.option import init
from lib.core.profiling import profile
from lib.core.testing import smokeTest
from lib.core.testing import liveTest
from lib.core.xmldump import closeDumper
from lib.parse.cmdline import cmdLineParser

def modulePath():
    """
    This will get us the program's directory, even if we are frozen
    using py2exe
    """

    if weAreFrozen():
        return os.path.dirname(getUnicode(sys.executable, sys.getfilesystemencoding()))
    else:
        return os.path.dirname(os.path.realpath(__file__))

def main():
    """
    Main function of sqlmap when running from command line.
    """

    paths.SQLMAP_ROOT_PATH = modulePath()
    setPaths()
    banner()

    # Store original command line options for possible later restoration
    cmdLineOptions.update(cmdLineParser().__dict__)

    dataToStdout("[*] starting at: %s\n\n" % time.strftime("%X"), forceOutput=True)

    try:
        init(cmdLineOptions)
        if conf.profile:
            profile()
        elif conf.smokeTest:
            smokeTest()
        elif conf.liveTest:
            liveTest()
        else:
            start()

    except sqlmapUserQuitException:
        errMsg = "user quit"
        logger.error(errMsg)
        closeDumper(False, errMsg)

    except sqlmapSilentQuitException:
        closeDumper(False)

    except exceptionsTuple, e:
        e = getUnicode(e)
        logger.critical(e)
        closeDumper(False, e)

    except KeyboardInterrupt, _:
        print
        errMsg = "user aborted"
        logger.error(errMsg)
        closeDumper(False, errMsg)

    except EOFError, _:
        print
        errMsg = "exit"
        logger.error(errMsg)
        closeDumper(False, errMsg)

    except:
        print
        errMsg = unhandledExceptionMessage()
        logger.critical(errMsg)
        traceback.print_exc()
        closeDumper(False, errMsg)

    else:
        closeDumper(True)

    finally:
        dataToStdout("\n[*] shutting down at: %s\n\n" % time.strftime("%X"), forceOutput=True)

        kb.threadContinue = False
        kb.threadException = True

if __name__ == "__main__":
    main()
