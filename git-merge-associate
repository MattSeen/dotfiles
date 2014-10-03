import subprocess
import argparse
import re
import sys
from types import *
from datetime import datetime

parser = argparse.ArgumentParser(description='Do a merge thing.')

parser.add_argument('data', nargs=3, type=str)
# parser.add_argument('--filename', type=str, required=True)
# parser.add_argument('--base', type=str, required=True)
# parser.add_argument('--theirs', type=str, required=True)


DEBUG = True
TREE_INDEX_NUMBER_PATTERN = re.compile('^:(.):')
BASENAME_PATTERN = re.compile('^:\d:(.*)')

class Result_object(object):
    """docstring for Result_object"""
    def __init__(self, spec, tree, basename, mode, sha):
        super(Result_object, self).__init__()
        self.spec = spec
        self.tree =tree
        self.basename = basename
        self.mode = mode
        self.sha = sha

    def getIndexValue(self):
        return re.match("INDEX:(.)", self.tree).group(1)

    def __str__(self):
        return self.basename + "\n" + \
            self.mode + "\n" + \
            self.sha 

def log(*arg):
    if DEBUG:
        for a in arg:
            print a

def fail_script():
    sys.exit(-1)

def execute(command, data = ""):
    log("About to execute: ", command)
    try:
        if not type(command) is ListType:
            raise Exception("command should be array of strings")
        proc = subprocess.Popen(command, stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    except Exception, e:
        print e
        fail_script()

    if data != "":
        (std_out, std_err) = proc.communicate(input=data)
    else:
        (std_out, std_err) = proc.communicate()
    
    log("Executed command output: \n", std_out)
    log("STDIN data was \n", data)
    if std_err:
        log("ERROR: ", std_err)
        fail_script()

    return std_out, std_err

def get_tree(spec):

    TREE = ""
    index_no = TREE_INDEX_NUMBER_PATTERN.match(spec)
    file_base_name = BASENAME_PATTERN.match(spec)

    if not spec:
        TREE = "EMPTY"
    elif index_no:
        TREE = "INDEX:" + index_no.group(1)
        BASENAME = file_base_name.group(1)
    else: # no colon present
        BASENAME = spec
        spec = "HEAD:" + spec
        TREE = "HEAD"

    return spec, TREE, BASENAME

def get_mode_and_sha(spec, tree, basename):
    
    result_mode = ""
    result_sha = ""

    if tree == "":
        result_mode = "100644"
        result_sha = "e69de29bb2d1d6434b8b29ae775ad8c2e48c5391"
    elif "INDEX:" in tree:
        out, err = execute(["git", "ls-files", "--stage", basename])
        tree_references = out.strip().replace("\t", " ").split("\n")

        current_index = []
        for element in tree_references:
            array = element.split(" ")
            if array[2] == re.match("INDEX:(.)", tree).group(1):
                current_index = array
            else:
                if DEBUG: log("INDEX was (Just so you know):", re.match("INDEX:(.)", tree).group(1))

        if not current_index:
            log("Big Problem?:", array)
            log("current_index: ", current_index)
            fail_script()
            
        result_mode = current_index[0]
        result_sha = current_index[1]
    elif tree:
        out, err = execute(["git", "ls-tree", tree, basename])
        array = out.replace("\t", " ").split(" ")
        result_mode = array[0]
        result_sha = array[2]

    return result_mode, result_sha

def update_git_index(TARGET, BASE, THEIRS):

    stdin = """000000 0000000000000000000000000000000000000000 0	{0}
{1} {2} 1	{0}
{3} {4} 2	{0}
{5} {6} 3	{0}
""".format(TARGET.basename, BASE.mode, BASE.sha, TARGET.mode, TARGET.sha, 
    THEIRS.mode, THEIRS.sha)

    log(stdin)
    out, err = execute(["git", "update-index", "--index-info"], stdin)

    if err:
        log("ERRORERRORERRORERRORERROR")
        log(err)
        fail_script()

    execute(["git", "checkout", "-m", "--", TARGET.basename])

def main(data):

    current_time = str(datetime.now())
    print "-" * len(current_time)
    print current_time
    print "-" * len(current_time)
    print ""

    # Validate inputs

    TARGET = ""
    BASE = ""
    THEIRS = ""

    for VAR in data:
        spec, tree, basename = get_tree(VAR)
        mode, sha = get_mode_and_sha(spec, tree, basename)

        if type(TARGET) is StringType:
            TARGET = Result_object(spec, tree, basename, mode, sha)
        elif type(BASE) is StringType:
            BASE = Result_object(spec, tree, basename, mode, sha)
        elif type(THEIRS) is StringType:
            THEIRS = Result_object(spec, tree, basename, mode, sha)

    update_git_index(TARGET, BASE, THEIRS)

if __name__ == '__main__':
    args = parser.parse_args()
    main(args.data)
