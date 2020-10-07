@api @files_sharing-app-required @issue-ocis-reva-243
Feature: resharing can be disabled

  Background:
    Given the administrator has set the default folder for received shares to "Shares"
    And auto-accept shares has been disabled
    And user "Alice" has been created with default attributes and skeleton files
    And user "Brian" has been created with default attributes and without skeleton files

  @smokeTest
  Scenario Outline: resharing a file is not allowed when allow resharing has been disabled
    Given using OCS API version "<ocs_api_version>"
    And user "Carol" has been created with default attributes and without skeleton files
    And user "Alice" has shared file "/textfile0.txt" with user "Brian" with permissions "share,update,read"
    And user "Brian" has accepted share "/textfile0.txt" offered by user "Alice"
    And parameter "shareapi_allow_resharing" of app "core" has been set to "no"
    When user "Brian" shares file "/Shares/textfile0.txt" with user "Carol" with permissions "share,update,read" using the sharing API
    Then the OCS status code should be "404"
    And the HTTP status code should be "<http_status_code>"
    And as "Carol" file "/Shares/textfile0.txt" should not exist
    Examples:
      | ocs_api_version | http_status_code |
      | 1               | 200              |
      | 2               | 404              |

  Scenario Outline: ordinary sharing is allowed when allow resharing has been disabled
    Given using OCS API version "<ocs_api_version>"
    And parameter "shareapi_allow_resharing" of app "core" has been set to "no"
    When user "Alice" shares file "/textfile0.txt" with user "Brian" with permissions "share,update,read" using the sharing API
    Then the OCS status code should be "<ocs_status_code>"
    And the HTTP status code should be "200"
    When user "Brian" has accepted share "/textfile0.txt" offered by user "Alice"
    Then the OCS status code should be "<ocs_status_code>"
    And the HTTP status code should be "200"
    And as "Brian" file "/Shares/textfile0.txt" should exist
    Examples:
      | ocs_api_version | ocs_status_code |
      | 1               | 100             |
      | 2               | 200             |
