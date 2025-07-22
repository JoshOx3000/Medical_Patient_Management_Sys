-- Creation of the Database
CREATE DATABASE Patient_Management_SysDB;

USE Patient_Management_SysDB;

-- Creation of Tables for the database

-- Creation of Patients Table
CREATE TABLE Patients(
	PatientID INT PRIMARY KEY IDENTITY(1,1),
	FullName VARCHAR(100),
	DOB DATE,
	Gender VARCHAR(10),
	ContactInfo VARCHAR(150),
	InsuranceID VARCHAR(50)
);


-- Creation of Doctors Table
CREATE TABLE Doctors(
	DoctorID INT PRIMARY KEY IDENTITY(1,1),
	FullName VARCHAR(100),
	Speciality VARCHAR(50),
	ContactInfo VARCHAR(150)
);


-- Creation of Visits Table
CREATE TABLE Visits(
	VisitID INT PRIMARY KEY IDENTITY(1,1),
	PatientID INT,
	DoctorID INT,
	VisitDate DATETIME,
	Reason VARCHAR(255),
	Diagnosis VARCHAR(255),
	FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
	FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Creation of Treatments Table
CREATE TABLE Treatments(
	TreatmentID INT PRIMARY KEY IDENTITY(1,1),
	VisitID INT,
	TreatmentType VARCHAR(100),
	Notes VARCHAR(255),
	Cost DECIMAL(10,2),
	FOREIGN KEY (VisitID) REFERENCES Visits(VisitID)
);


-- Creation of Medications Table
CREATE TABLE Medications(
	MedicationID INT PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(100),
	Dosage VARCHAR(50),
	SideEffects VARCHAR(255)
);

-- Creation of Prescriptions Table
CREATE TABLE Prescriptions(
	PrescriptionID INT PRIMARY KEY IDENTITY(1,1),
	VisitID INT,
	MedicationID INT,
	Quantity INT,
	Instructions VARCHAR(255),
	FOREIGN KEY (VisitID) REFERENCES Visits(VisitID),
	FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID)
);


-- Creation of Billing Table
CREATE TABLE Billing(
	BillingID INT PRIMARY KEY IDENTITY(1,1),
	VisitID INT,
	TotalCost DECIMAL(10,2),
	PaymentStatus VARCHAR(50), --Ex: Paid, Pending, Insurance,
	InsuranceCovered BIT,
	FOREIGN KEY (VisitID) REFERENCES Visits(VisitID)
);


--- Insert of Dummy Data

-- Insert Patients
INSERT INTO Patients (FullName, DOB, Gender, ContactInfo, InsuranceID)
VALUES 
('John Smith', '1985-03-25', 'Male', 'john.smith@example.com, 555-1111', 'INS-1234'),
('Emily Johnson', '1990-07-14', 'Female', 'emily.johnson@example.com, 555-2222', 'INS-5678'),
('Michael Brown', '1978-12-09', 'Male', 'michael.brown@example.com, 555-3333', 'INS-9101'),
('Sarah Davis', '2000-02-22', 'Female', 'sarah.davis@example.com, 555-4444', 'INS-1213'),
('James Wilson', '1965-05-30', 'Male', 'james.wilson@example.com, 555-5555', 'INS-1415')
;

-- Insert Doctors
INSERT INTO Doctors (FullName, Speciality, ContactInfo)
VALUES 
('Dr. Alice Green', 'Cardiology', 'alice.green@hospital.com, 555-1000'),
('Dr. Robert White', 'Neurology', 'robert.white@hospital.com, 555-1001'),
('Dr. Karen Taylor', 'Pediatrics', 'karen.taylor@hospital.com, 555-1002')
;

-- Insert Visits
INSERT INTO Visits (PatientID, DoctorID, VisitDate, Reason, Diagnosis)
VALUES 
(1, 1, '2025-06-01 09:00', 'Chest Pain', 'Angina'),
(2, 2, '2025-06-05 11:30', 'Headache', 'Migraine'),
(3, 3, '2025-06-07 10:15', 'Fever', 'Flu'),
(1, 1, '2025-06-10 08:45', 'Follow-up', 'Stable'),
(4, 2, '2025-06-12 13:00', 'Seizure', 'Epilepsy')
;

-- Insert Treatments
INSERT INTO Treatments (VisitID, TreatmentType, Notes, Cost)
VALUES 
(1, 'EKG', 'Electrocardiogram done', 200.00),
(2, 'MRI Scan', 'Brain MRI completed', 750.00),
(3, 'Flu Shot', 'Single dose administered', 50.00),
(4, 'Consultation', 'Routine check-up', 100.00),
(5, 'EEG', 'Neuro exam for epilepsy', 500.00)
;

-- Insert Medications
INSERT INTO Medications (Name, Dosage, SideEffects)
VALUES 
('Aspirin', '100mg', 'Nausea, bleeding'),
('Ibuprofen', '200mg', 'Stomach upset, dizziness'),
('Amoxicillin', '500mg', 'Rash, diarrhea'),
('Paracetamol', '500mg', 'Liver damage in overdose'),
('Metoprolol', '50mg', 'Fatigue, slow heartbeat')
;

-- Insert Prescriptions
INSERT INTO Prescriptions (VisitID, MedicationID, Quantity, Instructions)
VALUES 
(1, 1, 30, 'Take one tablet daily after meals'),
(2, 2, 20, 'Take twice daily with food'),
(3, 3, 10, 'Three times a day for 5 days'),
(4, 5, 15, 'Once in the morning'),
(5, 4, 20, 'Take one every 6 hours if needed')
;

-- Insert Billing
INSERT INTO Billing (VisitID, TotalCost, PaymentStatus, InsuranceCovered)
VALUES 
(1, 200.00, 'Paid', 1),
(2, 750.00, 'Pending', 0),
(3, 50.00, 'Paid', 1),
(4, 100.00, 'Insurance', 1),
(5, 500.00, 'Pending', 0)
;


-- Quality Check - test if all the data inserted correctly

SELECT *
FROM Patients
; -- Data inserted correctly in Patient Table

SELECT *
FROM Doctors
;  -- Data inserted correctly in Patient Table


SELECT *
FROM Visits
;  -- Data inserted correctly in Patient Table

SELECT *
FROM Treatments
;  -- Data inserted correctly in Patient Table

SELECT *
FROM Medications
;  -- Data inserted correctly in Patient Table

SELECT *
FROM Prescriptions
;  -- Data inserted correctly in Patient Table

SELECT *
FROM Billing
;  -- Data inserted correctly in Patient Table


-- Creation of Indexes - to make the database more efficient and better performance

-- Indexes for Visits Table
CREATE INDEX idx_visits_patientid ON Visits(PatientID);

CREATE INDEX idx_visits_doctorid ON Visits(DoctorID);

CREATE INDEX idx_visits_visitdate ON Visits(VisitDate);

-- Indexes for Prescriptions Table
CREATE INDEX idx_prescriptions_visitid ON Prescriptions(VisitID);

CREATE INDEX idx_prescriptions_medicationid ON Prescriptions(MedicationID);


-- Indexes for Billing Table
CREATE INDEX idx_billing_visitid ON Billing(visitID);

CREATE INDEX idx_billing_status ON Billing(PaymentStatus);

-- Indexes for Treatment Table
CREATE INDEX idx_treatments_visitid ON Treatments(VisitID);


-- Store Procedures
CREATE PROCEDURE GetPatientVisitHistory
	@PatientID INT
AS
BEGIN
	SELECT
		v.VisitID,
		v.VisitDate,
		v.Reason,
		v.Diagnosis,
		d.FullName AS DoctorName,
		t.TreatmentType,
		t.Notes,
		m.Name AS Medication,
		p.Quantity,
		p.Instructions
	FROM Visits v
	LEFT JOIN Doctors D ON v.DoctorID = D.DoctorID
	LEFT JOIN Treatments t ON  v.VisitID = t.VisitID
	LEFT JOIN Prescriptions p ON v.VisitID = p.VisitID
	LEFT JOIN Medications m ON p.MedicationID = m.MedicationID
	WHERE v.PatientID = @PatientID
	ORDER BY v.VisitDate DESC
END;

-- Quality Test - Test Store Procedure

EXEC GetPatientVisitHistory @PatientID = 1; -- Passed Test



-- Store Procedure - To Insert a New Visit with Treatment and Billing
CREATE PROCEDURE AddVisitWithTreatmentAndBilling
	@PatientID INT,
	@DoctorID INT,
	@VisitDate DATETIME,
	@Reason VARCHAR(255),
	@Diagnosis VARCHAR(255),
	@TreatmentType VARCHAR(100),
	@Notes VARCHAR(255),
	@Cost DECIMAL(10,2),
	@InsuranceCovered BIT
AS
BEGIN
	DECLARE @VisitID INT;

	-- Insert Valuies into the Visits Table
	INSERT INTO Visits(PatientID, DoctorID, VisitDate, Reason, Diagnosis)
	VALUES(@PatientID, @DoctorID, @VisitDate, @Reason, @Diagnosis);

	SET @VisitID = SCOPE_IDENTITY();

	-- Insert Values into the Treatments
	INSERT  INTO Treatments(VisitID, TreatmentType, Notes, Cost)
	VALUES(@VisitID, @TreatmentType, @Notes, @Cost)

	-- Insert Values into Billing
	INSERT INTO Billing (VisitID, TotalCost, PaymentStatus, InsuranceCovered)
	VALUES(@VisitID, @Cost, 'Pending', @InsuranceCovered)
END;

-- Quality Test - Testing store procedure AddVisitWithTreatmentAndBilling
EXEC AddVisitWithTreatmentAndBilling 
    @PatientID = 1, 
    @DoctorID = 1, 
    @VisitDate = '2025-07-22 10:00', 
    @Reason = 'Checkup',
    @Diagnosis = 'Healthy', 
    @TreatmentType = 'General Check', 
    @Notes = 'No Issues', 
    @Cost = 100.00, 
    @InsuranceCovered = 1
;


-- Store Procedure Find all patients with unpaid or insurance pending bills.
CREATE PROCEDURE GetOutstandingBills
AS
BEGIN
	SELECT
		b.BillingID,
		p.FullName AS Patient,
		b.TotalCost,
		b.PaymentStatus,
		v.VisitDate
	FROM Billing b
	JOIN Visits v ON b.VisitID = v.VisitID
	JOIN Patients p on v.PatientID = p.PatientID
	WHERE b.PaymentStatus IN ('Pending', 'Insurance')
	ORDER BY v.VisitID
END
;


-- Store Procedure - Update Payment Status
CREATE PROCEDURE UpdatePaymentStatus
	@VisitID INT,
	@NewStatus VARCHAR(50)
AS
BEGIN
	UPDATE Billing
	SET PaymentStatus = @NewStatus
	WHERE VisitID = @VisitID;
END
;

-- Store Procedure - Find the most frequest prescribed medications
CREATE PROCEDURE GetTopPrescribedMedications
AS
BEGIN
	SELECT
		m.Name,
		COUNT(*) AS PrescriptionCount
	FROM Prescriptions p
	JOIN Medications m ON p.MedicationID = m.MedicationID
	GROUP BY m.Name
	ORDER BY PrescriptionCount DESC
	OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;
END
;


EXEC GetTopPrescribedMedications;

