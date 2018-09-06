Microsoft Azure SDK for Python
==============================

This is the Microsoft Azure Graph RBAC Client Library.

Azure Resource Manager (ARM) is the next generation of management APIs that
replace the old Azure Service Management (ASM).

This package has been tested with Python 2.7, 3.3, 3.4, 3.5 and 3.6.

For the older Azure Service Management (ASM) libraries, see
`azure-servicemanagement-legacy <https://pypi.python.org/pypi/azure-servicemanagement-legacy>`__ library.

For a more complete set of Azure libraries, see the `azure <https://pypi.python.org/pypi/azure>`__ bundle package.


Compatibility
=============

**IMPORTANT**: If you have an earlier version of the azure package
(version < 1.0), you should uninstall it before installing this package.

You can check the version using pip:

.. code:: shell

    pip freeze

If you see azure==0.11.0 (or any version below 1.0), uninstall it first:

.. code:: shell

    pip uninstall azure


Usage
=====

For code examples, see `Graph RBAC Resource Management 
<https://azure-sdk-for-python.readthedocs.org/en/latest/graphrbac.html>`__
on readthedocs.org.


Provide Feedback
================

If you encounter any bugs or have suggestions, please file an issue in the
`Issues <https://github.com/Azure/azure-sdk-for-python/issues>`__
section of the project.


.. :changelog:

Release History
===============

0.31.0 (2017-08-09)
+++++++++++++++++++

- Add domains operation group
- Add usage locations to user
- Add several new attributes to AADObject

0.30.0 (2017-04-20)
+++++++++++++++++++

* ApiVersion is now 1.6 for the whole package
* This wheel package is now built with the azure wheel extension

0.30.0rc6 (2016-09-14)
++++++++++++++++++++++

**Bugfixes**

* 'list' methods returned only 100 entries (#653)

0.30.0rc5 (2016-06-23)
++++++++++++++++++++++

* Initial preview release


