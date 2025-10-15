-- =====================================================
-- Cortex AISQL Demo - Data Setup Script
-- =====================================================
-- This script creates sample data for demonstrating all Cortex AISQL functions

-- Create database and schema
CREATE DATABASE IF NOT EXISTS CORTEX_AISQL_DEMO;
USE DATABASE CORTEX_AISQL_DEMO;
CREATE SCHEMA IF NOT EXISTS DEMO_DATA;
USE SCHEMA DEMO_DATA;

-- Create stage for file operations
CREATE STAGE IF NOT EXISTS streamlit_stage;

-- =====================================================
-- 1. Customer Tickets Table (for AI_EXTRACT, AI_AGG, AI_SENTIMENT)
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
(1, 'Robert Chen', 'rchen@techstartup.com', 
 'We need to file a D AND O claim. Our board made a decision on January 15, 2024 that resulted in shareholder litigation. Policy number: DO-2024-789456. The lawsuit alleges breach of fiduciary duty. Total claim amount estimated at $2.5M. Please expedite review.', 
 '2024-01-20', 'Claims'),
(2, 'Jennifer Martinez', 'jmartinez@healthcare-co.com',
 'Urgent cyber incident! We experienced a ransomware attack on January 18, 2024. Approximately 50,000 patient records potentially compromised. Cyber insurance policy CYB-2024-123890. Need immediate incident response team and coverage confirmation. Attack vector appears to be phishing email.',
 '2024-01-18', 'Claims'),
(3, 'Michael Thompson', 'mthompson@consultingfirm.com',
 'Requesting E AND O coverage information for our consulting firm. We have 25 consultants and annual revenue of $5M. Need professional liability limits of $3M per claim and $5M aggregate. What are your premium rates? Policy effective date needed: March 1, 2024.',
 '2024-01-22', 'New Business'),
(4, 'Sarah Kim', 'skim@manufacturing.com',
 'Product recall notice filed yesterday. Our manufacturing defect affected 10,000 units. Product liability policy PL-2024-567123 should cover this. Recall costs estimated at $500K. No injuries reported yet but preventive action required. Need claims adjuster assigned urgently.',
 '2024-01-19', 'Claims'),
(5, 'David Rodriguez', 'drodriguez@lawfirm.com',
 'Professional liability claim notification. Client alleges legal malpractice in contract negotiation. Incident date: December 10, 2023. Policy: PL-LAW-2024-445566. Potential damages: $1.2M. We have documentation showing proper procedures were followed. Request defense counsel assignment.',
 '2024-01-21', 'Claims'),
(6, 'Amanda Foster', 'afoster@techsolutions.com',
 'Thank you for the excellent claims handling on our recent cyber breach! Your incident response team was phenomenal. They contained the breach within 48 hours and helped us notify affected customers. Policy CYB-2023-998877. Outstanding service!',
 '2024-01-23', 'Feedback'),
(7, 'James Wilson', 'jwilson@nonprofit.org',
 'Employment practices liability question. Former employee filed discrimination lawsuit on January 16, 2024. EPLI policy EPL-2024-334455. Claim amount: $750K. We followed all HR policies and have documentation. Need coverage confirmation and legal representation.',
 '2024-01-17', 'Claims'),
(8, 'Lisa Chen', 'lchen@medtech.com',
 'Requesting quote for medical device E AND O coverage. Annual revenue: $20M. Product: AI-powered diagnostic software. Need coverage for FDA compliance issues and product liability. Looking for $10M limits. Clinical trials phase completed. Risk assessment needed.',
 '2024-01-24', 'New Business'),
(9, 'Carlos Mendez', 'cmendez@fintech.com',
 'Cyber policy renewal due February 15, 2024. Current policy: CYB-2023-776655. We upgraded our security infrastructure and implemented MFA. Should qualify for better rates. Also need to increase limits from $5M to $10M due to company growth. Current premium: $45K annually.',
 '2024-01-25', 'Renewal'),
(10, 'Patricia Lee', 'plee@boardmembers.com',
 'D AND O policy inquiry for our board members. We are a public company, market cap $500M. Need Side A, B, and C coverage. Previous insurer non-renewed us. Looking for $25M in coverage. Any prior acts coverage available? Board size: 9 members. Need quote by end of month.',
 '2024-01-26', 'New Business');

-- =====================================================
-- 2. Product Reviews Table (for AI_SENTIMENT, AI_CLASSIFY, AI_FILTER)
-- =====================================================
CREATE OR REPLACE TABLE product_reviews (
    review_id INT,
    product_name VARCHAR,
    review_text VARCHAR,
    rating INT,
    review_date DATE
);

INSERT INTO product_reviews VALUES
(1, 'Cyber Insurance Premier', 'Outstanding coverage! When we had a ransomware incident, the claims team responded within 2 hours. Incident response was top-notch. Coverage included forensics, legal fees, and notification costs. Premium is competitive. Highly recommend for tech companies!', 5, '2024-01-10'),
(2, 'D AND O Basic Policy', 'Very disappointed with claims handling. Took 6 weeks to assign defense counsel. Coverage exclusions were not clearly explained during sales process. Claim was partially denied due to obscure policy language. Would not renew.', 1, '2024-01-11'),
(3, 'E AND O Professional Plus', 'Adequate coverage for small consulting firms. Premium is reasonable at $8K annually for $2M limits. Claims process is straightforward. However, policy has high deductible of $25K. Good value but not great for frequent small claims.', 3, '2024-01-12'),
(4, 'Cyber Shield Enterprise', 'Best cyber insurance we have ever purchased! Comprehensive coverage including business interruption, ransomware payments, and regulatory fines. Risk assessment team helped improve our security posture. Premium discount for good security practices. Excellent!', 5, '2024-01-13'),
(5, 'EPLI Standard Coverage', 'Claims adjuster was slow to respond and seemed inexperienced with employment law. Coverage limits were inadequate for our settlement. Policy excluded several key employment practices. Better options available in the market.', 2, '2024-01-14'),
(6, 'Professional Liability Tech', 'Decent E AND O coverage for software companies. Pricing is competitive. Coverage includes IP infringement and data breach. Policy wording could be clearer on exclusions. Average experience overall but meets basic needs.', 3, '2024-01-15'),
(7, 'Directors Shield Gold', 'Exceptional D AND O coverage! Side A, B, and C all included. Non-recourse advancement of defense costs. Claims team has deep expertise in securities litigation. Premium was higher but worth it for peace of mind. Our board loves this coverage!', 5, '2024-01-16'),
(8, 'Cyber Essentials SMB', 'Coverage limits are too low for actual cyber incidents. $500K limit barely covered our notification costs. No coverage for ransomware payments. Support team was unhelpful during our crisis. Not suitable for any serious business.', 2, '2024-01-17'),
(9, 'Product Liability Plus', 'Policy excluded our main product line due to "high risk" classification. Underwriting was rigid and inflexible. Premium quote was 40% higher than competitors. Application process took forever. Went with another carrier.', 2, '2024-01-18'),
(10, 'Management Liability Package', 'Excellent bundled coverage! Includes D AND O, EPLI, Fiduciary, and Crime. One premium, one deductible, streamlined claims. Saved 20% vs buying policies separately. Great for mid-size companies. Very satisfied with coverage and service.', 4, '2024-01-19');

-- =====================================================
-- 3. Multilingual Content Table (for AI_TRANSLATE)
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
(10, 'Twoje ubezpieczenie cyber zostało aktywowane. Limit ochrony: 10 mln PLN. Obejmuje ransomware, naruszenia danych i przestoje biznesowe. Assistance 24/7.', 'pl', 'activation_notice');

-- =====================================================
-- 4. Documents/Text for Parsing (for AI_EXTRACT, AI_SUMMARIZE_AGG)
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
(2, 'D AND O_Policy_Terms.txt',
 'Directors and Officers Liability Insurance Policy - Terms and Conditions. Policy Number: DO-2024-MASTER. Effective Date: January 1, 2024. Policy Period: 12 months. Coverage Parts: Side A (Individual Director/Officer Coverage) - Non-indemnifiable loss including bankruptcy, Side B (Corporate Reimbursement) - Company reimbursement for indemnification, Side C (Entity Coverage) - Securities claims against the company. Coverage Limits: $25,000,000 per claim and aggregate. Retention: $250,000 per claim. Extended Reporting Period: 6 years available at 300% annual premium. Covered Wrongful Acts: Breach of fiduciary duty, breach of duty of care/loyalty, mismanagement, errors in judgment, failure to supervise. Key Exclusions: Deliberate fraud, personal profit, prior pending litigation, bodily injury/property damage. Defense Costs: Covered within limits, duty to defend. Severability: Applies to coverage determinations. Non-rescindable: After 60-day contestability period. Claims Reporting: Written notice within 60 days of awareness.',
 'policy_terms', '2024-01-01'),
(3, 'E AND O_Underwriting_Guidelines.txt',
 'Errors & Omissions Professional Liability - Underwriting Guidelines 2024. Eligible Classes: Technology Consultants, Management Consultants, IT Service Providers, Software Developers, Financial Advisors, Marketing Agencies, Engineering Firms. Revenue Bands: Tier 1 ($0-$5M), Tier 2 ($5M-$25M), Tier 3 ($25M-$100M), Tier 4 ($100M+). Standard Limits: $1M/$2M minimum, up to $25M available. Retention Options: $10K, $25K, $50K, $100K. Rating Factors: Years in business, claims history, revenue growth, client concentration, project types, security certifications. Risk Management Credits: ISO certification (5% discount), Formal QA process (5%), Client contracts review (3%), Cyber security insurance (2%). Declined Risks: Companies with bankruptcy history, criminal investigations, pattern of claims, startup less than 2 years without experienced management. Required Information: 5-year loss history, client list, project descriptions, revenue breakdown, security measures. Premium Indication: 2.5% to 4.5% of revenue depending on risk profile.',
 'underwriting_guide', '2024-01-03'),
(4, 'Claims_Committee_Minutes.txt',
 'Claims Committee Meeting - January 15, 2024. Attendees: Margaret Foster (SVP Claims), Robert Kim (Chief Underwriter), Sarah Martinez (General Counsel), David Chen (Claims Manager Cyber), Lisa Wong (Claims Manager D AND O). Agenda: Large Loss Review and Reserve Analysis. Case 1: CYB-2024-0089 - Healthcare ransomware. Initial reserve: $2.5M. Incident response costs: $450K (forensics, legal). Notification expenses: $280K (50,000 patients). Regulatory fines pending: estimated $500K-$1M. Business interruption: $800K (14-day shutdown). Total exposure: $3.2M. Recommendation: Increase reserve to $3.5M, engage regulatory specialist. Case 2: DO-2024-0156 - Securities class action. Allegations: Misleading earnings statements. Claim amount: $15M. Defense costs to date: $1.2M. Coverage position: Covered subject to $500K retention. Outside counsel approved. Settlement discussions ongoing. Recommendation: Maintain $8M reserve. Action Items: Enhanced monitoring for both cases, monthly status reports required, board notification for both claims. Next meeting: February 15, 2024.',
 'meeting_minutes', '2024-01-15'),
(5, 'Master_Service_Agreement_TPA.txt',
 'Third Party Administrator Service Agreement. Contract Number: TPA-2024-001. Parties: Specialty Insurance Group (Carrier) and Claims Solutions Inc (TPA). Effective Date: March 1, 2024. Term: 36 months with annual renewal option. Services Scope: Claims intake and documentation, First notice of loss processing, Investigation coordination, Coverage analysis, Reserve recommendations, Settlement negotiations, Litigation management, Regulatory reporting. Performance Standards: Claims acknowledgment within 4 hours, Initial coverage position within 5 business days, Monthly reporting by 10th of month, 95% customer satisfaction target. Fee Structure: Per-claim fee $750 for claims under $100K, $1,500 for claims $100K-$1M, $3,000 for claims over $1M, Monthly retainer: $15,000. Audit Rights: Carrier may audit TPA files quarterly. Technology: TPA must use carrier portal for all claim updates. Confidentiality: 10-year obligation post-termination. Termination: 90 days written notice, immediate for cause. Insurance Requirements: E AND O coverage $10M, Cyber insurance $5M, General liability $2M. Governing Law: New York.',
 'service_agreement', '2024-01-20');

-- =====================================================
-- 5. Social Media Posts (for AI_CLASSIFY, AI_FILTER, AI_SENTIMENT)
-- =====================================================
CREATE OR REPLACE TABLE social_media_posts (
    post_id INT,
    username VARCHAR,
    post_text VARCHAR,
    platform VARCHAR,
    post_date TIMESTAMP
);

INSERT INTO social_media_posts VALUES
(1, 'CFO_Network', 'Just renewed our D AND O insurance. Premium increased 40% this year! Market is hardening significantly. Other CFOs seeing similar increases? #DirectorsAndOfficers #Insurance #CFO', 'LinkedIn', '2024-01-10 09:15:00'),
(2, 'CyberSec_Daily', 'ALERT: New ransomware variant targeting healthcare systems. Make sure your cyber insurance covers incident response and business interruption. Prevention is key! #CyberSecurity #Ransomware #Healthcare', 'Twitter', '2024-01-10 07:30:00'),
(3, 'Startup_Founder', 'Our E AND O insurance claim was denied because of a technicality in the application. Read the fine print people! Now facing a $500K lawsuit without coverage. This is devastating.', 'Twitter', '2024-01-10 19:45:00'),
(4, 'Risk_Manager_Pro', 'Excellent webinar on emerging cyber risks in 2024! Key takeaway: AI-powered attacks are increasing. Time to review your cyber insurance limits. #RiskManagement #Insurance', 'LinkedIn', '2024-01-11 14:20:00'),
(5, 'Insurance_Broker', 'Frustrated with the current D AND O market. Underwriters are asking for ridiculous amounts of information and still declining good risks. Clients are suffering. Something needs to change!', 'LinkedIn', '2024-01-11 21:00:00'),
(6, 'Board_Member', 'Grateful for our D AND O coverage today. Shareholder lawsuit filed but our carrier assigned excellent defense counsel within 48 hours. Worth every penny of the premium. #BoardService #D AND O', 'LinkedIn', '2024-01-12 16:45:00'),
(7, 'CISO_Forum', 'PSA: If you have cyber insurance, review your policy NOW. Many policies exclude ransomware payments or have sublimits that won\'t cover a real incident. #CISO #CyberInsurance #InfoSec', 'Twitter', '2024-01-12 11:30:00'),
(8, 'Legal_Tech', 'Interesting case law development on D AND O Side A coverage. Delaware Court ruling could impact how we think about insured vs. insured exclusions. Insurance nerds unite! #InsuranceLaw #D AND O', 'LinkedIn', '2024-01-13 22:15:00'),
(9, 'InsurTech_News', 'Breaking: Global cyber insurance market projected to reach $20B by 2025. Huge opportunity for innovation in underwriting and claims handling. #InsurTech #CyberInsurance', 'Twitter', '2024-01-14 08:00:00'),
(10, 'SMB_Owner', 'Finally got proper insurance coverage for my consulting business. E AND O policy gives me peace of mind when signing big contracts. Highly recommend all consultants get this! #SmallBusiness #Consulting', 'LinkedIn', '2024-01-14 17:30:00');

-- =====================================================
-- 6. Entity Extraction Table (for AI_EXTRACT)
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
 'loss_run');

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
SELECT 'Data setup complete!' AS status;
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

