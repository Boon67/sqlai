-- =====================================================
-- Example Queries for Cortex AISQL Functions
-- Use these as templates for your own implementations
-- =====================================================

USE DATABASE CORTEX_AISQL_DEMO;
USE SCHEMA DEMO_DATA;

-- =====================================================
-- 1. AI_EXTRACT - Entity Extraction
-- =====================================================

-- Extract order numbers from customer tickets
SELECT 
    ticket_id,
    customer_name,
    ticket_text,
    AI_EXTRACT(
        'What is the order number? Return only the order number.',
        ticket_text
    ) as order_number
FROM customer_tickets
WHERE ticket_text ILIKE '%order%'
LIMIT 5;

-- Extract multiple entities at once
SELECT 
    ticket_id,
    AI_EXTRACT(
        'Extract all product names, order numbers, and dates mentioned. Format as JSON.',
        ticket_text
    ) as extracted_entities
FROM customer_tickets
LIMIT 5;

-- Extract contact information
SELECT 
    data_id,
    raw_text,
    AI_EXTRACT('Extract all email addresses', raw_text) as emails,
    AI_EXTRACT('Extract all phone numbers', raw_text) as phones,
    AI_EXTRACT('Extract all person names', raw_text) as names
FROM unstructured_data;

-- =====================================================
-- 2. AI_AGG - Insights Aggregation
-- =====================================================

-- Aggregate insights across all customer tickets
SELECT 
    AI_AGG(
        ticket_text,
        'Summarize the most common customer issues and complaints. Group by issue type and provide counts.'
    ) as aggregated_insights
FROM customer_tickets;

-- Category-specific aggregation
SELECT 
    category,
    AI_AGG(
        ticket_text,
        'What are the key themes and urgent issues in these tickets?'
    ) as category_insights
FROM customer_tickets
GROUP BY category;

-- Aggregate product review insights
SELECT 
    AI_AGG(
        review_text,
        'Summarize customer satisfaction, common complaints, and praised features.'
    ) as review_summary
FROM product_reviews
WHERE rating <= 3;

-- Time-based aggregation
SELECT 
    DATE_TRUNC('week', created_date) as week,
    AI_AGG(
        ticket_text,
        'Summarize main issues this week'
    ) as weekly_summary
FROM customer_tickets
GROUP BY week
ORDER BY week DESC;

-- =====================================================
-- 3. AI_CLASSIFY - Content Classification
-- =====================================================

-- Classify social media posts by topic
SELECT 
    post_id,
    username,
    post_text,
    AI_CLASSIFY(
        post_text,
        ['technology', 'fitness', 'food', 'travel', 'gaming', 'books', 'finance']
    ) as topic
FROM social_media_posts;

-- Classify reviews by sentiment category
SELECT 
    review_id,
    product_name,
    review_text,
    rating,
    AI_CLASSIFY(
        review_text,
        ['positive_feedback', 'quality_issue', 'price_concern', 'feature_request']
    ) as review_category
FROM product_reviews;

-- Intelligent ticket routing
SELECT 
    ticket_id,
    customer_name,
    ticket_text,
    category as original_category,
    AI_CLASSIFY(
        ticket_text,
        ['billing', 'technical_support', 'returns_exchanges', 'account_management', 'general_inquiry']
    ) as recommended_department
FROM customer_tickets;

-- Multi-label classification (if supported)
SELECT 
    post_id,
    post_text,
    AI_CLASSIFY(
        post_text,
        ['positive_sentiment', 'negative_sentiment', 'urgent', 'feedback', 'question']
    ) as labels
FROM social_media_posts;

-- =====================================================
-- 4. AI_FILTER - Advanced Filtering
-- =====================================================

-- Filter tickets that mention product defects
SELECT 
    ticket_id,
    customer_name,
    ticket_text,
    AI_FILTER(
        ticket_text,
        'Does this ticket mention a product defect or quality issue?'
    ) as has_defect
FROM customer_tickets
QUALIFY has_defect = TRUE;

-- Filter urgent tickets
SELECT 
    ticket_id,
    customer_name,
    ticket_text,
    category
FROM customer_tickets
WHERE AI_FILTER(
    ticket_text,
    'Is this ticket urgent or expressing frustration?'
) = TRUE;

-- Filter positive reviews
SELECT 
    review_id,
    product_name,
    review_text,
    rating
FROM product_reviews
WHERE AI_FILTER(
    review_text,
    'Is this review highly positive and enthusiastic?'
) = TRUE;

-- Complex filtering with multiple conditions
SELECT 
    ticket_id,
    customer_name,
    ticket_text,
    AI_FILTER(ticket_text, 'Mentions refund or return?') as wants_refund,
    AI_FILTER(ticket_text, 'Is customer frustrated?') as is_frustrated,
    AI_FILTER(ticket_text, 'Mentions specific product?') as has_product
FROM customer_tickets;

-- =====================================================
-- 5. AI_SENTIMENT - Sentiment Analysis
-- =====================================================

-- Basic sentiment analysis
SELECT 
    review_id,
    product_name,
    review_text,
    rating,
    AI_SENTIMENT(review_text) as sentiment_score,
    CASE 
        WHEN AI_SENTIMENT(review_text) >= 0.5 THEN 'Positive'
        WHEN AI_SENTIMENT(review_text) >= 0 THEN 'Neutral'
        ELSE 'Negative'
    END as sentiment_label
FROM product_reviews
ORDER BY sentiment_score DESC;

-- Identify dissatisfied customers
SELECT 
    ticket_id,
    customer_name,
    email,
    ticket_text,
    AI_SENTIMENT(ticket_text) as sentiment_score
FROM customer_tickets
WHERE AI_SENTIMENT(ticket_text) < -0.3
ORDER BY sentiment_score ASC;

-- Average sentiment by product
SELECT 
    product_name,
    AVG(rating) as avg_rating,
    AVG(AI_SENTIMENT(review_text)) as avg_sentiment,
    COUNT(*) as review_count
FROM product_reviews
GROUP BY product_name
ORDER BY avg_sentiment DESC;

-- Sentiment trend over time
SELECT 
    DATE_TRUNC('day', review_date) as date,
    AVG(AI_SENTIMENT(review_text)) as avg_sentiment,
    COUNT(*) as review_count
FROM product_reviews
GROUP BY date
ORDER BY date;

-- Sentiment by category
SELECT 
    category,
    AVG(AI_SENTIMENT(ticket_text)) as avg_sentiment,
    COUNT(*) as ticket_count,
    SUM(CASE WHEN AI_SENTIMENT(ticket_text) < -0.3 THEN 1 ELSE 0 END) as frustrated_count
FROM customer_tickets
GROUP BY category
ORDER BY avg_sentiment ASC;

-- =====================================================
-- 6. AI_TRANSLATE - Translation
-- =====================================================

-- Translate to English
SELECT 
    content_id,
    original_text,
    source_language,
    AI_TRANSLATE(original_text, source_language, 'en') as english_translation
FROM multilingual_content
WHERE source_language != 'en';

-- Multi-language translation
SELECT 
    content_id,
    original_text as original,
    source_language,
    AI_TRANSLATE(original_text, source_language, 'en') as english,
    AI_TRANSLATE(original_text, source_language, 'es') as spanish,
    AI_TRANSLATE(original_text, source_language, 'fr') as french
FROM multilingual_content
WHERE source_language NOT IN ('en', 'es', 'fr')
LIMIT 5;

-- Translate customer tickets for global support team
SELECT 
    ticket_id,
    customer_name,
    ticket_text as original,
    AI_TRANSLATE(ticket_text, 'en', 'es') as spanish,
    AI_TRANSLATE(ticket_text, 'en', 'de') as german,
    AI_TRANSLATE(ticket_text, 'en', 'ja') as japanese
FROM customer_tickets
LIMIT 3;

-- =====================================================
-- 7. AI_COMPLETE - Text Generation
-- =====================================================

-- Generate customer response
SELECT 
    ticket_id,
    customer_name,
    ticket_text,
    AI_COMPLETE(
        'llama3.1-70b',
        'You are a customer service representative. Write a professional, empathetic response to this ticket: ' || ticket_text
    ) as generated_response
FROM customer_tickets
LIMIT 3;

-- Generate product descriptions
SELECT 
    product_name,
    AI_COMPLETE(
        'mistral-large2',
        'Write a compelling product description for: ' || product_name || '. Highlight key features and benefits in 2-3 sentences.'
    ) as product_description
FROM (SELECT DISTINCT product_name FROM product_reviews)
LIMIT 5;

-- Summarize documents
SELECT 
    document_name,
    doc_type,
    AI_COMPLETE(
        'llama3.1-70b',
        'Summarize this document in 3-4 sentences: ' || document_text
    ) as summary
FROM documents;

-- Generate FAQ answers
SELECT 
    AI_COMPLETE(
        'llama3.1-70b',
        'Based on these customer questions: ' || LISTAGG(ticket_text, ' | ') || 
        ' Create a FAQ section with the 3 most common questions and answers.'
    ) as faq_section
FROM customer_tickets
WHERE category = 'General Inquiry';

-- =====================================================
-- 8. AI_SUMMARIZE_AGG - Document Summarization
-- =====================================================

-- Summarize all customer feedback
SELECT 
    AI_SUMMARIZE_AGG(ticket_text) as feedback_summary
FROM customer_tickets;

-- Summarize reviews by product
SELECT 
    product_name,
    AI_SUMMARIZE_AGG(review_text) as review_summary
FROM product_reviews
GROUP BY product_name;

-- Summarize documents by type
SELECT 
    doc_type,
    AI_SUMMARIZE_AGG(document_text) as type_summary
FROM documents
GROUP BY doc_type;

-- =====================================================
-- 9. Combined Queries - Real-world Workflows
-- =====================================================

-- Complete ticket analysis workflow
WITH ticket_analysis AS (
    SELECT 
        ticket_id,
        customer_name,
        ticket_text,
        category,
        AI_SENTIMENT(ticket_text) as sentiment,
        AI_CLASSIFY(
            ticket_text,
            ['billing', 'technical', 'product_issue', 'general']
        ) as classified_type,
        AI_FILTER(ticket_text, 'Is this urgent?') as is_urgent,
        AI_EXTRACT('What is the main issue?', ticket_text) as main_issue
    FROM customer_tickets
)
SELECT 
    *,
    CASE 
        WHEN is_urgent AND sentiment < -0.3 THEN 'High Priority'
        WHEN is_urgent OR sentiment < -0.3 THEN 'Medium Priority'
        ELSE 'Normal Priority'
    END as priority
FROM ticket_analysis
ORDER BY priority, sentiment;

-- Multi-language customer support workflow
WITH translated_tickets AS (
    SELECT 
        ticket_id,
        customer_name,
        ticket_text as original_text,
        'en' as source_lang,
        AI_TRANSLATE(ticket_text, 'en', 'es') as spanish_text,
        AI_SENTIMENT(ticket_text) as sentiment
    FROM customer_tickets
)
SELECT 
    ticket_id,
    customer_name,
    original_text,
    spanish_text,
    sentiment,
    AI_COMPLETE(
        'llama3.1-70b',
        'Write a response in Spanish to this ticket: ' || spanish_text
    ) as spanish_response
FROM translated_tickets
WHERE sentiment < 0
LIMIT 3;

-- Product intelligence dashboard
SELECT 
    product_name,
    COUNT(*) as total_reviews,
    AVG(rating) as avg_rating,
    AVG(AI_SENTIMENT(review_text)) as avg_sentiment,
    SUM(CASE WHEN rating >= 4 THEN 1 ELSE 0 END) as positive_reviews,
    SUM(CASE WHEN rating <= 2 THEN 1 ELSE 0 END) as negative_reviews,
    AI_AGG(
        CASE WHEN rating <= 2 THEN review_text END,
        'Summarize common complaints'
    ) as complaint_summary,
    AI_AGG(
        CASE WHEN rating >= 4 THEN review_text END,
        'Summarize what customers love'
    ) as praise_summary
FROM product_reviews
GROUP BY product_name;

-- Content moderation pipeline
SELECT 
    post_id,
    username,
    post_text,
    platform,
    AI_SENTIMENT(post_text) as sentiment,
    AI_CLASSIFY(
        post_text,
        ['appropriate', 'needs_review', 'inappropriate']
    ) as moderation_status,
    AI_FILTER(post_text, 'Does this contain complaints?') as has_complaint,
    AI_FILTER(post_text, 'Is this promotional content?') as is_promotional
FROM social_media_posts;

-- =====================================================
-- 10. Helper Functions
-- =====================================================

-- Count tokens before sending to model
SELECT 
    ticket_id,
    ticket_text,
    AI_COUNT_TOKENS('llama3.1-70b', ticket_text) as token_count
FROM customer_tickets
ORDER BY token_count DESC;

-- Check if text will fit in context window
SELECT 
    doc_id,
    document_name,
    AI_COUNT_TOKENS('llama3.1-70b', document_text) as tokens,
    CASE 
        WHEN AI_COUNT_TOKENS('llama3.1-70b', document_text) < 4000 THEN 'Can process'
        ELSE 'Too large, consider chunking'
    END as processing_recommendation
FROM documents;

-- =====================================================
-- Performance Optimization Tips
-- =====================================================

-- 1. Use appropriate warehouse size
-- ALTER WAREHOUSE COMPUTE_WH SET WAREHOUSE_SIZE = 'LARGE';

-- 2. Process in batches for large datasets
-- SELECT * FROM large_table LIMIT 100;

-- 3. Use smaller models when appropriate
-- 'llama3.1-8b' is faster than 'llama3.1-70b'

-- 4. Cache results when possible
-- CREATE TABLE cached_results AS
-- SELECT id, AI_SENTIMENT(text) as sentiment
-- FROM my_table;

-- 5. Use QUALIFY for filtering instead of subqueries
-- More efficient than WHERE EXISTS or IN

-- =====================================================
-- Cost Monitoring
-- =====================================================

-- Track Cortex usage
SELECT 
    DATE_TRUNC('day', START_TIME) as day,
    SERVICE_TYPE,
    COUNT(*) as operation_count,
    SUM(CREDITS_USED) as total_credits
FROM SNOWFLAKE.ACCOUNT_USAGE.METERING_HISTORY
WHERE SERVICE_TYPE = 'CORTEX'
    AND START_TIME >= DATEADD('day', -30, CURRENT_TIMESTAMP())
GROUP BY 1, 2
ORDER BY 1 DESC;

-- Track queries by function
SELECT 
    REGEXP_SUBSTR(QUERY_TEXT, 'CORTEX\\.[A-Z_]+') as cortex_function,
    COUNT(*) as usage_count,
    AVG(TOTAL_ELAPSED_TIME/1000) as avg_seconds
FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY
WHERE QUERY_TEXT ILIKE '%CORTEX%'
    AND START_TIME >= DATEADD('day', -7, CURRENT_TIMESTAMP())
GROUP BY 1
ORDER BY 2 DESC;

