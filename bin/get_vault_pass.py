#!/usr/bin/env python

import subprocess
import sys

def main():
    pipes = subprocess.Popen(['pass', 'ansible/vault'], stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE)

    std_out, std_err = pipes.communicate()

    if std_err:
        sys.stderr.write("Got error when running 'pass ansible/vault': " + std_err) 
        sys.exit(1)
    else:
        print(std_out.rstrip().decode("utf-8"))


if __name__ == '__main__':
    main()
