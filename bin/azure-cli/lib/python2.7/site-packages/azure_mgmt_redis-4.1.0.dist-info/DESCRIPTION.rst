Microsoft Azure SDK for Python
==============================

This is the Microsoft Azure Redis Cache Resource Management Client Library.

Azure Resource Manager (ARM) is the next generation of management APIs that
replace the old Azure Service Management (ASM).

This package has been tested with Python 2.7, 3.3, 3.4 and 3.5.

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

For code examples, see `Redis Cache Resource Management 
<https://azure-sdk-for-python.readthedocs.org/en/latest/resourcemanagementredis.html>`__
on readthedocs.org.


Provide Feedback
================

If you encounter any bugs or have suggestions, please file an issue in the
`Issues <https://github.com/Azure/azure-sdk-for-python/issues>`__
section of the project.


.. :changelog:

Release History
===============

4.1.0 (2017-04-18)
++++++++++++++++++

**Features**

- Add firewall rules operations

**Notes**

- This wheel package is now built with the azure wheel extension

4.0.0 (2017-01-13)
++++++++++++++++++

**Bugfixes**

* Fix error if patching when not exist

**Breaking change**

* `redis.update` is no longer an async operation

3.0.0 (2016-11-14)
++++++++++++++++++

**New features**

* Add "Everyday" and "Weekend" to schedule enums
* Improve technical documention

**Breaking change**

* Simplify `patch_schedules.create_or_update` parameters

2.0.0 (2016-10-20)
++++++++++++++++++

* Major bug fixes and refactoring.

1.0.0 (2016-08-09)
++++++++++++++++++

* Initial Release (API Version 2016-04-01)


