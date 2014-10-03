=== Introduction ===

This is a port to Python of the following git script:

https://gist.github.com/tvogel/894374

=== Required Software ===

- Python (2.7.x)
- Git (1.9.x)
- Bash

=== Testing ===

To create a test repository run the test.sh script

```
./test.sh
``` 

This creates a repo which will be in a branched state that will fail on a rebase due to a rename conflict.

=== Using the script ===

To use the script move it to a location where git is aware of it and it should be accessible through git

```
git merge-associate <TARGET_FILE> :1:<REMOVED_FILE_NAME> :2:<REMOVED_FILE_NAME>
```
