-- LSBU AI Foundry Relational Backend Schema (SharePoint Lists / Dataverse Blueprint)
-- Author: Noman (Backend & Automation Lead) - Team F06

CREATE TABLE Opportunity_Intake (
    RequestID VARCHAR(15) PRIMARY KEY, -- Auto-generated format: AIF-2026-XXX
    RequesterName VARCHAR(100) NOT NULL,
    RequesterEmail VARCHAR(150) NOT NULL,
    BusinessArea VARCHAR(50) NOT NULL, -- Estates, IT/Digital, Legal, Procurement, HR, Finance, Registry
    ProcessTitle VARCHAR(150) NOT NULL,
    CurrentWorkflowDesc TEXT NOT NULL,
    CurrentTools VARCHAR(255),
    PainPoints TEXT,
    WeeklyHoursSpent DECIMAL(5,2) CHECK (WeeklyHoursSpent > 0),
    GDPRFinancialFlag BOOLEAN DEFAULT FALSE,
    SubmissionDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    LifecycleStatus VARCHAR(30) DEFAULT 'Submitted' -- Submitted, Under Triage, Backlog, In Delivery, Completed, Rejected
);

CREATE TABLE Triage_Assessment (
    TriageID INT PRIMARY KEY AUTO_INCREMENT,
    RequestID VARCHAR(15) NOT NULL,
    AssessorEmail VARCHAR(150) NOT NULL,
    StrategicAlignment INT CHECK (StrategicAlignment BETWEEN 1 AND 5),
    BenefitPotential INT CHECK (BenefitPotential BETWEEN 1 AND 5),
    FeasibilityComplexity INT CHECK (FeasibilityComplexity BETWEEN 1 AND 5),
    ResourceAvailability INT CHECK (ResourceAvailability BETWEEN 1 AND 5),
    SpeedToValue INT CHECK (SpeedToValue BETWEEN 1 AND 5),
    CompositeScore INT, -- Calculated sum (Range: 5 to 25)
    PriorityTier VARCHAR(10), -- High (>=20), Medium (14-19), Low (<=13)
    TriageNotes TEXT,
    AssessmentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (RequestID) REFERENCES Opportunity_Intake(RequestID)
);

CREATE TABLE Benefits_Log (
    BenefitID INT PRIMARY KEY AUTO_INCREMENT,
    RequestID VARCHAR(15) NOT NULL,
    BenefitCategory VARCHAR(50) NOT NULL, -- Efficiency, Financial, Service, Risk Reduction, Data, Strategic
    BaselineWeeklyHours DECIMAL(5,2) NOT NULL,
    PostImplWeeklyHours DECIMAL(5,2) NOT NULL,
    WeeklyHoursSaved DECIMAL(5,2), -- Calculated: BaselineWeeklyHours - PostImplWeeklyHours
    BenchmarkHourlyRate DECIMAL(6,2) DEFAULT 25.00,
    AnnualCostAvoidance DECIMAL(10,2), -- Calculated: WeeklyHoursSaved * 52 * 25.00
    VerificationDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (RequestID) REFERENCES Opportunity_Intake(RequestID)
);
