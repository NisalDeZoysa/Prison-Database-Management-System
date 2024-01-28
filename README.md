Prison Management System Database
Overview
This database is designed to manage and store information for a prison management system. It includes details about prisoners, visitors, officers, court cases, medical records, and other related entities.

Tables
PRISONER: Stores details about prisoners including ID, name, gender, age, and punishment period.
VISITOR: Information about visitors, including their ID, name, gender, and connectivity.
VISITOR_MOBILENO: Stores visitor's mobile numbers.
VISITOR_VISITS_PRISONER: Records sessions between prisoners and visitors.
PARCELL: Information about parcels received including ID, name, type, weight, and arrival time.
VISITOR_BELONGINGS: Tracks belongings of visitors.
CELL: Details about cells including ID, capacity, and bed count.
WING: Information about different wings in the prison.
OFFICER: Stores officer details including ID, type, level, name, age, gender, and experience.
OFFICER_MOBILE_NUMBERS: Mobile numbers of officers.
CaseOnGoing: Ongoing cases with details like ID, name, police area, and type.
PRISONER_INVOLVE_CASE: Records cases that prisoners are involved in.
VICTIM: Details of victims related to cases.
COURT: Information about courts including ID, name, and district.
COURT_ADDRESS: Addresses of courts.
LAWYER: Information about lawyers including ID, name, and level.
LAWYER_MOBILENO: Mobile numbers of lawyers.
CASE_INCONTROL_LAWYER: Lawyers in control of cases.
MEDICAL_RECORD: Medical records of prisoners.
MEDICAL_RECORD_MEDICATIONS: Medications recorded in medical records.
Relationships
Foreign key constraints are used to establish relationships between tables, ensuring data integrity. For example, prisoners are linked to cells, visitors to parcels, and officers to wings.

Usage
This database is intended for use in prison management systems for storing and retrieving data related to prisoners, staff, and visitors. It enables the management of various aspects of a prison facility, including legal cases, medical records, and visitations.
