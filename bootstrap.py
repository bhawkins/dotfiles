#!/usr/bin/env python

import os
import sys
import subprocess as sub
import hashlib
import shutil

noprompt = '-f' in sys.argv

os.chdir (os.path.dirname (sys.argv[0]))
sub.check_call ('git pull origin master'.split ())

def md5 (filename):
    if not os.path.exists (filename):
        return ''
    m = hashlib.md5 ()
    with open (filename) as f:
        m.update (f.read ())
    return m.digest ()

def prompt (msg):
    reply = raw_input (msg)
    return reply.lower().startswith ('y')

for root, dirs, files in os.walk (os.curdir):
    root = root[2:] # strip leading ./
    if '.git' in dirs:
        dirs.remove ('.git')

    for d in dirs:
        outdir = os.path.join (os.pardir, root, d)
        if not os.path.isdir (outdir):
            print 'Creating directory %s' % outdir
            os.mkdir (outdir)

    for newf in files:
        newf = os.path.join (root, newf)
        if not newf.startswith ('.'):
            #print "Skipping %s" % newf
            continue

        oldf = os.path.join (os.pardir, newf)
        if not os.path.exists (oldf):
            print 'Installing %s' % oldf
            shutil.copy (newf, oldf)
            continue

        if md5 (oldf) != md5 (newf):
            sub.call (['diff', '-Naur', oldf, newf])
            if noprompt or prompt ("\nReplace %s? " % newf):
                shutil.copy (newf, oldf)
        else:
            #print "%s is up to date." % newf
            pass
