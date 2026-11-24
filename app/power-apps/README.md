# Digital Front Door: Power Apps canvas app (Team F06)

Power Apps canvas app **"AI Foundry - Digital Front Door"**, built in LSBU's Microsoft 365 tenant (Default environment) with a student account.
It is the working build of Devajyoti's HTML prototype v3 (the design reference).

- **Jira:** CW02F06-5 (intake form UI, In Progress) and CW02F06-11 (DPIA trigger rules, Done)
- **Owner:** Veer Patel. **Co-owner:** Al Noman
- **Data:** test data only. Requests are held in app collections (`colRequests`, `colHistory`) for now; they will be saved to the `Opportunity_Intake` SharePoint list once the lists exist (CW02F06-6/7).

## Files

| File | What it is |
|---|---|
| `scrIntake.pa.yaml` | Requester screen: intake form, validation, DPIA warning, confirmation, My requests |
| `scrPipeline.pa.yaml` | Digital Project Manager screen: Kanban pipeline, filters, triage panel, DPIA approval, decisions, history |

Both are Power Apps "paste code" YAML: the controls of each screen, with their formulas.

## How to rebuild the app from these files

1. In Power Apps Studio, create a blank canvas app (tablet layout, 1366 × 768) with two screens named `scrIntake` and `scrPipeline`.
2. Open `scrIntake.pa.yaml`, copy all of it, click the empty `scrIntake` screen and paste (Ctrl/Cmd+V). Do the same for `scrPipeline.pa.yaml` on `scrPipeline`.
3. Set one screen property that the paste format doesn't carry:
   `scrIntake.OnVisible = Reset(ddDepartment); Reset(ddBenefit)`
   (classic dropdowns ignore an empty default the first time a screen opens; resetting them fixes it).
4. Press F5. On the Digital PM view, click **Load sample data** before submitting anything, so new requests start at AIF-2026-006.

## What the app does

**Requester view (`scrIntake`)**
- Intake fields: request title, department, business owner, route (Workstream 1 single request / Workstream 2 hackathon), current process, current tools, pain points, estimated staff hours saved per week, expected benefit, personal data (GDPR) and financial data switches.
- Every field is required. Per-field messages and red borders appear on submit and clear as fields are filled. Hours must be more than 0 and no more than 168.
- If either data switch is on, an amber warning says the request will be held for a DPIA.
- On submit: reference number `AIF-2026-xxx`, a summary of the request and "what happens next".
- **My requests:** the requester's own requests with their status and any decision reason (no triage scores, as in Section 1.4).

**Digital Project Manager view (`scrPipeline`)**
- Stages: New Requests → Triaged/Backlog → In Delivery → Completed, plus a column for Deferred / Rejected / Needs information.
- Search, benefit-category filter and a "data flags only" filter.
- Cards show flags, priority, and estimated value (hours × 52 × £25 a year).
- Rules:
  - a request can't leave New Requests until it has triage scores;
  - a request on **DPIA hold** can't move into In Delivery until a DPIA approval is recorded;
  - Defer, Reject and Needs more information each need a reason of at least 10 characters, which the requester sees.
- **Triage panel:** the five PID criteria scored 1–5. Priority 0–100 = (30·(SA−1) + 25·(BP−1) + 15·(SV−1) + 15·(5−CX) + 15·(5−RR)) / 4, so complexity and resources lower the priority. High ≥ 75, Medium 50–74, Low < 50. The score supports the decision; a person still makes it.
- **History:** every submission, score, move, DPIA approval and decision is logged with who and when.

## Tests run (24 Nov 2026, synthetic data)

| Test | Result |
|---|---|
| Submit an empty form | Blocked; all fields red; error list shown |
| Fill in all fields | Errors clear as fields are completed |
| GDPR switch on | DPIA warning shown; request saved with DPIA hold |
| Submit after loading sample data | Reference AIF-2026-006; confirmation and My requests correct |
| Sample data priorities | 35, 68, 80 (match the HTML prototype v3) |
| Score 4, 5, 4, 2, 2 | 81/100, High (matches the formula worked by hand) |
| Move an unscored request | Blocked ("Score first") |
| Move a DPIA-hold request into delivery | Blocked until approval recorded; then allowed |
| Decision with no reason | Refused with a message |
| "Needs more information" with a reason | Moves to the parked column; reason shown to the requester |

Screenshots 01–13 (app and key Power Fx formulas) are in Teams: Shared → CW2 - LSBU AI Foundry → 03_Prototype_and_JIRA_Screenshots.

## Still to do (CW02F06-5)

- Save to the `Opportunity_Intake` SharePoint list (waiting on CW02F06-6/7) and agree one schema with `schema/database_schema.sql`.
- Mobile layout and keyboard-only (WCAG 2.2 AA) testing by QA.
- Publish the app (team definition of done).
- Minor: long department and status names wrap on pipeline cards.
