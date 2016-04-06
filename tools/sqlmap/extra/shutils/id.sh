#!/bin/bash

# $Id: id.sh 2616 2010-12-09 12:41:16Z stamparm $

# Copyright (c) 2006-2010 sqlmap developers (http://sqlmap.sourceforge.net/)
# See the file 'doc/COPYING' for copying permission

# Adds SVN property 'Id' to project files
find ../../. -type f -name "*.py" -exec svn propset svn:keywords "Id" '{}' \;
