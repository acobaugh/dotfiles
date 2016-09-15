if did_filetype()
 finish
endif
if search('^#\s*vim:\s*set\s*syntax=cfengine')
 setf cfengine
endif

