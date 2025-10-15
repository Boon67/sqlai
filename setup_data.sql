-- =====================================================
-- Cortex AISQL Demo - Large Dataset Setup Script
-- =====================================================
-- This script creates a comprehensive dataset with 100+ records
-- across all 8 insurance lines for more realistic demonstrations

-- Create database and schema
CREATE DATABASE IF NOT EXISTS CORTEX_AISQL_DEMO;
USE DATABASE CORTEX_AISQL_DEMO;
CREATE SCHEMA IF NOT EXISTS DEMO_DATA;
USE SCHEMA DEMO_DATA;

-- Create stage for file operations
CREATE STAGE IF NOT EXISTS streamlit_stage;

-- =====================================================
-- 1. Customer Tickets Table - 60 Records
-- =====================================================
CREATE OR REPLACE TABLE customer_tickets (
    ticket_id INT,
    customer_name VARCHAR,
    email VARCHAR,
    ticket_text VARCHAR,
    created_date DATE,
    category VARCHAR
);

INSERT INTO customer_tickets VALUES
-- Cyber Insurance Claims (10 records)
(1, 'Jennifer Martinez', 'jmartinez@healthcare-co.com',
 'Urgent cyber incident! We experienced a ransomware attack on January 18, 2024. Approximately 50,000 patient records potentially compromised. Cyber insurance policy CYB-2024-123890. Need immediate incident response team and coverage confirmation. Attack vector appears to be phishing email.',
 '2024-01-18', 'Claims'),
(2, 'Amanda Foster', 'afoster@techsolutions.com',
 'Business email compromise detected. CFO impersonation led to wire transfer of $250K to fraudulent account. Policy CYB-2024-887766. Incident occurred January 22, 2024. FBI notified. Need coverage for loss and forensic investigation.',
 '2024-01-22', 'Claims'),
(3, 'Kevin Zhang', 'kzhang@retailonline.com',
 'E-commerce site DDoS attack. Website down for 72 hours resulting in $1.2M lost revenue. Cyber policy CYB-2023-445566. Business interruption coverage should apply. Attack started February 1, 2024. Need claim filed urgently.',
 '2024-02-02', 'Claims'),
(4, 'Michelle Torres', 'mtorres@bankingcorp.com',
 'Data breach notification required. Customer PII exposed - 125,000 records. Policy CYB-2024-334455. Need coverage for notification costs, credit monitoring, regulatory fines. GDPR compliance required. Incident date: January 29, 2024.',
 '2024-01-30', 'Claims'),
(5, 'Brian Mitchell', 'bmitchell@saascompany.com',
 'Cloud infrastructure ransomware. All systems encrypted. Ransom demand: $500K in Bitcoin. Policy CYB-2024-998877. Need incident response team immediately. Backups partially compromised. Critical systems offline since February 3, 2024.',
 '2024-02-03', 'Claims'),
(6, 'Laura Anderson', 'landerson@medicalgroup.com',
 'HIPAA breach - ransomware. 75,000 patient records encrypted. Policy CYB-2024-556677. OCR notification required. Ransom: $750K. Need legal counsel and PR firm. Attack occurred January 25, 2024. Local news coverage started.',
 '2024-01-26', 'Claims'),
(7, 'Daniel Kim', 'dkim@manufacturing.com',
 'Supply chain cyber attack. Vendor compromised leading to our network breach. Policy CYB-2024-223344. Production systems offline. Estimated loss: $2M. Need coverage for business interruption and system restoration. Incident: February 5, 2024.',
 '2024-02-06', 'Claims'),
(8, 'Rebecca Martinez', 'rmartinez@lawfirm.com',
 'Law firm data breach. Client privileged communications compromised. Policy CYB-2024-778899. 50 clients affected. Need coverage for notification, legal fees, malpractice claims. Bar association notified. Breach detected: January 31, 2024.',
 '2024-02-01', 'Claims'),
(9, 'Christopher Lee', 'clee@financialservices.com',
 'Social engineering attack. Employee tricked into providing admin credentials. $150K transferred before detection. Policy CYB-2024-112233. Need coverage for theft and forensics. Incident: February 8, 2024. Internal investigation ongoing.',
 '2024-02-09', 'Claims'),
(10, 'Angela Brown', 'abrown@hospitalgroup.com',
 'Medical device ransomware. Imaging systems encrypted affecting patient care. Policy CYB-2024-665544. Critical care impact. Ransom: $1M. FDA notification required. Incident started: February 4, 2024. Emergency procedures in place.',
 '2024-02-05', 'Claims'),

-- D&O Insurance Claims (8 records)
(11, 'Robert Chen', 'rchen@techstartup.com', 
 'D AND O claim needed. Board decision on January 15, 2024 resulted in shareholder litigation. Policy DO-2024-789456. Lawsuit alleges breach of fiduciary duty. Total claim amount estimated at $2.5M. Please expedite review. Three board members named.',
 '2024-01-20', 'Claims'),
(12, 'Patricia Lee', 'plee@publiccompany.com',
 'Securities class action filed. Stock drop following earnings announcement. Policy DO-2024-445566. Claim amount: $18M. Alleges material misrepresentation. 10 directors named. Defense counsel needed immediately. Filing date: January 28, 2024.',
 '2024-01-29', 'Claims'),
(13, 'Michael Sanders', 'msanders@biotechcorp.com',
 'D AND O Side A coverage needed. Company bankrupt. Directors facing personal liability. Policy DO-2023-998877. Claim: $5M. Creditors pursuing personal assets. Side A advancement needed for legal fees. Bankruptcy filing: December 2023.',
 '2024-02-01', 'Claims'),
(14, 'Elizabeth Chen', 'echen@retailchain.com',
 'Derivative lawsuit against board. Alleges waste of corporate assets on failed acquisition. Policy DO-2024-334455. Claim: $10M. Shareholder demand letter received. Need coverage opinion and counsel assignment. Demand dated: January 20, 2024.',
 '2024-01-22', 'Claims'),
(15, 'James Foster', 'jfoster@manufacturingco.com',
 'ERISA fiduciary breach claim. 401k plan investment losses. Policy DO-2024-556677. Claim: $3.5M. Plan participants alleging breach of duty. DOL investigation started. Need ERISA specialist counsel. Claim filed: February 2, 2024.',
 '2024-02-03', 'Claims'),
(16, 'Susan Rodriguez', 'srodriguez@spac-ventures.com',
 'SPAC merger dispute. Target shareholders suing for inadequate disclosure. Policy DO-2024-778899. Claim: $25M. Delaware Chancery Court. 8 directors named. Emergency TRO hearing scheduled. Filing: January 30, 2024.',
 '2024-01-31', 'Claims'),
(17, 'Thomas Wright', 'twright@nonprofit.com',
 'Nonprofit board claim. Donor alleges misuse of funds. Policy DO-2024-223344. Claim: $800K. State AG investigating. Need coverage confirmation and legal representation. Complaint filed: February 6, 2024. Press coverage started.',
 '2024-02-07', 'Claims'),
(18, 'Karen Mitchell', 'kmitchell@privateequity.com',
 'Portfolio company D AND O dispute. Board conflict over acquisition price. Policy DO-2024-665544. Claim: $12M. Minority shareholders claiming breach. Delaware litigation. Expedited proceedings requested. Filed: February 1, 2024.',
 '2024-02-02', 'Claims'),

-- E&O Insurance Claims (6 records)
(19, 'David Rodriguez', 'drodriguez@lawfirm.com',
 'Professional liability claim. Client alleges legal malpractice in contract negotiation. Incident date: December 10, 2023. Policy PL-LAW-2024-445566. Potential damages: $1.2M. We have documentation showing proper procedures were followed. Request defense counsel assignment.',
 '2024-01-21', 'Claims'),
(20, 'Maria Gonzalez', 'mgonzalez@accounting.com',
 'Audit malpractice claim. Client alleges failed to detect fraud. Policy EO-2024-556677. Claim: $2.5M. State board complaint filed. Need coverage and legal representation. Audit period: 2022-2023. Claim filed: February 5, 2024.',
 '2024-02-06', 'Claims'),
(21, 'Steven Park', 'spark@consulting.com',
 'Consulting services E AND O. Client project failure attributed to our advice. Policy EO-2024-334455. Claim: $3M. Project was $15M software implementation. Client threatening arbitration. Need coverage opinion. Dispute: January 2024.',
 '2024-02-03', 'Claims'),
(22, 'Jennifer Walsh', 'jwalsh@realestate.com',
 'Real estate E AND O claim. Title defect not discovered. Policy EO-2024-887766. Claim: $1.5M. Transaction value: $8M. Buyer demanding rescission. Need legal defense. Closing date was December 2023. Claim: February 1, 2024.',
 '2024-02-02', 'Claims'),
(23, 'Richard Taylor', 'rtaylor@itconsulting.com',
 'Technology consulting malpractice. System migration failure. Policy EO-2024-112233. Claim: $4M. Client lost all data. No backup procedures followed per client. Dispute over scope of work. Incident: January 2024.',
 '2024-02-08', 'Claims'),
(24, 'Nicole Foster', 'nfoster@architecturefirm.com',
 'Design professional E AND O. Building structural issues. Policy EO-2024-998877. Claim: $6M. Construction defects alleged. Three buildings affected. Engineering review ongoing. Claim filed: February 10, 2024.',
 '2024-02-11', 'Claims'),

-- EPLI Claims (5 records)
(25, 'James Wilson', 'jwilson@nonprofit.org',
 'Employment practices liability claim. Former employee filed discrimination lawsuit on January 16, 2024. EPLI policy EPL-2024-334455. Claim amount: $750K. We followed all HR policies and have documentation. Need coverage confirmation and legal representation.',
 '2024-01-17', 'Claims'),
(26, 'Linda Martinez', 'lmartinez@retailcompany.com',
 'Wrongful termination claim. Ex-manager alleges age discrimination. Policy EPL-2024-556677. Claim: $1.2M. EEOC charge filed. Employee was 58, replaced by 32-year-old. Need employment counsel. Termination: December 2023.',
 '2024-02-04', 'Claims'),
(27, 'Robert Johnson', 'rjohnson@tech-startup.com',
 'Sexual harassment claim. Multiple employees. Policy EPL-2024-778899. Claim: $2.5M. Class action threatened. HR investigation completed. Need coverage and crisis management. Claims filed: January 2024.',
 '2024-02-01', 'Claims'),
(28, 'Patricia Brown', 'pbrown@hospitalnetwork.com',
 'Hostile work environment. Nurse supervisor claim. Policy EPL-2024-223344. Claim: $900K. State labor board complaint. Medical leave retaliation alleged. Need legal defense. Complaint: February 2024.',
 '2024-02-09', 'Claims'),
(29, 'Charles Lee', 'clee@construction.com',
 'Wage and hour class action. Overtime violations alleged. Policy EPL-2024-445566. Claim: $3.5M. 150 employees. DOL investigation pending. Need employment law specialist. Filed: February 6, 2024.',
 '2024-02-07', 'Claims'),

-- Product Liability Claims (6 records)
(30, 'Sarah Kim', 'skim@manufacturing.com',
 'Product recall notice filed. Manufacturing defect affected 10,000 units. Product liability policy PL-2024-567123. Recall costs estimated at $500K. No injuries reported yet but preventive action required. Need claims adjuster assigned urgently. Defect: brake component.',
 '2024-01-19', 'Claims'),
(31, 'Michael Torres', 'mtorres@toyscompany.com',
 'Product liability - choking hazard. 3 children injured. Policy PL-2024-334455. Claim: $2M. CPSC investigation. Recall of 50,000 units required. Need legal defense and PR firm. Injuries: January 2024.',
 '2024-02-05', 'Claims'),
(32, 'Jessica Wang', 'jwang@electronics.com',
 'Battery fire claims. Smartphones overheating. Policy PL-2024-887766. Claims: $8M aggregate. 25 injury claims. Class action threatened. Global recall needed. Incidents: December 2023-January 2024.',
 '2024-02-02', 'Claims'),
(33, 'Andrew Miller', 'amiller@pharmaceutical.com',
 'Drug side effects litigation. Policy PL-2024-556677. Mass tort claim: $50M. 200+ plaintiffs. FDA warning letter received. Need coverage opinion and national counsel. First claims: January 2024.',
 '2024-02-08', 'Claims'),
(34, 'Rachel Adams', 'radams@automotive.com',
 'Airbag defect recall. Policy PL-2024-112233. Estimated cost: $15M. 100,000 vehicles affected. NHTSA investigation. No injuries yet. Preventive recall. Defect identified: February 2024.',
 '2024-02-10', 'Claims'),
(35, 'Daniel Park', 'dpark@medical-devices.com',
 'Medical device malfunction. Hip implant failures. Policy PL-2024-998877. Claim: $10M. 50 revision surgeries needed. FDA Class I recall. Need legal defense and medical consultants. Failures: Q4 2023.',
 '2024-02-03', 'Claims'),

-- Marine Insurance Claims (7 records)
(36, 'Captain Marcus Blake', 'mblake@oceantransport.com',
 'Marine cargo claim. Container ship MV Pacific Star experienced hull damage during storm on January 28, 2024. Policy MAR-2024-556677. Cargo value: $8.5M including electronics and machinery. Port of loading: Shanghai. Destination: Los Angeles. General average declared. Need surveyor assigned.',
 '2024-01-29', 'Claims'),
(37, 'Captain John Peterson', 'jpeterson@maritimelogistics.com',
 'Marine P AND I claim. Crew member injury aboard MV Atlantic Voyager on January 22, 2024. Medical evacuation via helicopter required. Treatment costs estimated $150K. Potential Jones Act lawsuit filed. Policy PI-2024-889900. Need claims attorney and medical case manager. International waters.',
 '2024-01-23', 'Claims'),
(38, 'Elena Kozlov', 'ekozlov@shippingline.com',
 'Piracy incident. Vessel MV Sea Guardian hijacked in Gulf of Aden. Policy MAR-2024-334455. Ransom demand: $3M. 20 crew members held. War risk coverage applies. Need K AND R specialist. Incident: February 7, 2024.',
 '2024-02-08', 'Claims'),
(39, 'Captain Robert Fraser', 'rfraser@bulkcarrier.com',
 'Marine collision claim. MV Iron Duke collided with another vessel in Singapore Straits. Policy MAR-2024-778899. Hull damage: $5M. Cargo damage: $2M. Other vessel claiming $3M. Need maritime lawyers. Collision: February 1, 2024.',
 '2024-02-02', 'Claims'),
(40, 'Samuel Rodriguez', 'srodriguez@tankershipping.com',
 'Oil spill liability. Tanker MV Black Gold leaked 5,000 barrels. Policy MAR-2024-556677. Environmental cleanup: $10M estimated. Coast Guard investigation. OPA 90 liability. Need environmental counsel. Spill: January 30, 2024.',
 '2024-01-31', 'Claims'),
(41, 'Captain Lisa Chen', 'lchen@containership.com',
 'Container loss at sea. Storm caused 150 containers overboard. Policy MAR-2024-112233. Cargo value: $4.5M. General average contribution required. Need average adjuster. Incident: February 9, 2024. Pacific Ocean.',
 '2024-02-10', 'Claims'),
(42, 'Thomas Anderson', 'tanderson@ropax-ferry.com',
 'Passenger vessel collision. Ferry grounded. Policy MAR-2024-665544. Hull damage: $2M. 200 passengers evacuated. No injuries. Coast Guard investigation. Salvage required. Incident: February 3, 2024. Need P AND I cover confirmation.',
 '2024-02-04', 'Claims'),

-- Aviation Insurance Claims (6 records)
(43, 'Captain Sarah Mitchell', 'smitchell@skyfreight.com',
 'Aviation hull claim urgent! Aircraft registration N845AV sustained damage during hard landing at Denver on January 27, 2024. Boeing 737-800, insured value $45M. Policy AVI-2024-778899. No injuries but significant undercarriage damage. Aircraft grounded. Need damage assessment and rental aircraft approval.',
 '2024-01-27', 'Claims'),
(44, 'Captain Michael Brown', 'mbrown@cargo-air.com',
 'Aviation hull total loss. Aircraft N123CA crashed on takeoff. Policy AVI-2024-556677. Hull value: $35M. Cargo loss: $5M. Two crew fatalities. NTSB investigation. Need legal counsel for families. Crash: February 5, 2024.',
 '2024-02-06', 'Claims'),
(45, 'Jennifer Lopez', 'jlopez@charter-flights.com',
 'Aviation liability claim. Passenger injury during turbulence. Policy AVI-2024-334455. Claim: $2M. Severe injuries. FAA incident report filed. Medical expenses ongoing. Need aviation defense counsel. Incident: January 25, 2024.',
 '2024-01-26', 'Claims'),
(46, 'Captain David White', 'dwhite@helicopter-services.com',
 'Helicopter hull damage. Hard landing in remote area. Policy AVI-2024-887766. Hull value: $8M. Damage estimate: $3M. No injuries. Need maintenance facility approval and parts. Incident: February 8, 2024. Alaska.',
 '2024-02-09', 'Claims'),
(47, 'Robert Martinez', 'rmartinez@drone-ops.com',
 'UAV liability claim. Drone crashed into building. Policy AVI-2024-112233. Property damage: $500K. FAA violation. Part 107 waiver suspended. Need aviation counsel and Part 107 attorney. Incident: February 2, 2024.',
 '2024-02-03', 'Claims'),
(48, 'Captain Lisa Anderson', 'landerson@business-jet.com',
 'Aviation product liability. Avionics system failure. Policy AVI-2024-998877. Claim: $15M. System used in 200 aircraft. AD issued. Need engineering analysis and legal defense. Failure: January 2024. Global implications.',
 '2024-02-07', 'Claims'),

-- Political Risk Claims (6 records)
(49, 'Rachel Wong', 'rwong@infrastructure-global.com',
 'Political risk insurance claim. Project: Power plant construction in emerging market. Contract value: $120M. Policy POL-2024-334455. Government expropriation occurred January 20, 2024. All assets seized without compensation. Need coverage confirmation for contract frustration and asset confiscation. Legal team standing by.',
 '2024-01-25', 'Claims'),
(50, 'David Kumar', 'dkumar@mining-ventures.com',
 'Political violence claim. Mine operations shut down by civil unrest. Policy POL-2024-556677. Property damage: $25M. Business interruption: $10M monthly. 6-month closure expected. Need coverage and security consultants. Violence started: February 1, 2024.',
 '2024-02-02', 'Claims'),
(51, 'Sandra Martinez', 'smartinez@oil-exploration.com',
 'Currency inconvertibility. Unable to repatriate $50M in earnings. Policy POL-2024-778899. Capital controls imposed January 30, 2024. 180-day waiting period applies. Need coverage opinion. Project: Offshore drilling.',
 '2024-02-05', 'Claims'),
(52, 'Alexander Petrov', 'apetrov@construction-intl.com',
 'Contract frustration. Government canceled $200M infrastructure project. Policy POL-2024-112233. Work 60% complete. Payment withheld. Need coverage for sunk costs and contract breach. Cancellation: February 2024.',
 '2024-02-08', 'Claims'),
(53, 'Maria Silva', 'msilva@telecom-global.com',
 'License cancellation. Government revoked operating license. Policy POL-2024-665544. Investment: $100M. No compensation offered. ICSID arbitration planned. Need coverage confirmation. Revocation: January 25, 2024.',
 '2024-01-28', 'Claims'),
(54, 'James Thompson', 'jthompson@energy-projects.com',
 'Political risk - sanctions impact. New sanctions prevent project completion. Policy POL-2024-223344. Project value: $150M. Cannot import equipment. Need abandonment coverage. Sanctions: February 2024. Force majeure invoked.',
 '2024-02-09', 'Claims'),

-- New Business Inquiries (3 records for each line = 24 total, IDs 55-78 - Abbreviated for space)
(55, 'Michael Thompson', 'mthompson@consultingfirm.com',
 'Requesting E AND O coverage for consulting firm. 25 consultants, annual revenue $5M. Need professional liability limits of $3M per claim and $5M aggregate. What are premium rates? Policy effective date needed: March 1, 2024.',
 '2024-01-22', 'New Business'),
(56, 'Lisa Chen', 'lchen@medtech.com',
 'Medical device E AND O coverage quote. Annual revenue: $20M. Product: AI-powered diagnostic software. Need coverage for FDA compliance issues and product liability. Looking for $10M limits. Clinical trials phase completed. Risk assessment needed.',
 '2024-01-24', 'New Business'),
(57, 'Patricia Lee', 'plee@boardmembers.com',
 'D AND O policy inquiry for board members. Public company, market cap $500M. Need Side A, B, and C coverage. Previous insurer non-renewed us. Looking for $25M coverage. Any prior acts coverage available? Board size: 9 members. Quote by end of month.',
 '2024-01-26', 'New Business'),
(58, 'Emily Rodriguez', 'erodriguez@globalshipping.com',
 'Marine hull and machinery quote for fleet. 5 vessels: 2 container ships (80,000 DWT), 2 bulk carriers (50,000 DWT), 1 tanker (45,000 DWT). Total insured value: $250M. Trading worldwide including piracy zones. Need war risk and P AND I coverage. Quote needed by February 15.',
 '2024-01-30', 'New Business'),
(59, 'Thomas Anderson', 'tanderson@charterair.com',
 'Aviation liability quote for charter operation. Fleet: 8 aircraft (4 jets, 4 turboprops). Annual passenger count: 50,000. Coverage needed: $500M per occurrence, $500M aggregate. War and terrorism coverage required. Operating in US, Canada, Caribbean. Premium indication needed urgently.',
 '2024-01-31', 'New Business'),
(60, 'Alexandra Novak', 'anovak@aviationconsulting.com',
 'Aviation product liability question. We manufacture avionics systems installed in 500+ aircraft worldwide. Annual revenue: $75M. Need coverage for design defects, manufacturing errors, failure to warn. Limits requested: $100M per occurrence. Worldwide territory including war zones. Previous carrier non-renewed.',
 '2024-02-02', 'New Business');

-- =====================================================
-- 2. Product Reviews Table - 40 Records
-- =====================================================
CREATE OR REPLACE TABLE product_reviews (
    review_id INT,
    product_name VARCHAR,
    review_text VARCHAR,
    rating INT,
    review_date DATE
);

INSERT INTO product_reviews VALUES
-- Cyber Insurance Reviews (8 records)
(1, 'Cyber Insurance Premier', 'Outstanding coverage! When we had a ransomware incident, the claims team responded within 2 hours. Incident response was top-notch. Coverage included forensics, legal fees, and notification costs. Premium is competitive. Highly recommend for tech companies!', 5, '2024-01-10'),
(2, 'Cyber Shield Enterprise', 'Best cyber insurance purchased! Comprehensive coverage including business interruption, ransomware payments, and regulatory fines. Risk assessment team helped improve our security posture. Premium discount for good security practices. Excellent!', 5, '2024-01-13'),
(3, 'Cyber Essentials SMB', 'Coverage limits too low for actual cyber incidents. $500K limit barely covered notification costs. No coverage for ransomware payments. Support team unhelpful during crisis. Not suitable for any serious business.', 2, '2024-01-17'),
(4, 'Cyber Defense Plus', 'Good mid-market solution. Responded well to BEC incident. Coverage for social engineering was critical. Claims adjuster understood cyber risks. Premium reasonable. 24/7 hotline helpful. Would buy again.', 4, '2024-01-20'),
(5, 'Cyber Guard Pro', 'Disappointed with sublimits. Ransomware payment capped at $100K but we needed $500K. Business interruption waiting period too long. Claims process slow. Better options available in market.', 2, '2024-01-25'),
(6, 'Cyber Risk Solutions', 'Excellent for healthcare. HIPAA expertise was crucial. Breach response team partnered with our incident responders. OCR notification handled professionally. Worth the premium for peace of mind.', 5, '2024-02-01'),
(7, 'Cyber Protect Comprehensive', 'Average coverage. Claims handling adequate but not exceptional. Premium competitive. Policy wording clear. No surprises during claim. Good value for small business under $10M revenue.', 3, '2024-02-05'),
(8, 'Cyber Elite Enterprise', 'Expensive but worth it for large enterprise. $25M limits provided comfort. Breach coach program excellent. Pre-breach services helped prevent incidents. Claims team highly responsive. Top tier coverage.', 5, '2024-02-08'),

-- D&O Insurance Reviews (6 records)
(9, 'D AND O Basic Policy', 'Very disappointed with claims handling. Took 6 weeks to assign defense counsel. Coverage exclusions not clearly explained during sales process. Claim partially denied due to obscure policy language. Would not renew.', 1, '2024-01-11'),
(10, 'Directors Shield Gold', 'Exceptional D AND O coverage! Side A, B, and C all included. Non-recourse advancement of defense costs. Claims team has deep expertise in securities litigation. Premium higher but worth it for peace of mind. Board loves this coverage!', 5, '2024-01-16'),
(11, 'D AND O Protection Plus', 'Good coverage for mid-cap public companies. Securities claims handled professionally. Coverage for ERISA claims important. Premium increased 40% at renewal but market-driven. Solid carrier.', 4, '2024-01-22'),
(12, 'Executive Shield Premier', 'Side A coverage saved directors personally. Company bankruptcy meant Side B useless but Side A responded. Non-recourse advancement critical. Worth every penny. Highly recommend for all directors.', 5, '2024-02-03'),
(13, 'D AND O Essentials', 'Adequate for private company. Claims handling professional. Coverage limits appropriate. Exclusions reasonable. Premium competitive. Good value for closely held business.', 3, '2024-02-07'),
(14, 'Board Guard Elite', 'Outstanding for SPAC. De-SPAC merger coverage critical. Claims team understood Delaware law. Premium high but expected for SPAC risk. Coverage responded as promised.', 5, '2024-02-10'),

-- E&O Insurance Reviews (5 records)
(15, 'E AND O Professional Plus', 'Adequate coverage for small consulting firms. Premium reasonable at $8K annually for $2M limits. Claims process straightforward. However, policy has high deductible of $25K. Good value but not great for frequent small claims.', 3, '2024-01-12'),
(16, 'Professional Liability Tech', 'Decent E AND O coverage for software companies. Pricing competitive. Coverage includes IP infringement and data breach. Policy wording could be clearer on exclusions. Average experience overall but meets basic needs.', 3, '2024-01-15'),
(17, 'Consulting Pro Liability', 'Excellent for management consultants. Claims team understood professional services. Defense counsel knowledgeable. Premium fair for risk. Tail coverage options good. Very satisfied with policy and service.', 5, '2024-01-28'),
(18, 'E AND O Shield Comprehensive', 'Disappointed with claim handling. Adjuster seemed unfamiliar with professional services. Coverage dispute over scope of work. Legal fees exceeded coverage. Policy limits inadequate. Premium not justified.', 2, '2024-02-04'),
(19, 'Professional Guard Premier', 'Outstanding E AND O coverage. Audit malpractice claim handled expertly. Access to technical consultants valuable. Premium competitive. Policy terms clear. Highly recommend for accounting and audit firms.', 5, '2024-02-11'),

-- EPLI Reviews (4 records)
(20, 'EPLI Standard Coverage', 'Claims adjuster slow to respond and seemed inexperienced with employment law. Coverage limits inadequate for settlement. Policy excluded several key employment practices. Better options available in market.', 2, '2024-01-14'),
(21, 'Employment Guard Plus', 'Excellent EPLI coverage. Wrongful termination claim handled professionally. Access to HR consultants valuable. Legal defense costs fully covered. Premium fair. Highly recommend for employers.', 5, '2024-01-29'),
(22, 'Workplace Protect Pro', 'Good coverage for wage and hour risks. Class action claim handled well. Employment counsel experienced. Premium competitive. Policy clear. Good value for companies with hourly workers.', 4, '2024-02-06'),
(23, 'EPLI Shield Comprehensive', 'Outstanding coverage and service. Sexual harassment claims handled sensitively. PR support valuable. Legal defense excellent. Third-party coverage important. Worth premium for complete protection.', 5, '2024-02-12'),

-- Product Liability Reviews (4 records)
(24, 'Product Liability Plus', 'Policy excluded our main product line due to high risk classification. Underwriting rigid and inflexible. Premium quote 40% higher than competitors. Application process took forever. Went with another carrier.', 2, '2024-01-18'),
(25, 'Product Guard Comprehensive', 'Excellent for manufacturers. Recall coverage critical during our incident. Claims team understood manufacturing. Global coverage important. Premium fair for risk. Very satisfied.', 5, '2024-01-27'),
(26, 'Product Shield Enterprise', 'Outstanding for consumer products. Mass tort claim handled expertly. Access to product engineers valuable. Global capacity important. Premium high but justified. Top tier coverage.', 5, '2024-02-09'),
(27, 'Product Protect Plus', 'Good basic coverage. Claims handling adequate. Premium competitive. Policy clear. Sublimits reasonable. Good value for established products with limited claims history.', 4, '2024-02-13'),

-- Marine Insurance Reviews (4 records)
(28, 'Marine Cargo Premium', 'Exceptional marine insurance! Container ship cargo damage during transit, surveyor assigned within 24 hours. Claim settled in 3 weeks. Coverage includes general average, war risk, and piracy. Lloyd market backed. Excellent service for international shipping!', 5, '2024-01-20'),
(29, 'Marine Hull Basic', 'Disappointing coverage. Claim for engine damage delayed for months. Survey costs not fully covered. War risk exclusions broader than expected. Better marine hull options available in Lloyd market.', 2, '2024-01-23'),
(30, 'Marine P AND I Complete', 'Outstanding P AND I coverage. Crew injury claim handled expertly. Jones Act coverage critical. Medical case management excellent. Global reach important. Premium competitive for risk. Highly recommend.', 5, '2024-02-05'),
(31, 'Marine Shield Comprehensive', 'Excellent marine coverage. Collision claim handled professionally. Hull and machinery coverage responsive. War risk endorsement critical for trade routes. Premium fair. Good Lloyd syndicate backing.', 4, '2024-02-12'),

-- Aviation Insurance Reviews (4 records)
(32, 'Aviation Hull Complete', 'Outstanding aviation hull coverage! Aircraft damage claim processed smoothly. Rental aircraft approved immediately so no business interruption. Coverage includes war and terrorism. Claims team understands aviation operations. Worth premium for peace of mind.', 5, '2024-01-21'),
(33, 'Aviation Liability Shield', 'Excellent aviation liability. Passenger injury claim handled expertly. Legal defense knowledgeable about FAA regulations. Coverage limits adequate. Premium competitive. Highly recommend for commercial operators.', 5, '2024-02-02'),
(34, 'Aviation Guard Pro', 'Good coverage for Part 135 operations. Claims handling professional. Hull and liability combined policy convenient. Premium reasonable. War risk included. Solid coverage for charter operators.', 4, '2024-02-08'),
(35, 'Aviation Elite Enterprise', 'Outstanding for airline operations. Hull total loss claim settled fairly. Business interruption coverage critical. Fleet coverage efficient. Premium high but expected. Top tier aviation coverage.', 5, '2024-02-14'),

-- Political Risk Reviews (4 records)
(36, 'Political Risk Standard', 'Saved our project! Government expropriation occurred but coverage responded exactly as promised. Claims team had expertise in sovereign risk. Settlement covered contract frustration and asset loss. Essential coverage for emerging market investments.', 5, '2024-01-22'),
(37, 'Political Risk Premier', 'Excellent coverage for infrastructure projects. Currency inconvertibility claim handled professionally. Waiting period reasonable. Coverage for contract frustration critical. Premium high but justified for country risk.', 5, '2024-02-01'),
(38, 'Political Risk Shield', 'Good coverage for mining projects. Political violence claim processed efficiently. Security consultants provided valuable assistance. Coverage limits adequate. Premium competitive for high-risk countries.', 4, '2024-02-10'),
(39, 'Political Risk Elite', 'Outstanding for energy projects. License cancellation coverage critical. ICSID arbitration support excellent. Lloyd market capacity important. Premium expensive but worth it for project protection.', 5, '2024-02-15'),

-- Management Liability Package (1 record)
(40, 'Management Liability Package', 'Excellent bundled coverage! Includes D AND O, EPLI, Fiduciary, and Crime. One premium, one deductible, streamlined claims. Saved 20% vs buying policies separately. Great for mid-size companies. Very satisfied with coverage and service.', 4, '2024-01-19');

-- =====================================================
-- 3. Social Media Posts Table - 30 Records
-- =====================================================
CREATE OR REPLACE TABLE social_media_posts (
    post_id INT,
    username VARCHAR,
    post_text VARCHAR,
    platform VARCHAR,
    post_date TIMESTAMP
);

INSERT INTO social_media_posts VALUES
-- Cyber Insurance Posts (6 records)
(1, 'CyberSec_Daily', 'ALERT: New ransomware variant targeting healthcare systems. Make sure your cyber insurance covers incident response and business interruption. Prevention is key! #CyberSecurity #Ransomware #Healthcare', 'Twitter', '2024-01-10 07:30:00'),
(2, 'CISO_Forum', 'PSA: If you have cyber insurance, review your policy NOW. Many policies exclude ransomware payments or have sublimits that won''t cover a real incident. #CISO #CyberInsurance #InfoSec', 'Twitter', '2024-01-12 11:30:00'),
(3, 'InsurTech_News', 'Breaking: Global cyber insurance market projected to reach $20B by 2025. Huge opportunity for innovation in underwriting and claims handling. #InsurTech #CyberInsurance', 'Twitter', '2024-01-14 08:00:00'),
(4, 'Risk_Manager_Pro', 'Excellent webinar on emerging cyber risks in 2024! Key takeaway: AI-powered attacks are increasing. Time to review your cyber insurance limits. #RiskManagement #Insurance', 'LinkedIn', '2024-01-11 14:20:00'),
(5, 'Cyber_Underwriter', 'Cyber insurance pricing stabilizing in 2024. Seeing better terms for companies with strong security controls. MFA, EDR, and security training paying dividends in premium reduction. #CyberInsurance', 'LinkedIn', '2024-02-05 09:15:00'),
(6, 'InfoSec_Leader', 'Our cyber insurance saved us during ransomware attack. Incident response team on-site within 4 hours. Business interruption coverage kept company afloat. Worth every penny. #CyberSecurity #Insurance', 'Twitter', '2024-02-08 16:45:00'),

-- D&O Insurance Posts (5 records)
(7, 'CFO_Network', 'Just renewed our D AND O insurance. Premium increased 40% this year! Market is hardening significantly. Other CFOs seeing similar increases? #DirectorsAndOfficers #Insurance #CFO', 'LinkedIn', '2024-01-10 09:15:00'),
(8, 'Board_Member', 'Grateful for our D AND O coverage today. Shareholder lawsuit filed but our carrier assigned excellent defense counsel within 48 hours. Worth every penny of the premium. #BoardService #D AND O', 'LinkedIn', '2024-01-12 16:45:00'),
(9, 'Insurance_Broker', 'Frustrated with current D AND O market. Underwriters asking for ridiculous amounts of information and still declining good risks. Clients are suffering. Something needs to change!', 'LinkedIn', '2024-01-11 21:00:00'),
(10, 'Legal_Tech', 'Interesting case law development on D AND O Side A coverage. Delaware Court ruling could impact how we think about insured vs. insured exclusions. Insurance nerds unite! #InsuranceLaw #D AND O', 'LinkedIn', '2024-01-13 22:15:00'),
(11, 'Corporate_Counsel', 'Side A D AND O coverage critical for directors. Recent bankruptcy case showed why non-recourse advancement matters. Directors protected even when company cannot indemnify. #D AND O #CorporateLaw', 'LinkedIn', '2024-02-03 10:30:00'),

-- E&O Insurance Posts (4 records)
(12, 'Startup_Founder', 'Our E AND O insurance claim was denied because of technicality in the application. Read the fine print people! Now facing $500K lawsuit without coverage. This is devastating.', 'Twitter', '2024-01-10 19:45:00'),
(13, 'SMB_Owner', 'Finally got proper insurance coverage for consulting business. E AND O policy gives peace of mind when signing big contracts. Highly recommend all consultants get this! #SmallBusiness #Consulting', 'LinkedIn', '2024-01-14 17:30:00'),
(14, 'Professional_Services', 'E AND O insurance saved our firm. Malpractice claim covered including defense costs. Critical coverage for any professional services firm. Don''t operate without it! #ProfessionalLiability', 'LinkedIn', '2024-02-06 11:20:00'),
(15, 'Tech_Consultant', 'Technology E AND O claims increasing. Software failures leading to big losses. Make sure your coverage includes tech E AND O, not just general professional liability. #TechInsurance', 'Twitter', '2024-02-11 14:35:00'),

-- EPLI Posts (3 records)
(16, 'HR_Director', 'EPLI saved us during wrongful termination lawsuit. Legal defense costs alone were $200K. Plus access to employment law resources invaluable. Every employer needs this coverage. #EPLI #HR', 'LinkedIn', '2024-02-01 13:25:00'),
(17, 'Employment_Lawyer', 'Seeing increase in EPLI claims related to remote work disputes. New coverage issues emerging. Employers should review their EPLI policies for remote work clarity. #EmploymentLaw', 'Twitter', '2024-02-07 10:15:00'),
(18, 'Business_Owner', 'Wage and hour class actions are nightmare without EPLI. Our policy covered defense and settlement. Critical coverage for any business with employees. #EPLI #SmallBusiness', 'LinkedIn', '2024-02-12 15:40:00'),

-- Product Liability Posts (3 records)
(19, 'Manufacturing_CEO', 'Product recall covered by product liability insurance. Recall costs were $2M but coverage responded. Crisis management support valuable. Essential coverage for manufacturers. #ProductLiability', 'LinkedIn', '2024-02-04 09:55:00'),
(20, 'Quality_Engineer', 'Product liability insurance critical for manufacturing. Even best quality control cannot prevent all defects. Coverage provides peace of mind and financial protection. #Manufacturing #Insurance', 'Twitter', '2024-02-09 11:25:00'),
(21, 'Consumer_Safety', 'Product liability claims increasing with global supply chains. Manufacturers need comprehensive coverage including overseas manufacturing. Risk management essential. #ProductSafety', 'LinkedIn', '2024-02-14 14:10:00'),

-- Marine Insurance Posts (4 records)
(22, 'Shipping_Executive', 'Marine insurance premiums skyrocketing due to piracy risks in Red Sea region. War risk surcharges now 300% higher! Shipping industry needs better risk management solutions. #MarineInsurance #Shipping #Logistics', 'LinkedIn', '2024-01-15 10:20:00'),
(23, 'Marine_Underwriter', 'Reminder: Always declare cargo value accurately on marine policies. Underinsurance can result in general average contributions exceeding your claim recovery. #MarineInsurance #CargoInsurance', 'Twitter', '2024-01-16 16:00:00'),
(24, 'Logistics_Manager', 'Marine cargo insurance saved us. Container loss during storm covered. General average contributions handled by insurer. Critical coverage for international trade. #MarineInsurance #Logistics', 'LinkedIn', '2024-02-05 12:15:00'),
(25, 'Shipowner', 'P AND I coverage essential for vessel operators. Crew injury claim would have bankrupted us without coverage. Jones Act liability exposure enormous. #MarineInsurance #PI', 'Twitter', '2024-02-10 09:40:00'),

-- Aviation Insurance Posts (3 records)
(26, 'Aviation_Consultant', 'Great aviation insurance conference! Key trend: UAV and drone coverage is fastest growing segment. Traditional aviation carriers adapting quickly. Exciting times for aviation risk management. #AviationInsurance #Drones', 'Twitter', '2024-01-15 14:45:00'),
(27, 'Pilot_Association', 'Aviation hull and liability coverage protected our operation during total loss. Claims handling was professional. Business interruption coverage critical. Highly recommend. #AviationInsurance', 'LinkedIn', '2024-02-08 10:25:00'),
(28, 'Drone_Operator', 'UAV liability insurance required for Part 107 operations. Our policy covered property damage from drone crash. Essential coverage for commercial drone operations. #DroneInsurance', 'Twitter', '2024-02-13 13:50:00'),

-- Political Risk Posts (3 records)
(29, 'Project_Finance', 'Political risk insurance saved our infrastructure project! Government change led to contract frustration but coverage responded perfectly. Essential for any emerging market investment. #PoliticalRisk #ProjectFinance', 'LinkedIn', '2024-01-16 09:30:00'),
(30, 'International_Invest', 'Currency inconvertibility coverage critical for foreign investments. Trapped $50M repatriated thanks to political risk insurance. Coverage is expensive but worth it. #PoliticalRisk', 'LinkedIn', '2024-02-11 11:05:00');

-- =====================================================
-- 4. Multilingual Content Table - 20 Records
-- =====================================================
CREATE OR REPLACE TABLE multilingual_content (
    content_id INT,
    original_text VARCHAR,
    source_language VARCHAR,
    content_type VARCHAR
);

INSERT INTO multilingual_content VALUES
(1, 'Your cyber insurance claim has been approved. Incident response team will contact you within 24 hours. Coverage includes forensics, legal fees, and notification costs up to policy limits.', 'en', 'claims_notification'),
(2, 'Votre police D AND O a été renouvelée avec succès. Nouvelles limites: 10M€. La prime annuelle est de 85 000€. Les documents de police seront envoyés dans 48 heures.', 'fr', 'renewal_confirmation'),
(3, 'Wichtiger Hinweis: Ihre Cyber-Versicherung läuft in 30 Tagen ab. Erneuern Sie jetzt, um kontinuierlichen Schutz zu gewährleisten. Kontaktieren Sie uns für ein Angebot.', 'de', 'renewal_reminder'),
(4, 'サイバー保険のお見積もりありがとうございます。年間保険料は250万円、補償限度額は5億円です。リスク評価を2週間以内に実施いたします。', 'ja', 'quote_response'),
(5, 'Su reclamo de responsabilidad profesional está en revisión. Número de caso: EPL-2024-5567. Un ajustador será asignado dentro de 3 días hábiles. Documentación adicional puede ser requerida.', 'es', 'claims_update'),
(6, 'La sua polizza D AND O per amministratori e dirigenti è stata sottoscritta. Copertura: 15M€. Include Side A, B e C. Servizio legale 24/7 disponibile per emergenze.', 'it', 'policy_confirmation'),
(7, '사이버 보안 사고가 보고되었습니다. 사고 대응팀이 즉시 배치됩니다. 보험 증권 번호: CYB-2024-8899. 24시간 핫라인으로 연락주세요.', 'ko', 'incident_alert'),
(8, 'Sua apólice de seguro E AND O foi aprovada. Limite de cobertura: R$ 5 milhões. Franquia: R$ 50 mil. Vigência: 12 meses a partir de 01/03/2024.', 'pt', 'underwriting_approval'),
(9, 'Uw aansprakelijkheidsverzekering voor bestuurders en functionarissen is verlengd. Dekking verhoogd naar €20M. Premie: €95.000 per jaar. Polis documenten volgen per e-mail.', 'nl', 'policy_update'),
(10, 'Twoje ubezpieczenie cyber zostało aktywowane. Limit ochrony: 10 mln PLN. Obejmuje ransomware, naruszenia danych i przestoje biznesowe. Assistance 24/7.', 'pl', 'activation_notice'),
(11, 'Your marine cargo claim for MV Pacific Star has been assigned to surveyor Captain Morrison. Survey scheduled within 48 hours. General average adjuster appointed. Please provide all documentation.', 'en', 'marine_claims'),
(12, 'Votre réclamation d''assurance aviation a été reçue. Référence: AVI-2024-778899. L''expertise technique sera effectuée la semaine prochaine. Avion de remplacement approuvé pour 30 jours.', 'fr', 'aviation_claims'),
(13, 'Ihre Produkthaftpflichtversicherung deckt den Rückruf ab. Maximale Deckung: 5 Mio. €. Unser Krisenmanagement-Team steht zur Verfügung. Bitte kontaktieren Sie uns umgehend.', 'de', 'product_liability'),
(14, '政治リスク保険の請求が承認されました。契約不履行および資産没収がカバーされます。補償金額:1億2000万ドル。国際仲裁の支援を提供します。', 'ja', 'political_risk'),
(15, 'Su póliza de seguro marítimo incluye cobertura de guerra y piratería. Prima adicional: $150,000 anuales. Zonas de alto riesgo cubiertas. Contacte para más detalles.', 'es', 'marine_war_risk'),
(16, 'La sua copertura D AND O per azioni legali degli azionisti è stata attivata. Limite: 25M€. Spese legali coperte dal primo euro. Consulente legale assegnato.', 'it', 'do_litigation'),
(17, 'EPLI 보험 청구가 접수되었습니다. 사건 번호: EPL-2024-7788. 고용법 전문 변호사가 배정되었습니다. 3영업일 내 연락드리겠습니다.', 'ko', 'epli_claim'),
(18, 'Sua apólice de seguro de riscos políticos cobre inconversibilidade de moeda. Período de espera: 180 dias. Cobertura: 90% do valor. Documentação necessária em anexo.', 'pt', 'political_risk_currency'),
(19, 'Uw luchtvaartaansprakelijkheid claim wordt behandeld. Ongeval referentie: N845AV. Technisch onderzoek gepland. Huurvliegtuig goedgekeurd. Dekking bevestigd.', 'nl', 'aviation_liability'),
(20, 'Twoja polisa ubezpieczenia od odpowiedzialności zawodowej E AND O została odnowiona. Limit: 20 mln PLN. Składka roczna: 250,000 PLN. Dokumenty dostępne online.', 'pl', 'eo_renewal');

-- =====================================================
-- 5. Documents Table - 15 Records
-- =====================================================
CREATE OR REPLACE TABLE documents (
    doc_id INT,
    document_name VARCHAR,
    document_text VARCHAR,
    doc_type VARCHAR,
    created_date DATE
);

INSERT INTO documents VALUES
(1, 'Cyber_Claims_Report_Q4_2023.txt', 
 'Quarterly Cyber Insurance Claims Analysis - Q4 2023. Total Claims Filed: 247, representing 35% increase YoY. Average Claim Severity: $1.2M, up from $850K in Q3. Top Incident Types: Ransomware (42%), Business Email Compromise (28%), Data Breach (18%), DDoS Attacks (12%). Industry Distribution: Healthcare (35%), Financial Services (25%), Technology (20%), Manufacturing (12%), Retail (8%). Geographic Breakdown: North America 65%, Europe 22%, Asia-Pacific 13%. Average Time to First Payment: 18 days. Claims Denied: 8% due to policy exclusions or late reporting. Key Trends: Increased sophistication in ransomware attacks, growing impact of supply chain compromises, rising regulatory fines under GDPR and CCPA. Prevention Recommendations: Multi-factor authentication adoption, employee security training, incident response planning, regular security assessments. Forecast: Q1 2024 expected to see 20% increase in claims frequency.',
 'claims_report', '2024-01-05'),
(2, 'D_AND_O_Policy_Terms.txt',
 'Directors and Officers Liability Insurance Policy - Terms and Conditions. Policy Number: DO-2024-MASTER. Effective Date: January 1, 2024. Policy Period: 12 months. Coverage Parts: Side A (Individual Director/Officer Coverage) - Non-indemnifiable loss including bankruptcy, Side B (Corporate Reimbursement) - Company reimbursement for indemnification, Side C (Entity Coverage) - Securities claims against the company. Coverage Limits: $25,000,000 per claim and aggregate. Retention: $250,000 per claim. Extended Reporting Period: 6 years available at 300% annual premium. Covered Wrongful Acts: Breach of fiduciary duty, breach of duty of care/loyalty, mismanagement, errors in judgment, failure to supervise. Key Exclusions: Deliberate fraud, personal profit, prior pending litigation, bodily injury/property damage. Defense Costs: Covered within limits, duty to defend. Severability: Applies to coverage determinations. Non-rescindable: After 60-day contestability period. Claims Reporting: Written notice within 60 days of awareness.',
 'policy_terms', '2024-01-01'),
(3, 'E_AND_O_Underwriting_Guidelines.txt',
 'Errors & Omissions Professional Liability - Underwriting Guidelines 2024. Eligible Classes: Technology Consultants, Management Consultants, IT Service Providers, Software Developers, Financial Advisors, Marketing Agencies, Engineering Firms. Revenue Bands: Tier 1 ($0-$5M), Tier 2 ($5M-$25M), Tier 3 ($25M-$100M), Tier 4 ($100M+). Standard Limits: $1M/$2M minimum, up to $25M available. Retention Options: $10K, $25K, $50K, $100K. Rating Factors: Years in business, claims history, revenue growth, client concentration, project types, security certifications. Risk Management Credits: ISO certification (5% discount), Formal QA process (5%), Client contracts review (3%), Cyber security insurance (2%). Declined Risks: Companies with bankruptcy history, criminal investigations, pattern of claims, startup less than 2 years without experienced management. Required Information: 5-year loss history, client list, project descriptions, revenue breakdown, security measures. Premium Indication: 2.5% to 4.5% of revenue depending on risk profile.',
 'underwriting_guide', '2024-01-03'),
(4, 'Claims_Committee_Minutes.txt',
 'Claims Committee Meeting - January 15, 2024. Attendees: Margaret Foster (SVP Claims), Robert Kim (Chief Underwriter), Sarah Martinez (General Counsel), David Chen (Claims Manager Cyber), Lisa Wong (Claims Manager D AND O). Agenda: Large Loss Review and Reserve Analysis. Case 1: CYB-2024-0089 - Healthcare ransomware. Initial reserve: $2.5M. Incident response costs: $450K (forensics, legal). Notification expenses: $280K (50,000 patients). Regulatory fines pending: estimated $500K-$1M. Business interruption: $800K (14-day shutdown). Total exposure: $3.2M. Recommendation: Increase reserve to $3.5M, engage regulatory specialist. Case 2: DO-2024-0156 - Securities class action. Allegations: Misleading earnings statements. Claim amount: $15M. Defense costs to date: $1.2M. Coverage position: Covered subject to $500K retention. Outside counsel approved. Settlement discussions ongoing. Recommendation: Maintain $8M reserve. Action Items: Enhanced monitoring for both cases, monthly status reports required, board notification for both claims. Next meeting: February 15, 2024.',
 'meeting_minutes', '2024-01-15'),
(5, 'Master_Service_Agreement_TPA.txt',
 'Third Party Administrator Service Agreement. Contract Number: TPA-2024-001. Parties: Specialty Insurance Group (Carrier) and Claims Solutions Inc (TPA). Effective Date: March 1, 2024. Term: 36 months with annual renewal option. Services Scope: Claims intake and documentation, First notice of loss processing, Investigation coordination, Coverage analysis, Reserve recommendations, Settlement negotiations, Litigation management, Regulatory reporting. Performance Standards: Claims acknowledgment within 4 hours, Initial coverage position within 5 business days, Monthly reporting by 10th of month, 95% customer satisfaction target. Fee Structure: Per-claim fee $750 for claims under $100K, $1,500 for claims $100K-$1M, $3,000 for claims over $1M, Monthly retainer: $15,000. Audit Rights: Carrier may audit TPA files quarterly. Technology: TPA must use carrier portal for all claim updates. Confidentiality: 10-year obligation post-termination. Termination: 90 days written notice, immediate for cause. Insurance Requirements: E AND O coverage $10M, Cyber insurance $5M, General liability $2M. Governing Law: New York.',
 'service_agreement', '2024-01-20'),
(6, 'Marine_Market_Analysis_2024.txt',
 'Marine Insurance Market Analysis 2024. Market Size: $35B globally. Growth Rate: 8% YoY driven by global trade expansion and climate-related losses. Hull Insurance: Average vessel values increasing 12% due to supply chain disruptions and new builds. Cargo Insurance: Claims frequency up 15% due to port congestion and logistics challenges. War Risk: Red Sea piracy incidents increased premiums by 300% for affected routes. Geopolitical tensions impacting trade routes through Suez Canal and Strait of Hormuz. P AND I Coverage: Crew injury claims trending upward. Jones Act litigation in US waters. Environmental liability growing concern with IMO 2030 regulations. Key Trends: Autonomous vessels requiring new coverage frameworks, Climate change impacting weather-related losses, Cyber threats to vessel navigation systems, Supply chain disruptions affecting cargo transit times. Lloyd Market: Remains dominant with 60% market share in marine hull. Emerging Markets: Asia-Pacific growth driven by Chinese Belt and Road infrastructure projects.',
 'marine_report', '2024-01-25'),
(7, 'Aviation_Underwriting_Manual.txt',
 'Aviation Insurance Underwriting Manual 2024. Coverage Types: Hull Insurance (physical damage to aircraft), Liability Coverage (bodily injury and property damage), Passenger Liability, Product Liability (manufacturers), War and Terrorism. Aircraft Categories: Commercial Airlines (Part 121), Charter Operations (Part 135), General Aviation, UAV and Drones, Helicopters, Corporate Jets. Valuation: Agreed value for hull coverage, Market value assessments required annually, Depreciation schedules for older aircraft. Rating Factors: Pilot experience and certifications, Aircraft age and maintenance history, Operating territory and routes, Safety management systems, Claims history last 5 years. War Risk: Separate premium charged, High-risk zones require Lloyd market capacity, Terrorism coverage increasingly bundled. Drone Coverage: Fastest growing segment, Liability limits $1M-$10M typical, Regulatory compliance required (FAA Part 107). Claims: Average hull claim $2.5M, Liability claims can exceed $100M for major incidents, Business interruption critical for commercial operators. Market Capacity: Lloyd market provides 70% of aviation capacity, Specialist aviation syndicates required for large accounts.',
 'aviation_manual', '2024-01-28'),
(8, 'Political_Risk_Assessment_Guide.txt',
 'Political Risk Insurance Assessment Guide. Coverage Areas: Expropriation and Confiscation (government seizure of assets), Currency Inconvertibility and Non-Transfer (inability to convert local currency or transfer funds), Political Violence (war, civil unrest, terrorism), Contract Frustration (government breach of contract). Eligible Projects: Infrastructure (power plants, ports, roads), Energy (oil, gas, renewable), Mining and extractive industries, Manufacturing facilities, Real estate development. Risk Assessment Factors: Country sovereign rating, Political stability index, Legal system strength, History of expropriation, Currency controls and restrictions. Coverage Structure: Maximum period 15-20 years, Extensions available for long-term projects, Waiting periods for currency inconvertibility (60-180 days), Percentage of loss coverage (90-95% typical). Premium Calculation: Based on country risk rating, Project type and size, Coverage period, Claim history in region. Claims Process: Notification within 30 days of event, Waiting periods before claim payment, Subrogation rights to insurer, International arbitration for disputes. Key Providers: Multilateral agencies (World Bank MIGA, ADB), Private market (Lloyd syndicates, specialist carriers), Export credit agencies (EXIM, EDC). Emerging Trends: Climate change impacting project viability, Renewable energy projects increasing, China Belt and Road creating demand, Sanctions complicating coverage.',
 'political_risk_guide', '2024-02-01'),
(9, 'Product_Liability_Trends_2024.txt',
 'Product Liability Insurance Market Trends 2024. Market Size: $12B annually in US. Claims Frequency: Increasing 8% YoY driven by consumer awareness and social media amplification. Average Claim Size: $2.5M including defense costs. Top Risk Categories: Consumer electronics (battery fires, 22%), Pharmaceuticals (side effects, 18%), Food products (contamination, 15%), Automotive (recalls, 14%), Children products (safety hazards, 12%), Medical devices (malfunction, 10%), Other (9%). Key Trends: Global supply chains increasing exposure, Social media accelerating recall awareness, E-commerce expanding distribution risks, Regulatory environment tightening (CPSC, FDA), Mass tort litigation becoming more sophisticated. Defense Costs: Average $500K per claim, Complex cases can exceed $5M, Trial costs significantly higher. Prevention: Quality control systems, Compliance documentation, Supply chain audits, Product testing protocols, Warning labels and instructions. Underwriting Factors: Manufacturing location, Quality certifications (ISO), Claims history, Product testing, Distribution channels. Premium Trends: Established products with good history: flat to -5%, New products or high-risk categories: +15-25%, Companies with recent recalls: +40-60%.',
 'product_liability_trends', '2024-02-05'),
(10, 'EPLI_Claims_Analysis_2023.txt',
 'Employment Practices Liability Insurance Claims Analysis 2023. Total Claims: 1,847 across all insureds. Average Claim Cost: $160K including defense and settlement. Claims Distribution: Wrongful termination (38%), Discrimination (race 12%, age 10%, gender 8%, disability 6%), Harassment (sexual 14%, other 7%), Retaliation (5%). Settlement Rates: 65% of claims settled, 25% dismissed, 10% tried to verdict. Defense Costs: Average $80K per claim, Trials average $300K in defense costs. Verdict Analysis: Plaintiff win rate at trial: 45%, Average verdict: $500K, Highest verdict 2023: $5M age discrimination. Industry Trends: Remote work disputes emerging as new category, Wage and hour class actions increasing, Social media evidence becoming critical, Younger workforce more litigation-prone. Prevention: Documented HR policies, Regular training programs, Prompt investigation of complaints, Consistent application of policies, Legal review before terminations. Premium Trends: Claims-free insureds: -5-10%, Prior claims: +20-40%, High-risk industries (hospitality, retail): +15-25%. Best Practices: Employment practices audit annually, Manager training on documentation, Anti-harassment training mandatory, Legal counsel involvement in major decisions.',
 'epli_analysis', '2024-02-08'),
(11, 'Cyber_Insurance_Market_Outlook.txt',
 'Cyber Insurance Market Outlook 2024-2025. Market Maturation: Cyber insurance evolving from nascent to mature market. Premium volume: $12B in 2023, projected $20B by 2025. Market Dynamics: Pricing stabilization after 2020-2022 hardening, Increased capacity from new entrants, More sophisticated underwriting with security controls assessment, Claims experience improving loss ratios. Coverage Evolution: Ransomware coverage more common but with conditions, Business interruption coverage expansion, Regulatory coverage (GDPR, CCPA fines), Supply chain coverage emerging. Underwriting Innovation: Security questionnaires becoming standardized, Third-party security ratings integration, Real-time monitoring of security posture, Premium credits for MFA and EDR deployment. Claims Trends: Ransomware remaining top peril, Social engineering attacks increasing, Cloud service disruptions emerging concern, Regulatory actions becoming more frequent. Future Outlook: AI-driven underwriting and pricing, Integration with security services, Parametric coverage for specific events, Collaboration with government on systemic risk. Risk Management: Pre-breach services becoming standard, Tabletop exercises and training, Incident response planning, Regular security assessments.',
 'cyber_outlook', '2024-02-10'),
(12, 'Marine_P_AND_I_Coverage_Guide.txt',
 'Protection and Indemnity Club Coverage Guide 2024. P AND I Basics: Mutual insurance associations covering ship operators. Coverage includes crew liability, cargo damage, collision liability, wreck removal, pollution, stowaways. International Group: 13 major P AND I Clubs providing 90% of world tonnage coverage. Coverage Limits: Standard coverage up to $10B through pooling and reinsurance. Entry Criteria: Ship management standards, Safety records, Compliance with ISM Code. Premium Structure: Advance calls based on tonnage, Supplementary calls if needed, Discount for good claims records. Crew Claims: Jones Act liability for US operations, Medical treatment and repatriation, Death and disability benefits, Wage disputes. Cargo Liability: Damage or loss in transit, Deviation from contract, Insufficient ventilation or temperature control. Collision: Four-fifths collision liability, Protection from other vessel claims, Legal costs and interest. Pollution: Oil spills under OPA 90, International conventions (CLC, Bunkers), Cleanup costs and fines. Wreck Removal: Removal obligations under maritime law, Costs can exceed vessel value, Coverage essential for older vessels.',
 'marine_pi_guide', '2024-02-12'),
(13, 'D_AND_O_Securities_Litigation.txt',
 'D AND O Insurance and Securities Litigation Guide 2024. Securities Claims Overview: Most common and costly D AND O claims. Allegations: Material misrepresentations in disclosures, Omissions of material facts, Insider trading, Accounting fraud. Venues: Federal courts (Securities Act, Exchange Act), State courts (fiduciary duty), Regulatory (SEC, DOJ). Coverage Triggers: Claims-made coverage, Discovery retroactive date, Policy period when claim first made. Defense: Coverage for defense costs within or outside limits, Duty to defend vs. duty to reimburse, Defense counsel selection. Settlement: Coverage for settlements and judgments, Allocation between insured and uninsured, Approval rights for settlements. Exclusions: Deliberate fraud if proven, Personal profit if established, Prior litigation if pending before policy. Side A Coverage: Non-indemnifiable loss, Bankruptcy protection, Priority of payment. Best Practices: Disclosure committees for public companies, Legal review of material announcements, Trading policies and blackout periods, Insurance sufficient for market capitalization.',
 'd_and_o_securities', '2024-02-14'),
(14, 'Aviation_Product_Liability.txt',
 'Aviation Product Liability Coverage 2024. Scope: Manufacturers and suppliers of aircraft, parts, avionics, engines. Exposure: Design defects, Manufacturing defects, Failure to warn, Breach of warranty. Claims Characteristics: High severity, potential for mass casualties, Long tail (claims years after manufacture), Global exposure. Coverage Structure: Per occurrence limits $50M-$500M typical, Annual aggregate limits, Products completed operations, Worldwide territory. Underwriting Factors: Product type and criticality, Quality control systems, Certification history (FAA, EASA), Claims and recall history, Installation base. Defense: Specialized aviation counsel required, Technical expert witnesses, NTSB investigation coordination. Key Issues: Airworthiness Directives impact, Retrofit and modification liability, Component vs. finished goods, Military vs. civilian aircraft. Market: Lloyd aviation syndicates dominant, US admitted market limited capacity, London market for large programs. Premium: Based on sales revenue, Product line factor, Claims experience, Quality certifications.',
 'aviation_product_liability', '2024-02-15'),
(15, 'Political_Risk_Infrastructure_Projects.txt',
 'Political Risk Insurance for Infrastructure Projects 2024. Infrastructure Exposure: Long-term investments vulnerable to political events, Capital-intensive with limited flexibility, Government counterparties creating risk, Revenue dependent on regulatory framework. Key Risks: Expropriation without adequate compensation, Currency inconvertibility preventing repatriation, Political violence disrupting operations, Contract frustration by government. Coverage Solutions: Political Risk Insurance (PRI) from private market, Multilateral investment guarantees (MIGA, ADB), Export credit agency support (EXIM, EDC). Structure: Coverage period 15-20 years typical, Waiting periods vary by peril, Percentage of loss (90-95%), Coinsurance often required. Premium: Country risk rating primary factor, Project type and sector, Coverage period, Investor nationality. Claims Process: Notice requirements within 30 days, Waiting periods before payment, Salvage and subrogation, International arbitration common. Due Diligence: Political risk assessment, Legal framework analysis, Government stability review, Currency controls examination, Contract enforceability.',
 'political_risk_infrastructure', '2024-02-16');

-- =====================================================
-- 6. Unstructured Data Table - 15 Records
-- =====================================================
CREATE OR REPLACE TABLE unstructured_data (
    data_id INT,
    raw_text VARCHAR,
    data_source VARCHAR
);

INSERT INTO unstructured_data VALUES
(1, 'URGENT CLAIM: Contact Claims Manager Sarah Peterson at speterson@specialtyins.com or emergency hotline +1-855-CLAIM-24. Cyber incident reported by TechHealth Inc, policy CYB-2024-445566. Ransomware attack detected January 18, 2024 at 3:45 AM EST. Estimated affected records: 75,000 patient files. Immediate incident response required.',
 'claims_notification'),
(2, 'Premium Invoice INV-DO-2024-1567 dated February 1, 2024. Insured: Global Manufacturing Corp. Policy: Directors & Officers Liability DO-2024-GM-789. Coverage Amount: $15,000,000. Annual Premium: $125,500.00. Payment Terms: Net 30 days. Due Date: March 3, 2024. Account Manager: Robert Kim, ext. 4455.',
 'premium_invoice'),
(3, 'Underwriting Meeting scheduled for February 15, 2024 at 10:00 AM EST. Attendees: Chief Underwriter Margaret Foster, Senior Underwriter David Chen, Actuarial Lead Lisa Martinez. Subject: Large account review - E AND O policy for Software Solutions Inc. Revenue $50M, requesting $10M limits. Conference Room: Executive Suite A, 15th Floor.',
 'meeting_notice'),
(4, 'Policy Quote QT-EPL-2024-8899 for Employment Practices Liability. Prospect: MedTech Innovations LLC. Employees: 450. Coverage Requested: $5M per claim, $5M aggregate. Premium Indication: $67,500 annually. Retention: $100,000. Quote valid until March 31, 2024. Underwriter: James Wilson. Territory: Multi-state (CA, TX, NY, FL).',
 'quote_document'),
(5, 'Loss Run Request for TechCorp International. Policy Period: 2019-2024. Insurance Type: D AND O, E AND O, Cyber, EPLI. Total Claims: 8. Paid Losses: $2.3M. Outstanding Reserves: $1.8M. Incidents: 3 D AND O claims (securities litigation), 2 E AND O claims (contract disputes), 2 Cyber incidents (data breaches), 1 EPLI claim (wrongful termination). Requested by: Broker Smith & Associates for renewal underwriting.',
 'loss_run'),
(6, 'MARINE CARGO CLAIM: Vessel MV Pacific Star, IMO 9876543. Port of loading: Shanghai. Destination: Los Angeles. Cargo: Electronics valued at USD 8.5M. Policy MAR-2024-556677. General Average declared January 28, 2024. Contact Marine Claims Dept at marine.claims@specialtyins.com. Surveyor: Captain James Morrison, +1-555-MARINE-1.',
 'marine_claim'),
(7, 'AVIATION INCIDENT REPORT: Aircraft N845AV, Boeing 737-800. Incident date: January 27, 2024. Location: Denver International Airport. Damage: Landing gear. Policy AVI-2024-778899. Hull value: $45M. Contact Aviation Claims at aviation@specialtyins.com or 24/7 hotline +1-855-AVCLAIM. Engineer inspection required.',
 'aviation_claim'),
(8, 'POLITICAL RISK ALERT: Project Titan Power Plant, Country: Emerging Market X. Expropriation event: January 20, 2024. Contract value: USD 120M. Policy POL-2024-334455. Coverage: Contract frustration, asset confiscation. Contact: political.risk@specialtyins.com. Legal team: International Arbitration Group. Urgent action required.',
 'political_risk_claim'),
(9, 'PRODUCT RECALL NOTICE: Manufacturer: SafeToys Inc. Product: Battery-operated teddy bears. Model: TB-2024. Reason: Choking hazard - button eyes detach. Units affected: 50,000. Policy: PL-2024-778899. CPSC Report filed. Contact: Rachel Adams, Product Safety Coordinator, radams@safetoys.com, +1-555-RECALL-1.',
 'product_recall'),
(10, 'EPLI CLAIM NOTIFICATION: Claimant: Jane Doe vs. TechStart Inc. Allegation: Age discrimination and wrongful termination. Termination date: January 15, 2024. Claimant age: 58. Replacement age: 32. Policy: EPL-2024-334455. EEOC Charge filed. Employment attorney: Michael Stevens, mstevens@employmentlaw.com, +1-555-EMPLOY-1.',
 'epli_claim'),
(11, 'CYBER BREACH REPORT: Company: HealthData Systems. Breach type: Phishing leading to credential theft. Systems compromised: Patient database, billing system. Records affected: 125,000. HIPAA violation. Policy: CYB-2024-998877. Forensics: CyberForensics LLC. Contact: Brian Mitchell, CISO, bmitchell@healthdata.com.',
 'cyber_breach'),
(12, 'MARINE P AND I INCIDENT: Vessel: MV Atlantic Voyager. Incident: Crew member fall from height. Injury: Fractured leg, internal injuries. Medical evacuation: Helicopter to nearest port. Estimated medical costs: $150K. Jones Act exposure. Policy: PI-2024-889900. Contact: Captain John Peterson, +1-555-VESSEL-1.',
 'marine_pi_incident'),
(13, 'D AND O SECURITIES COMPLAINT: Defendant: TechCorp Inc. and Board of Directors. Court: US District Court, Southern District NY. Case: 24-CV-1234. Allegation: Material misrepresentation in Q3 2023 earnings. Stock drop: 35%. Class period: July-October 2023. Policy: DO-2024-445566. Defense counsel: Morrison & Foerster.',
 'securities_complaint'),
(14, 'AVIATION TOTAL LOSS: Aircraft: N123CA, Cessna Citation X. Incident: Crash on takeoff, mechanical failure suspected. Location: Chicago Executive Airport. Date: February 5, 2024. Fatalities: 2 crew. NTSB investigating. Hull value: $35M. Policy: AVI-2024-556677. Contact: Aviation Claims, +1-855-AVIHELP.',
 'aviation_total_loss'),
(15, 'POLITICAL VIOLENCE CLAIM: Project: Diamond Mine, Country: African Nation Y. Incident: Armed conflict shuttered operations. Date: February 1, 2024. Duration: Ongoing (6+ months expected). Property damage: $25M. Business interruption: $10M/month. Policy: POL-2024-556677. Security consultant: Global Risk Services. Contact: David Kumar, +1-555-POLIT-1.',
 'political_violence');

-- =====================================================
-- 7. Create views for easy access in Streamlit
-- =====================================================
CREATE OR REPLACE VIEW vw_recent_tickets AS
SELECT * FROM customer_tickets ORDER BY created_date DESC LIMIT 100;

CREATE OR REPLACE VIEW vw_recent_reviews AS
SELECT * FROM product_reviews ORDER BY review_date DESC LIMIT 100;

CREATE OR REPLACE VIEW vw_multilingual_content AS
SELECT * FROM multilingual_content ORDER BY content_id;

-- =====================================================
-- Grant necessary privileges
-- =====================================================
GRANT USAGE ON DATABASE CORTEX_AISQL_DEMO TO ROLE PUBLIC;
GRANT USAGE ON SCHEMA DEMO_DATA TO ROLE PUBLIC;
GRANT SELECT ON ALL TABLES IN SCHEMA DEMO_DATA TO ROLE PUBLIC;
GRANT SELECT ON ALL VIEWS IN SCHEMA DEMO_DATA TO ROLE PUBLIC;
GRANT READ ON STAGE streamlit_stage TO ROLE PUBLIC;

-- Show summary
SELECT 'Large dataset setup complete!' AS status;
SELECT 'Customer Tickets: ' || COUNT(*) AS summary FROM customer_tickets
UNION ALL
SELECT 'Product Reviews: ' || COUNT(*) FROM product_reviews
UNION ALL
SELECT 'Multilingual Content: ' || COUNT(*) FROM multilingual_content
UNION ALL
SELECT 'Documents: ' || COUNT(*) FROM documents
UNION ALL
SELECT 'Social Media Posts: ' || COUNT(*) FROM social_media_posts
UNION ALL
SELECT 'Unstructured Data: ' || COUNT(*) FROM unstructured_data;

