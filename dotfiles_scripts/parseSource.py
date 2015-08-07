#!/usr/bin/env python

import argparse
parser = argparse.ArgumentParser(description='Parse source code for patterns')

parser.add_argument('-f', action="store", dest="filename", help="source code file you wish to parse",
    required=True)
parser.add_argument('--version', action='version', version='%(prog)s 0.1')

def main(filename):
    print "filename value:", filename

if __name__ == '__main__':
    results = parser.parse_args()
    main(results.filename)
