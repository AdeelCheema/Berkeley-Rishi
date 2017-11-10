Feature: Provide editing capabilities to an executive Project Rishi member.
  
  As an executive Project Rishi member,
  so that I can edit markers involving wards and committees,
  I should have editing privileges with regards to markers.
  
Background: Wards, Committees, and Coordinates in database
  Given the following wards exist:
    | name   | ward_lat | ward_long |
    | Ward 1 | 30.62342 | 71.234123 |
    | Ward 2 | 31.52342 | 71.512341 |
  
  Given the following comittees exist:
    | name                |
    | Education           |
    | Rainwater Harvesting|
  
Scenario: Inserting a marker for a ward
  Given I am logged in as an executive user
  And I am on the Map Editing page
  When I add a marker to "Ward 1"
  Then "Ward 1" should contain the marker in its coordinates
  
Scenario: Deleting a marker for a ward
  Given I am logged in as an executive user
  And I am on the Map Editing page
  When I delete a marker from "Ward 2"
  Then "Ward 2" should not contain the marker in its coordinates
  
Scenario: Inserting a marker for a committee
  Given I am logged in as an executive user
  And I am on the Map Editing page
  When I add a marker to "Education"
  Then "Education" should contain the marker in its coordinates
  
Scenario: Deleting a marker for a committee
  Given I am logged in as an executive user
  And I am on the Map Editing page
  When I delete a marker from "Rainwater Harvesting"
  Then "Rainwater Harvesting" should not contain the marker in its coordinates
  
Scenario: Editing a marker's latitude
  Given I am logged in as an executive user
  And I am on the Map Editing page
  When I edit the latitude of a coordinate in "Ward 1"
  Then that coordinate for "Ward 1" should have an updated latitude on the map
  
Scenario: Editing a marker's longitude
  Given I am logged in as an executive user
  And I am on the Map Editing page
  When I edit the longitude of a coordinate in "Ward 2"
  Then that coordinate for "Ward 2" should have an updated longitude on the map
  
  
 
  
 
  
  
  