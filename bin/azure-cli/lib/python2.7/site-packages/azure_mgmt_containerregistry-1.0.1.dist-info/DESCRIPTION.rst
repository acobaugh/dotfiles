Microsoft Azure SDK for Python
==============================

This is the Microsoft Azure Container Registry Client Library.

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

For code examples, see `Container Registry
<https://azure-sdk-for-python.readthedocs.org/en/latest/sample_azure-mgmt-containerregistry.html>`__
on readthedocs.org.


Provide Feedback
================

If you encounter any bugs or have suggestions, please file an issue in the
`Issues <https://github.com/Azure/azure-sdk-for-python/issues>`__
section of the project.


.. :changelog:

Release History
===============

1.0.1 (2017-10-09)
++++++++++++++++++

* Rename Managed_Basic, Managed_Standard, Managed_Premium to Basic, Standard, Premium.

1.0.0 (2017-09-22)
++++++++++++++++++

* New default API version 2017-10-01.
* Remove support for API Version 2017-06-01-preview
* New support for managed registries with three Managed SKUs.
* New support for registry webhooks and replications.
* Rename Basic SKU to Classic SKU.

0.3.1 (2017-06-30)
++++++++++++++++++

* Support for registry SKU update (2017-06-01-preview)
* New listUsages API to get the quota usages for a container registry (2017-06-01-preview)

0.3.0 (2017-06-15)
++++++++++++++++++

* This package now supports an additional ApiVersion 2017-06-01-preview

0.2.1 (2017-04-20)
++++++++++++++++++

This wheel package is now built with the azure wheel extension

0.2.0 (2017-03-20)
++++++++++++++++++

* New ApiVersion 2017-03-01
* Update getCredentials to listCredentials to support multiple login credentials.
* Refine regenerateCredential to support regenerate the specified login credential.
* Add Sku to registry properties as a required property.
* Rename GetProperties to Get.
* Change CreateOrUpdate to Create, add registry create parameters.

0.1.1 (2016-12-12)
++++++++++++++++++

**Bugfixes**

* Fix random error on Create and Delete operation

0.1.0 (2016-11-04)
++++++++++++++++++

* Initial Release


