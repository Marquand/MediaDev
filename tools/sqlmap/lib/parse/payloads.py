#!/usr/bin/env python

"""
$Id: payloads.py 2480 2010-12-03 10:51:27Z inquisb $

Copyright (c) 2006-2010 sqlmap developers (http://sqlmap.sourceforge.net/)
See the file 'doc/COPYING' for copying permission
"""

from xml.etree import ElementTree as et

from lib.core.data import conf
from lib.core.data import paths
from lib.core.datatype import advancedDict

def cleanupVals(text, tag):
    if tag in ("clause", "where"):
        text = text.split(',')

    if isinstance(text, basestring):
        if text.isdigit():
            text = int(text)
        else:
            text = str(text)

    elif isinstance(text, list):
        count = 0

        for t in text:
            if t.isdigit():
                t = int(t)
            else:
                t = str(t)

            text[count] = t
            count += 1

        if len(text) == 1 and tag not in ("clause", "where"):
            text = text[0]

    return text

def parseXmlNode(node):
    for element in node.getiterator('boundary'):
        boundary = advancedDict()

        for child in element.getchildren():
            if child.text:
                values = cleanupVals(child.text, child.tag)
                boundary[child.tag] = values
            else:
                boundary[child.tag] = None

        conf.boundaries.append(boundary)

    for element in node.getiterator('test'):
        test = advancedDict()

        for child in element.getchildren():
            if child.text and child.text.strip():
                values = cleanupVals(child.text, child.tag)
                test[child.tag] = values
            else:
                if len(child.getchildren()) == 0:
                    test[child.tag] = None
                    continue
                else:
                    test[child.tag] = advancedDict()

                for gchild in child.getchildren():
                    if gchild.tag in test[child.tag]:
                        prevtext = test[child.tag][gchild.tag]
                        test[child.tag][gchild.tag] = [prevtext, gchild.text]
                    else:
                        test[child.tag][gchild.tag] = gchild.text

        conf.tests.append(test)

def loadPayloads():
    doc = et.parse(paths.PAYLOADS_XML)
    root = doc.getroot()
    parseXmlNode(root)
