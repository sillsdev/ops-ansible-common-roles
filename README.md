# Common Roles for Ansible

This repository contains a collection of roles that are useful for debian and ubuntu internet server deployments.

No doubt there are other implementations around on Github and Ansible Galaxy for the roles that you will find here.  So, why have we rolled our own, and made Yet Another Implementation?  Here's the values that we have for our Ansible roles:

 1. Roles should not necessarily support all features that an application supports, rather the config file or template should closely resemble the default install of the application, with parameters for those variables that are commonly configured by users of these roles (mostly us).

 1. Roles should be able to be used stand-alone.  Roles should not rely on other roles to setup any dependent state.  We are not presenting these roles as parts of a cohesive system, rather each role should add value in its own right.

1. We separate installation from configuration.  Installation is done once, configuration happens often.  Continual checking for installation as a pre-requistite is an unwelcome waste of time.

1. Where there is another role available on github with a similar ethos we will happily contribute to such a project rather than re-inventing the wheel.

## About the Roles

Roles for installation are in folders named `_install`. Roles for configuration are in folders named `_config`.  Many roles have a test sub-folder that contains a vagrant test setup.

## License

Licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
