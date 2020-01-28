@cli @skipOnLDAP @local_storage
Feature: list created local storage from the command line
  As an admin
  I want to list all created local storage from the command line
  So that I can view available local storage

  Background:
    Given the administrator has created the local storage mount "local_storage2"
    And the administrator has created the local storage mount "local_storage3"
    And the administrator has uploaded file with content "this is a file in local storage2" to "/local_storage2/file-in-local-storage.txt"
    And the administrator has uploaded file with content "this is a file in local storage3" to "/local_storage3/new-file"

  Scenario: List the created local storage
    When the administrator lists the local storage using the occ command
    Then the following local storage should be listed:
      | MountPoint      | Storage | AuthenticationType | Configuration | Options | ApplicableUsers | ApplicableGroups |
      | /local_storage  | Local   | None               | datadir:      |         | All             |                  |
      | /local_storage2 | Local   | None               | datadir:      |         | All             |                  |
      | /local_storage3 | Local   | None               | datadir:      |         | All             |                  |

  Scenario: List local storage with applicable users
    Given these users have been created with default attributes and without skeleton files:
      | username |
      | user0    |
      | user1    |
      | user2    |
    And the administrator has added user "user0" as the applicable user for local storage mount "local_storage2"
    And the administrator has added user "user1" as the applicable user for local storage mount "local_storage3"
    And the administrator has added user "user2" as the applicable user for local storage mount "local_storage3"
    When the administrator lists the local storage using the occ command
    Then the following local storage should be listed:
      | MountPoint      | Storage | AuthenticationType | Configuration | Options | ApplicableUsers | ApplicableGroups |
      | /local_storage  | Local   | None               | datadir:      |         | All             |                  |
      | /local_storage2 | Local   | None               | datadir:      |         | user0           |                  |
      | /local_storage3 | Local   | None               | datadir:      |         | user1, user2    |                  |

  Scenario: List local storage with applicable groups
    Given group "grp1" has been created
    And group "grp2" has been created
    And group "grp3" has been created
    And the administrator has added group "grp1" as the applicable group for local storage mount "local_storage2"
    And the administrator has added group "grp2" as the applicable group for local storage mount "local_storage3"
    And the administrator has added group "grp3" as the applicable group for local storage mount "local_storage3"
    When the administrator lists the local storage using the occ command
    Then the following local storage should be listed:
      | MountPoint      | Storage | AuthenticationType | Configuration | Options | ApplicableUsers | ApplicableGroups |
      | /local_storage  | Local   | None               | datadir:      |         | All             |                  |
      | /local_storage2 | Local   | None               | datadir:      |         |                 | grp1             |
      | /local_storage3 | Local   | None               | datadir:      |         |                 | grp2, grp3       |

  Scenario: List local storage with applicable users and groups
    Given these users have been created with default attributes and without skeleton files:
      | username |
      | user0    |
      | user1    |
      | user2    |
    And group "grp1" has been created
    And group "grp2" has been created
    And group "grp3" has been created
    And the administrator has added user "user0" as the applicable user for local storage mount "local_storage2"
    And the administrator has added user "user1" as the applicable user for local storage mount "local_storage3"
    And the administrator has added user "user2" as the applicable user for local storage mount "local_storage3"
    And the administrator has added group "grp1" as the applicable group for local storage mount "local_storage2"
    And the administrator has added group "grp2" as the applicable group for local storage mount "local_storage3"
    And the administrator has added group "grp3" as the applicable group for local storage mount "local_storage3"
    When the administrator lists the local storage using the occ command
    Then the following local storage should be listed:
      | MountPoint      | Storage | AuthenticationType | Configuration | Options | ApplicableUsers | ApplicableGroups |
      | /local_storage  | Local   | None               | datadir:      |         | All             |                  |
      | /local_storage2 | Local   | None               | datadir:      |         | user0           | grp1             |
      | /local_storage3 | Local   | None               | datadir:      |         | user1, user2    | grp2, grp3       |

  Scenario: Short list of local storage with applicable users and groups
    Given these users have been created with default attributes and without skeleton files:
      | username |
      | user0    |
      | user1    |
      | user2    |
    And group "grp1" has been created
    And group "grp2" has been created
    And group "grp3" has been created
    And the administrator has added user "user0" as the applicable user for local storage mount "local_storage2"
    And the administrator has added user "user1" as the applicable user for local storage mount "local_storage3"
    And the administrator has added user "user2" as the applicable user for local storage mount "local_storage3"
    And the administrator has added group "grp1" as the applicable group for local storage mount "local_storage2"
    And the administrator has added group "grp2" as the applicable group for local storage mount "local_storage3"
    And the administrator has added group "grp3" as the applicable group for local storage mount "local_storage3"
    When the administrator lists the local storage with --short using the occ command
    Then the following local storage should be listed:
      | MountPoint      | Auth | ApplicableUsers | ApplicableGroups | Type  |
      | /local_storage  | User | All             |                  | Admin |
      | /local_storage2 | User | user0           | grp1             | Admin |
      | /local_storage3 | User | user1, user2    | grp2, grp3       | Admin |