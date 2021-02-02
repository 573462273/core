@api @notToImplementOnOCIS
Feature: current oC10 behavior for issue-38378
  This is the current behaviour in owncloud10
  After issue #34365 is fixed delete this file and un-skip the tests from apiAuthWebDav/webDavSpecialURLs.feature

  Background:
    Given user "Alice" has been created with default attributes and without skeleton files
    And user "Alice" has uploaded file with content "some data" to "/textfile0.txt"
    And user "Alice" has uploaded file with content "some data" to "/textfile1.txt"
    And user "Alice" has created folder "/PARENT"
    And user "Alice" has created folder "/FOLDER"
    And user "Alice" has uploaded file with content "some data" to "/PARENT/parent.txt"


  Scenario: send POST requests to webDav endpoints
    When user "Alice" requests these endpoints with "POST" including body "doesnotmatter" using password "%regular%" about user "Alice"
      | endpoint                                            |
      | /remote.php//dav/files/%username%/PARENT/parent.txt |
    Then the HTTP status code of responses on all endpoints should be "500"