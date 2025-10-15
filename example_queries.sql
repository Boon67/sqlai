-- =====================================================
-- Snowflake Cortex AISQL Example Queries
-- Specialty Insurance Demo
-- =====================================================
-- All queries tested and working with insurance data
-- Use these as templates for your own implementations
-- =====================================================

USE DATABASE CORTEX_AISQL_DEMO;
USE SCHEMA DEMO_DATA;

-- =====================================================
-- 1. AI_EXTRACT - Entity Extraction from Insurance Documents
-- =====================================================

-- Extract policy numbers, claim amounts, and insurance types from customer tickets
SELECT 
    ticket_id,
    customer_name,
    AI_EXTRACT(
        ticket_text,
        [['policy_number','What is the policy number or order number?']]
    ):response.policy_number::string as policy_number,
    AI_EXTRACT(
        ticket_text,
        [['claim_amount','What is the claim amount or dollar value mentioned?']]
    ):response.claim_amount::string as claim_amount,
    AI_EXTRACT(
        ticket_text,
        [['insurance_type','What type of insurance is this? D AND O, Cyber, E AND O, EPLI, or Product Liability?']]
    ):response.insurance_type::string as insurance_type
FROM customer_tickets
LIMIT 5;

-- Extract contact information from unstructured insurance data
SELECT 
    data_id,
    data_source,
    AI_EXTRACT(raw_text, [['emails','Extract all email addresses']]):response.emails::string as emails,
    AI_EXTRACT(raw_text, [['phones','Extract all phone numbers']]):response.phones::string as phones,
    AI_EXTRACT(raw_text, [['policy_numbers','Extract all policy numbers']]):response.policy_numbers::string as policy_numbers
FROM unstructured_data;

-- Extract coverage limits from policy documents
SELECT 
    doc_id,
    document_name,
    AI_EXTRACT(
        document_text,
        [['coverage_limit','What is the policy coverage limit or maximum amount?']]
    ):response.coverage_limit::string as coverage_limit,
    AI_EXTRACT(
        document_text,
        [['retention','What is the retention or deductible amount?']]
    ):response.retention::string as retention_amount
FROM documents
WHERE doc_type = 'policy_terms';

-- =====================================================
-- 2. AI_AGG - Aggregate Insights Across Insurance Data
-- =====================================================

-- Analyze all insurance customer tickets for common themes
SELECT 
    AI_AGG(
        ticket_text,
        'Identify the most common insurance claims issues and trends. Summarize key themes.'
    ) as aggregated_insights
FROM customer_tickets;

-- Category-specific analysis - analyze Claims tickets
SELECT 
    AI_AGG(
        ticket_text,
        'Summarize the key issues and themes in these Claims tickets. Provide actionable recommendations.'
    ) as claims_insights
FROM customer_tickets
WHERE category = 'Claims';

-- Aggregate product review insights for insurance products
SELECT 
    AI_AGG(
        review_text,
        'Summarize customer satisfaction levels, common complaints, and praised features across all product reviews.'
    ) as review_insights
FROM product_reviews;

-- Aggregate insights from insurance policy documents
SELECT 
    AI_AGG(
        document_text,
        'Identify claims trends, incident types, severity patterns, and frequency patterns across these insurance documents.'
    ) as claims_trends
FROM documents
WHERE doc_type = 'claims_report';

-- =====================================================
-- 3. AI_CLASSIFY - Classify Insurance Content
-- =====================================================

-- Classify social media posts by insurance type
SELECT 
    post_id,
    username,
    post_text,
    AI_CLASSIFY(
        post_text,
        ['cyber_insurance', 'directors_officers', 'errors_omissions', 'employment_practices', 'product_liability']
    ):labels[0]::string as insurance_category
FROM social_media_posts;

-- Classify product reviews by topic
SELECT 
    review_id,
    product_name,
    review_text,
    rating,
    AI_CLASSIFY(
        review_text,
        ['claims_handling', 'coverage_quality', 'pricing_premium', 'customer_service', 'policy_clarity']
    ):labels[0]::string as review_topic
FROM product_reviews;

-- Route tickets to appropriate insurance departments
SELECT 
    ticket_id,
    customer_name,
    category as original_category,
    AI_CLASSIFY(
        ticket_text,
        ['claims', 'underwriting', 'policy_services', 'renewals', 'customer_service']
    ):labels[0]::string as recommended_department
FROM customer_tickets;

-- =====================================================
-- 4. AI_SENTIMENT - Analyze Insurance Customer Sentiment
-- =====================================================

-- Analyze product review sentiment for insurance products
SELECT 
    review_id,
    product_name,
    review_text,
    rating,
    AI_SENTIMENT(review_text):categories[0].sentiment::string as sentiment_label
FROM product_reviews
ORDER BY review_date DESC;

-- Identify frustrated customers in insurance tickets
SELECT 
    ticket_id,
    customer_name,
    category,
    ticket_text,
    AI_SENTIMENT(ticket_text):categories[0].sentiment::string as sentiment_label
FROM customer_tickets
WHERE AI_SENTIMENT(ticket_text):categories[0].sentiment::string = 'negative';

-- Analyze social media sentiment about insurance products
SELECT 
    post_id,
    username,
    platform,
    post_text,
    AI_SENTIMENT(post_text):categories[0].sentiment::string as sentiment_label
FROM social_media_posts
ORDER BY post_date DESC;

-- =====================================================
-- 5. AI_FILTER - Filter Insurance Data with Natural Language
-- =====================================================

-- Find tickets mentioning cyber security incidents
SELECT 
    ticket_id,
    customer_name,
    ticket_text,
    category
FROM customer_tickets
WHERE AI_FILTER(
    PROMPT('Does this mention a cyber security incident or ransomware? {0}', ticket_text)
) = TRUE;

-- Filter for claim notifications requiring immediate attention
SELECT 
    ticket_id,
    customer_name,
    ticket_text
FROM customer_tickets
WHERE AI_FILTER(
    PROMPT('Is this a claim notification requiring immediate attention? {0}', ticket_text)
) = TRUE;

-- Find reviews mentioning claims handling
SELECT 
    review_id,
    product_name,
    review_text,
    rating
FROM product_reviews
WHERE AI_FILTER(
    PROMPT('Does this review mention claims handling or claims service? {0}', review_text)
) = TRUE;

-- Filter posts about D&O insurance
SELECT 
    post_id,
    username,
    post_text,
    platform
FROM social_media_posts
WHERE AI_FILTER(
    PROMPT('Does this mention D AND O or directors and officers insurance? {0}', post_text)
) = TRUE;

-- =====================================================
-- 6. AI_TRANSLATE - Translate Insurance Communications
-- =====================================================

-- Translate policy communications to English
SELECT 
    content_id,
    source_language,
    original_text,
    AI_TRANSLATE(
        original_text,
        source_language,
        'en'
    ) as english_translation
FROM multilingual_content;

-- Translate claims notifications to multiple languages
SELECT 
    'en' as source_language,
    'Your cyber insurance claim has been approved' as original_text,
    AI_TRANSLATE('Your cyber insurance claim has been approved', 'en', 'es') as spanish,
    AI_TRANSLATE('Your cyber insurance claim has been approved', 'en', 'fr') as french,
    AI_TRANSLATE('Your cyber insurance claim has been approved', 'en', 'de') as german;

-- Batch translate insurance documents
SELECT 
    content_id,
    content_type,
    AI_TRANSLATE(original_text, source_language, 'en') as english_version,
    AI_TRANSLATE(original_text, source_language, 'es') as spanish_version
FROM multilingual_content
WHERE content_type = 'claims_notification';

-- =====================================================
-- 7. AI_COMPLETE - Generate Insurance Content
-- =====================================================

-- Generate a professional response to a cyber insurance claim
SELECT 
    AI_COMPLETE(
        'llama3.1-70b',
        'Write a professional response to a policyholder who filed a cyber insurance claim for a ransomware attack. Be empathetic and explain next steps.'
    ) as claim_response;

-- Create a policy summary for D&O insurance
SELECT 
    AI_COMPLETE(
        'llama3.1-70b',
        'Write a clear policy summary for Directors and Officers Liability Insurance. Highlight key coverage features, limits, and benefits. Professional tone.'
    ) as policy_summary;

-- Generate claims notification email
SELECT 
    AI_COMPLETE(
        'mistral-large2',
        'Write a claims notification email about cyber insurance coverage. Include next steps, what is covered, and contact information. Professional tone.'
    ) as claims_email;

-- Generate FAQ answer about insurance coverage
SELECT 
    AI_COMPLETE(
        'llama3.1-70b',
        'Write a comprehensive FAQ answer about Cyber Insurance coverage. Be clear, helpful, and address common concerns about ransomware and data breaches.'
    ) as faq_answer;

-- =====================================================
-- 8. COMBINED QUERIES - Multiple AI Functions Together
-- =====================================================

-- Analyze ticket with multiple AI functions
SELECT 
    ticket_id,
    customer_name,
    ticket_text,
    category,
    AI_EXTRACT(ticket_text, [['policy_number','What is the policy number?']]):response.policy_number::string as policy_number,
    AI_SENTIMENT(ticket_text):categories[0].sentiment::string as sentiment,
    AI_CLASSIFY(ticket_text, ['claims', 'new_business', 'renewal', 'feedback']):labels[0]::string as ticket_type,
    AI_FILTER(PROMPT('Is this urgent? {0}', ticket_text)) as is_urgent
FROM customer_tickets
LIMIT 5;

-- Comprehensive product review analysis
SELECT 
    review_id,
    product_name,
    review_text,
    rating,
    AI_SENTIMENT(review_text):categories[0].sentiment::string as sentiment,
    AI_CLASSIFY(review_text, ['claims_handling', 'coverage_quality', 'pricing_premium']):labels[0]::string as topic,
    AI_EXTRACT(review_text, [['key_issue','What is the main issue or praise?']]):response.key_issue::string as key_point
FROM product_reviews;

-- Multi-language insurance content analysis
SELECT 
    content_id,
    source_language,
    content_type,
    original_text,
    AI_TRANSLATE(original_text, source_language, 'en') as english_text,
    AI_SENTIMENT(AI_TRANSLATE(original_text, source_language, 'en')):categories[0].sentiment::string as sentiment,
    AI_CLASSIFY(
        AI_TRANSLATE(original_text, source_language, 'en'),
        ['claim_approval', 'policy_renewal', 'coverage_update']
    ):labels[0]::string as content_category
FROM multilingual_content
LIMIT 3;

-- =====================================================
-- 9. INSURANCE-SPECIFIC USE CASES
-- =====================================================

-- Find high-value cyber insurance claims
SELECT 
    ticket_id,
    customer_name,
    AI_EXTRACT(ticket_text, [['claim_amount','What is the claim amount in dollars?']]):response.claim_amount::string as claim_amount,
    AI_FILTER(PROMPT('Does this mention cyber security or ransomware? {0}', ticket_text)) as is_cyber_claim
FROM customer_tickets
WHERE category = 'Claims'
  AND AI_FILTER(PROMPT('Does this mention cyber security or ransomware? {0}', ticket_text)) = TRUE;

-- Analyze D&O policy documents for coverage limits
SELECT 
    doc_id,
    document_name,
    AI_EXTRACT(
        document_text,
        [['side_a_limit','What is the Side A coverage limit?'],
         ['side_b_limit','What is the Side B coverage limit?'],
         ['side_c_limit','What is the Side C coverage limit?']]
    ) as coverage_limits
FROM documents
WHERE document_name ILIKE '%D_AND_O%';

-- Identify negative reviews about claims handling
SELECT 
    review_id,
    product_name,
    review_text,
    rating
FROM product_reviews
WHERE AI_SENTIMENT(review_text):categories[0].sentiment::string = 'negative'
  AND AI_FILTER(PROMPT('Does this mention claims handling? {0}', review_text)) = TRUE;

-- Generate personalized claim response based on ticket
WITH ticket_info AS (
    SELECT 
        ticket_id,
        customer_name,
        category,
        ticket_text,
        AI_EXTRACT(ticket_text, [['insurance_type','What type of insurance?']]):response.insurance_type::string as insurance_type
    FROM customer_tickets
    WHERE ticket_id = 2
)
SELECT 
    ticket_id,
    customer_name,
    insurance_type,
    AI_COMPLETE(
        'llama3.1-70b',
        'Write a professional response to ' || customer_name || ' regarding their ' || insurance_type || ' inquiry: ' || ticket_text
    ) as personalized_response
FROM ticket_info;

-- =====================================================
-- 10. PERFORMANCE AND OPTIMIZATION EXAMPLES
-- =====================================================

-- Batch process tickets with AI functions (efficient)
SELECT 
    ticket_id,
    AI_SENTIMENT(ticket_text):categories[0].sentiment::string as sentiment,
    AI_CLASSIFY(ticket_text, ['claims', 'underwriting', 'policy_services']):labels[0]::string as department
FROM customer_tickets
WHERE created_date >= DATEADD(day, -30, CURRENT_DATE());

-- Use AI_AGG for large-scale analysis (no context window limits)
-- Note: AI_AGG processes all rows at once, so we use separate queries per category
SELECT 
    'Claims' as category,
    COUNT(*) as ticket_count,
    AI_AGG(
        ticket_text,
        'Provide a brief summary of the main issues in these Claims tickets.'
    ) as category_summary
FROM customer_tickets
WHERE category = 'Claims'

UNION ALL

SELECT 
    'New Business' as category,
    COUNT(*) as ticket_count,
    AI_AGG(
        ticket_text,
        'Provide a brief summary of the main issues in these New Business tickets.'
    ) as category_summary
FROM customer_tickets
WHERE category = 'New Business'

UNION ALL

SELECT 
    'Renewal' as category,
    COUNT(*) as ticket_count,
    AI_AGG(
        ticket_text,
        'Provide a brief summary of the main issues in these Renewal tickets.'
    ) as category_summary
FROM customer_tickets
WHERE category = 'Renewal';

-- Filter before applying expensive AI operations
SELECT 
    ticket_id,
    customer_name,
    AI_COMPLETE(
        'llama3.1-8b',  -- Use smaller model for simple tasks
        'Summarize this ticket in one sentence: ' || ticket_text
    ) as summary
FROM customer_tickets
WHERE category = 'Claims'
  AND created_date >= CURRENT_DATE() - 7;

-- =====================================================
-- END OF EXAMPLE QUERIES
-- =====================================================
-- Note: All queries use insurance-specific data
-- Replace table names and columns as needed for your use case
-- Test queries incrementally to ensure they work with your data
-- =====================================================
