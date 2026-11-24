# LSBU AI Foundry — Digital Front Door & Governance Framework (Team F06)

**Module:** CSI_6_ICT – ICT Project Management in Practice (2026–27)  
**Client:** LSBU Digital (AI Foundry)  
**Team F06:** Arman (Scrum Master), Devajyoti Ratnam (UX/UI), Veer (Technical Lead), Noman (Backend & Automation), Nayem (QA Lead)

## Project Overview
This repository holds the backend data schemas, automation flow definitions, and technical documentation for the LSBU AI Foundry operational interface built natively within Microsoft 365 (SharePoint Lists / Dataverse, Power Apps, Power Automate, and Power BI).

## Repository Structure
* `/schema` — Relational entity definitions (`Opportunity_Intake`, `Triage_Assessment`, `Benefits_Log`) and calculation formulas.
* `/flows` — Power Automate workflow exports and trigger logic (`FR5` notifications & auto-ID generation).
* `/tests` — Anonymised synthetic test datasets (`NFR2` UK GDPR compliant) and QA regression logs.
