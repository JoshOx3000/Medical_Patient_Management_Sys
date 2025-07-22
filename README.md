# Medical_Patient_Management_Sys
SQL-based database is designed to manage patients, doctors, visits, treatments, and billing in a healthcare setting

🏥 Patient Management System – SQL Database for Hospitals
📌 Project Overview

The Patient Management System is a relational SQL database designed for hospitals and healthcare facilities to manage critical information about patients, doctors, medical visits, treatments, prescriptions, and billing. This project demonstrates core concepts of database design, normalization, indexing, and stored procedures to simulate real-world healthcare workflows.

🧱 Database Structure
Database Name: Patient_Management_SysDB

This database contains the following tables:

Table	Description

Patients	Stores patient demographics and insurance information
Doctors	Contains doctor contact details and specialties
Visits	Logs medical visits with reasons and diagnoses
Treatments	Details treatments associated with each visit
Medications	Holds reference data on available medications and side effects
Prescriptions	Links visits to medications and dosage instructions
Billing	Tracks cost, payment status, and insurance coverage for each visit

🔄 Relationships (Foreign Keys)
Visits.PatientID → Patients.PatientID

Visits.DoctorID → Doctors.DoctorID

Treatments.VisitID → Visits.VisitID

Prescriptions.VisitID → Visits.VisitID

Prescriptions.MedicationID → Medications.MedicationID

Billing.VisitID → Visits.VisitID

🧪 Sample Dummy Data
Dummy data is inserted into all major tables (patients, doctors, visits, treatments, medications, prescriptions, and billing) to simulate real-life scenarios such as:

Medical visits and diagnoses

Treatments with associated costs

Medication prescriptions and side effects

Billing records including pending and insurance statuses

🚀 Key Features
✅ Stored Procedures
Efficient, reusable procedures for core business operations:

GetPatientVisitHistory: Fetch complete visit, treatment, and prescription history for a patient.

AddVisitWithTreatmentAndBilling: Inserts a visit, treatment, and billing record in one transaction.

GetOutstandingBills: Lists patients with pending or insurance-covered bills.

UpdatePaymentStatus: Updates payment status of a visit’s billing record.

GetTopPrescribedMedications: Displays the most frequently prescribed medications.

✅ Indexes for Performance
Indexing added to frequently queried columns:

Visits.PatientID, Visits.DoctorID, Visits.VisitDate

Prescriptions.VisitID, Prescriptions.MedicationID

Billing.VisitID, Billing.PaymentStatus

Treatments.VisitID

💡 How to Use
Open the SQL file in SQL Server Management Studio (SSMS).

Execute the script in order:

Create the database and tables

Insert dummy data

Create indexes

Create stored procedures

Use the EXEC command to test stored procedures. Example:

sql
Copy
Edit
EXEC GetPatientVisitHistory @PatientID = 1;
📂 Use Cases for Practice
Data analytics and reporting (e.g., total costs by patient or doctor)

Writing JOIN queries and filtering by billing status or diagnoses

Performance tuning with execution plans

Building dashboards using Power BI or Tableau connected to this database

🔧 Future Enhancements (Optional Ideas)
Add audit logging for changes in billing and prescriptions.

Create triggers for automated updates (e.g., marking visit complete).

Introduce role-based access (admin vs. nurse vs. billing staff).

Add JSON/XML export procedures for EMR integration.

👨‍⚕️ Built By Joshua Oxner
Designed and developed as a portfolio project to demonstrate SQL database development skills in a healthcare context.

