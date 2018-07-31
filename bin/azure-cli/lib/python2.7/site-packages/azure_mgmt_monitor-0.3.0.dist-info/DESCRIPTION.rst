Microsoft Azure SDK for Python
==============================

This is the Microsoft Azure Monitor Management Client Library.

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

For code examples, see `Monitor Management
<https://azure-sdk-for-python.readthedocs.org/en/latest/sample_azure-mgmt-monitor.html>`__
on readthedocs.org.


Provide Feedback
================

If you encounter any bugs or have suggestions, please file an issue in the
`Issues <https://github.com/Azure/azure-sdk-for-python/issues>`__
section of the project.


.. :changelog:

Release History
===============

0.3.0 (2017-06-30)
++++++++++++++++++

**Features**

- Add action_groups operation group
- Add alert_rules.update method
- Add autoscale_settings.update method
- Add log_profiles.update method

**Breaking changes**

- activity_log_alerts.update has now flatten parameters "tags/enabled"

0.2.1 (2017-04-26)
++++++++++++++++++

* Removal of a REST endpoint not ready to release.

0.2.0 (2017-04-19)
++++++++++++++++++

* Add ActivityLogAlerts and DiagnosticSettings
* Minor improvements, might be breaking
* This wheel package is now built with the azure wheel extension

0.1.0 (2017-02-16)
++++++++++++++++++

* Initial Release


