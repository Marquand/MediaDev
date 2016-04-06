#!/usr/bin/env python

"""
$Id: enumeration.py 3528 2011-03-29 21:54:15Z stamparm $

Copyright (c) 2006-2010 sqlmap developers (http://sqlmap.sourceforge.net/)
See the file 'doc/COPYING' for copying permission
"""

from lib.core.agent import agent
from lib.core.common import arrayizeValue
from lib.core.common import Backend
from lib.core.common import getRange
from lib.core.common import isNumPosStrValue
from lib.core.common import isTechniqueAvailable
from lib.core.common import safeSQLIdentificatorNaming
from lib.core.common import unsafeSQLIdentificatorNaming
from lib.core.data import conf
from lib.core.data import kb
from lib.core.data import logger
from lib.core.data import queries
from lib.core.enums import EXPECTED
from lib.core.enums import PAYLOAD
from lib.core.exception import sqlmapNoneDataException
from lib.request import inject

from plugins.generic.enumeration import Enumeration as GenericEnumeration

class Enumeration(GenericEnumeration):
    def __init__(self):
        GenericEnumeration.__init__(self)

    def getPrivileges(self, *args):
        warnMsg = "on Microsoft SQL Server it is not possible to fetch "
        warnMsg += "database users privileges, sqlmap will check whether "
        warnMsg += "or not the database users are database administrators"
        logger.warn(warnMsg)

        users = []
        areAdmins = set()

        if conf.user:
            users = [ conf.user ]
        elif not len(kb.data.cachedUsers):
            users = self.getUsers()
        else:
            users = kb.data.cachedUsers

        for user in users:
            if user is None:
                continue

            isDba = self.isDba(user)

            if isDba is True:
                areAdmins.add(user)

            kb.data.cachedUsersPrivileges[user] = None

        return ( kb.data.cachedUsersPrivileges, areAdmins )

    def getTables(self):
        infoMsg = "fetching tables"
        if conf.db:
            infoMsg += " for database '%s'" % conf.db
        logger.info(infoMsg)

        rootQuery = queries[Backend.getIdentifiedDbms()].tables

        if not conf.db:
            if not len(kb.data.cachedDbs):
                dbs = self.getDbs()
            else:
                dbs = kb.data.cachedDbs
        else:
            if "," in conf.db:
                dbs = conf.db.split(",")
            else:
                dbs = [conf.db]

        if isTechniqueAvailable(PAYLOAD.TECHNIQUE.UNION) or isTechniqueAvailable(PAYLOAD.TECHNIQUE.ERROR) or conf.direct:
            for db in dbs:
                db = safeSQLIdentificatorNaming(db)

                if conf.excludeSysDbs and db in self.excludeDbsList:
                    infoMsg = "skipping system database '%s'" % db
                    logger.info(infoMsg)

                    continue

                query = rootQuery.inband.query % db
                value = inject.getValue(query, blind=False)

                if value:
                    kb.data.cachedTables[db] = arrayizeValue(value)

        if not kb.data.cachedTables and not conf.direct:
            for db in dbs:
                db = safeSQLIdentificatorNaming(db)

                if conf.excludeSysDbs and db in self.excludeDbsList:
                    infoMsg = "skipping system database '%s'" % db
                    logger.info(infoMsg)

                    continue

                infoMsg  = "fetching number of tables for "
                infoMsg += "database '%s'" % db
                logger.info(infoMsg)

                query = rootQuery.blind.count % db
                count = inject.getValue(query, inband=False, error=False, charsetType=2)

                if not isNumPosStrValue(count):
                    warnMsg  = "unable to retrieve the number of "
                    warnMsg += "tables for database '%s'" % db
                    logger.warn(warnMsg)
                    continue

                tables = []

                for index in range(int(count)):
                    query = rootQuery.blind.query % (db, index, db)
                    table = inject.getValue(query, inband=False, error=False)
                    tables.append(table)
                    kb.hintValue = table

                if tables:
                    kb.data.cachedTables[db] = tables
                else:
                    warnMsg  = "unable to retrieve the tables "
                    warnMsg += "for database '%s'" % db
                    logger.warn(warnMsg)

        if not kb.data.cachedTables:
            errMsg = "unable to retrieve the tables for any database"
            raise sqlmapNoneDataException(errMsg)

        return kb.data.cachedTables

    def searchTable(self):
        rootQuery = queries[Backend.getIdentifiedDbms()].search_table
        foundTbls = {}
        tblList = conf.tbl.split(",")
        tblCond = rootQuery.inband.condition
        dbCond = rootQuery.inband.condition2

        tblConsider, tblCondParam = self.likeOrExact("table")

        if not len(kb.data.cachedDbs):
            enumDbs = self.getDbs()
        else:
            enumDbs = kb.data.cachedDbs

        for db in enumDbs:
            if isinstance(db, list):
                db = db[0]

            db = safeSQLIdentificatorNaming(db)
            foundTbls[db] = []

        for tbl in tblList:
            tbl = safeSQLIdentificatorNaming(tbl, True)

            infoMsg = "searching table"
            if tblConsider == "1":
                infoMsg += "s like"
            infoMsg += " '%s'" % unsafeSQLIdentificatorNaming(tbl)
            logger.info(infoMsg)

            tblQuery = "%s%s" % (tblCond, tblCondParam)
            tblQuery = tblQuery % unsafeSQLIdentificatorNaming(tbl)

            for db in foundTbls.keys():
                db = safeSQLIdentificatorNaming(db)

                if conf.excludeSysDbs and db in self.excludeDbsList:
                    infoMsg = "skipping system database '%s'" % db
                    logger.info(infoMsg)

                    continue

                if isTechniqueAvailable(PAYLOAD.TECHNIQUE.UNION) or isTechniqueAvailable(PAYLOAD.TECHNIQUE.ERROR) or conf.direct:
                    query = rootQuery.inband.query % db
                    query += tblQuery
                    values = inject.getValue(query, blind=False)

                    if values:
                        if isinstance(values, basestring):
                            values = [ values ]

                        for foundTbl in values:
                            if foundTbl is None:
                                continue

                            foundTbls[db].append(foundTbl)
                else:
                    infoMsg = "fetching number of table"
                    if tblConsider == "1":
                        infoMsg += "s like"
                    infoMsg += " '%s' in database '%s'" % (unsafeSQLIdentificatorNaming(tbl), unsafeSQLIdentificatorNaming(db))
                    logger.info(infoMsg)

                    query = rootQuery.blind.count2
                    query = query % db
                    query += " AND %s" % tblQuery
                    count = inject.getValue(query, inband=False, error=False, expected=EXPECTED.INT, charsetType=2)

                    if not isNumPosStrValue(count):
                        warnMsg = "no table"
                        if tblConsider == "1":
                            warnMsg += "s like"
                        warnMsg += " '%s' " % unsafeSQLIdentificatorNaming(tbl)
                        warnMsg += "in database '%s'" % unsafeSQLIdentificatorNaming(db)
                        logger.warn(warnMsg)

                        continue

                    indexRange = getRange(count)

                    for index in indexRange:
                        query = rootQuery.blind.query2
                        query = query % db
                        query += " AND %s" % tblQuery
                        query = agent.limitQuery(index, query, tblCond)
                        tbl = inject.getValue(query, inband=False, error=False)
                        kb.hintValue = tbl
                        foundTbls[db].append(tbl)

        for db, tbls in foundTbls.items():
            if len(tbls) == 0:
                foundTbls.pop(db)

        return foundTbls

    def searchColumn(self):
        rootQuery = queries[Backend.getIdentifiedDbms()].search_column
        foundCols = {}
        dbs = {}
        colList = conf.col.split(",")
        colCond = rootQuery.inband.condition
        colConsider, colCondParam = self.likeOrExact("column")

        if not len(kb.data.cachedDbs):
            enumDbs = self.getDbs()
        else:
            enumDbs = kb.data.cachedDbs

        for db in enumDbs:
            db = safeSQLIdentificatorNaming(db)
            dbs[db] = {}

        for column in colList:
            column = safeSQLIdentificatorNaming(column)

            infoMsg = "searching column"
            if colConsider == "1":
                infoMsg += "s like"
            infoMsg += " '%s'" % unsafeSQLIdentificatorNaming(column)
            logger.info(infoMsg)

            foundCols[column] = {}

            colQuery = "%s%s" % (colCond, colCondParam)
            colQuery = colQuery % unsafeSQLIdentificatorNaming(column)

            for db in dbs.keys():
                db = safeSQLIdentificatorNaming(db)

                if conf.excludeSysDbs and db in self.excludeDbsList:
                    infoMsg = "skipping system database '%s'" % db
                    logger.info(infoMsg)

                    continue

                if isTechniqueAvailable(PAYLOAD.TECHNIQUE.UNION) or isTechniqueAvailable(PAYLOAD.TECHNIQUE.ERROR) or conf.direct:
                    query = rootQuery.inband.query % (db, db, db, db, db, db)
                    query += " AND %s" % colQuery.replace("[DB]", db)
                    values = inject.getValue(query, blind=False)

                    if values:
                        if isinstance(values, basestring):
                            values = [ values ]

                        for foundTbl in values:
                            foundTbl = safeSQLIdentificatorNaming(foundTbl, True)

                            if foundTbl is None:
                                continue

                            if foundTbl not in dbs[db]:
                                dbs[db][foundTbl] = {}

                            if colConsider == "1":
                                conf.db = db
                                conf.tbl = foundTbl
                                conf.col = column

                                self.getColumns(onlyColNames=True)
                                if kb.data.cachedColumns[db][foundTbl] != {None: None}:
                                    dbs[db][foundTbl].update(kb.data.cachedColumns[db][foundTbl])
                                kb.data.cachedColumns = {}
                            else:
                                dbs[db][foundTbl][column] = None

                            if db in foundCols[column]:
                                foundCols[column][db].append(foundTbl)
                            else:
                                foundCols[column][db] = [ foundTbl ]
                else:
                    foundCols[column][db] = []

                    infoMsg = "fetching number of tables containing column"
                    if colConsider == "1":
                        infoMsg += "s like"
                    infoMsg += " '%s' in database '%s'" % (column, db)
                    logger.info(infoMsg)

                    query = rootQuery.blind.count2
                    query = query % (db, db, db, db, db, db)
                    query += " AND %s" % colQuery.replace("[DB]", db)
                    count = inject.getValue(query, inband=False, error=False, expected=EXPECTED.INT, charsetType=2)

                    if not isNumPosStrValue(count):
                        warnMsg = "no tables contain column"
                        if colConsider == "1":
                            warnMsg += "s like"
                        warnMsg += " '%s' " % column
                        warnMsg += "in database '%s'" % db
                        logger.warn(warnMsg)

                        continue

                    indexRange = getRange(count)

                    for index in indexRange:
                        query = rootQuery.blind.query2
                        query = query % (db, db, db, db, db, db)
                        query += " AND %s" % colQuery.replace("[DB]", db)
                        query = agent.limitQuery(index, query, colCond.replace("[DB]", db))
                        tbl = inject.getValue(query, inband=False, error=False)
                        kb.hintValue = tbl

                        tbl = safeSQLIdentificatorNaming(tbl, True)

                        if tbl not in dbs[db]:
                            dbs[db][tbl] = {}

                        if colConsider == "1":
                            conf.db = db
                            conf.tbl = tbl
                            conf.col = column

                            self.getColumns(onlyColNames=True)

                            dbs[db][tbl].update(kb.data.cachedColumns[db][tbl])
                            kb.data.cachedColumns = {}
                        else:
                            dbs[db][tbl][column] = None

                        foundCols[column][db].append(tbl)

        self.dumpFoundColumn(dbs, foundCols, colConsider)
