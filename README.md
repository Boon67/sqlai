# Snowflake Cortex AISQL Demo - Specialty Insurance

A comprehensive Streamlit application demonstrating all Cortex AISQL functions with real-world specialty insurance use cases featuring Directors & Officers (D&O), Cyber Security, Errors & Omissions (E&O), EPLI, and Product Liability insurance scenarios.

## 🎯 Overview

This application showcases the full capabilities of Snowflake Cortex AISQL functions through interactive insurance industry demonstrations:

- **Entity Extraction** - Extract policy numbers, claim amounts, and insurance types from tickets
- **Insights Aggregation** - Analyze trends across insurance customer tickets and claims
- **Content Classification** - Classify posts by insurance type (Cyber, D&O, E&O, EPLI)
- **Sentiment Analysis** - Analyze policyholder satisfaction and feedback
- **Translation & Localization** - Translate policy communications in 10+ languages
- **Document Parsing** - Parse insurance policies, claims reports, and underwriting guides
- **Advanced Filtering** - Filter content using natural language conditions
- **Text Completion** - Generate claim responses and policy summaries

## 📋 Prerequisites

- Snowflake account with Cortex AISQL access
- Snowflake CLI (`snow`) installed ([Installation Guide](https://docs.snowflake.com/en/developer-guide/snowflake-cli/installation/installation))
- A compute warehouse (default: `COMPUTE_WH`)
- Appropriate privileges to create databases, schemas, and tables

## 🚀 Quick Start

### 1. Install Snowflake CLI

```bash
# Using pip
pip install snowflake-cli-labs

# Using Homebrew (macOS)
brew install snowflake-cli

# Verify installation
snow --version
```

### 2. Configure Connection

```bash
# Test your connection
snow connection test
```

### 3. Deploy Everything

```bash
# Set up database and sample insurance data
snow sql -f setup_data.sql

# Deploy the Streamlit app
snow streamlit deploy --replace
```

### 4. Access Your App

After deployment, you'll receive a URL like:
```
https://app.snowflake.com/<ORG>/<ACCOUNT>/#/streamlit-apps/CORTEX_AISQL_DEMO.DEMO_DATA.CORTEX_AISQL_DEMO
```

Or navigate to **Streamlit** in Snowsight and open **cortex_aisql_demo**.

## 📊 Application Features

### 1. Entity Extraction (AI_EXTRACT)
Extract structured information from insurance documents:
- **Policy numbers** from customer tickets
- **Claim amounts** and dollar values
- **Insurance types** (D&O, Cyber, E&O, EPLI, Product Liability)
- **Contact information** from unstructured text
- Custom entity extraction with natural language prompts

**Example Query:**
```sql
SELECT 
    ticket_id,
    AI_EXTRACT(
        ticket_text,
        [['policy_number','What is the policy number?']]
    ):response.policy_number::string as policy_number
FROM customer_tickets;
```

### 2. Insights Aggregation (AI_AGG)
Analyze patterns across insurance data:
- **Common Issues** - Identify recurring claim types
- **Trend Analysis** - Track frequency and severity
- **Category Analysis** - Claims, New Business, Renewals, Feedback
- **Product Reviews** - Aggregate feedback on insurance products

**Example Query:**
```sql
SELECT 
    AI_AGG(
        ticket_text,
        'Identify common claims issues and provide recommendations'
    ) as insights
FROM customer_tickets;
```

### 3. Content Classification (AI_CLASSIFY)
Automatically categorize insurance content:
- **Social Media** - Classify by insurance type (cyber, D&O, E&O, EPLI)
- **Product Reviews** - Categorize by topic (claims_handling, coverage_quality, pricing)
- **Ticket Routing** - Route to correct department (claims, underwriting, policy_services)

**Example Query:**
```sql
SELECT 
    post_text,
    AI_CLASSIFY(
        post_text,
        ['cyber_insurance', 'directors_officers', 'errors_omissions']
    ) as category
FROM social_media_posts;
```

### 4. Sentiment Analysis (AI_SENTIMENT)
Measure policyholder satisfaction:
- **Product reviews** sentiment scoring
- **Frustrated customer** identification
- **Social media** sentiment trends
- **Ticket sentiment** analysis by category

**Example Query:**
```sql
SELECT 
    ticket_id,
    AI_SENTIMENT(ticket_text) as sentiment
FROM customer_tickets;
```

### 5. Translation & Localization (AI_TRANSLATE)
Support multilingual insurance operations:
- Translate policy communications in **10 languages**
- Support: English, Spanish, French, German, Italian, Portuguese, Japanese, Korean, Dutch, Polish
- Claims notifications, renewal reminders, policy confirmations

**Example Query:**
```sql
SELECT 
    AI_TRANSLATE(
        original_text,
        source_language,
        'en'
    ) as translated_text
FROM multilingual_content;
```

### 6. Document Parsing (AI_EXTRACT, AI_AGG)
Analyze insurance documents:
- **Summarize Policy Terms** - Extract coverage types and key terms
- **Extract Coverage Limits** - Find policy limits and monetary amounts
- **Identify Claims Metrics** - Extract claims statistics and frequencies
- **Extract Premium & Retention** - Find premium amounts and deductibles
- **List Exclusions** - Identify policy exclusions and limitations

**Document Types:**
- Claims reports
- Policy terms and conditions
- Underwriting guidelines
- Meeting minutes
- Service agreements

**Example Query:**
```sql
SELECT 
    AI_EXTRACT(
        document_text,
        [['coverage_limit','What is the policy coverage limit?']]
    ):response.coverage_limit::string as limit
FROM documents;
```

### 7. Advanced Filtering (AI_FILTER)
Filter insurance data with natural language:
- Find tickets mentioning specific claim types
- Filter policies by coverage conditions
- Custom filter builder for any dataset

### 8. Text Completion (AI_COMPLETE)
Generate insurance content:
- **Claim responses** - Personalized replies to policyholders
- **Marketing content** - Policy descriptions, emails
- **Summaries** - Claim summaries, incident reports
- **Custom prompts** - Any insurance-related text generation

**Example Query:**
```sql
SELECT 
    AI_COMPLETE(
        'llama3.1-70b',
        'Write a professional response to a cyber insurance claim for ransomware'
    ) as response;
```

## 🏢 Insurance Sample Data

The application includes realistic specialty insurance data:

### Customer Tickets (10 records)
- **Categories:** Claims, New Business, Renewal, Feedback
- **Insurance Types:** D&O, Cyber, E&O, EPLI, Product Liability
- **Content:** Policy inquiries, claim reports, coverage questions

### Product Reviews (10 records)
- Insurance products: Cyber Insurance Premier, D&O Basic Policy, E&O Professional Plus
- Ratings and detailed feedback on claims handling, coverage, and service

### Social Media Posts (10 records)
- Posts about D&O premiums, cyber security alerts, E&O claims
- Platforms: LinkedIn, Twitter
- Topics: Market trends, claims experiences, regulatory updates

### Multilingual Content (10 records)
- Insurance communications in 10 languages
- Claims notifications, policy confirmations, renewal reminders

### Documents (5 records)
- Cyber Insurance Policy Terms (11,500+ characters)
- D&O Liability Policy (9,800+ characters)
- E&O Underwriting Guidelines
- Claims Committee Minutes
- Master Service Agreement

### Unstructured Data (5 records)
- Policy documents, claim reports, underwriting memos
- Email communications with contact details

## 🤖 Supported LLM Models

- **llama3.1-70b** - Large, high-quality responses (recommended for complex analysis)
- **llama3.1-8b** - Fast, efficient responses (good for simple tasks)
- **mistral-large2** - Advanced reasoning capabilities
- **mixtral-8x7b** - Balanced performance

## 📁 Project Structure

```
sqlai/
├── snowflake.yml          # Snowflake application configuration
├── streamlit_app.py       # Main Streamlit application (1,366 lines)
├── environment.yml        # Python dependencies
├── setup_data.sql         # Database and insurance sample data (211 lines)
├── example_queries.sql    # Example Cortex AISQL queries (510 lines)
└── README.md             # This file
```

## 🔧 Configuration

### snowflake.yml
```yaml
definition_version: 2
entities:
  cortex_aisql_demo:
    type: streamlit
    title: "Cortex AISQL Functions Demo"
    query_warehouse: COMPUTE_WH
    main_file: streamlit_app.py
    stage: CORTEX_AISQL_DEMO.DEMO_DATA.streamlit_stage
    artifacts:
      - streamlit_app.py
      - environment.yml
      - setup_data.sql
```

### Key Features in Code

**Fully Qualified Names:**
All queries use fully qualified table names to avoid context issues:
```python
FROM CORTEX_AISQL_DEMO.DEMO_DATA.customer_tickets
```

**Structured Outputs:**
AI_EXTRACT uses structured key-value format:
```python
AI_EXTRACT(text, [['key', 'question']]):response.key::string
```

**Insurance-Specific Categories:**
All classification categories are insurance-focused:
- cyber_insurance, directors_officers, errors_omissions, employment_practices

## 🔧 Troubleshooting

### Database not found

**Solution:**
```bash
snow sql -f setup_data.sql
```

### Permission denied on Cortex functions

**Solution:**
```sql
USE ROLE ACCOUNTADMIN;
GRANT DATABASE ROLE SNOWFLAKE.CORTEX_USER TO ROLE <your_role>;
```

### AI_EXTRACT argument type error

**Correct format:**
```sql
AI_EXTRACT(
    text_column,
    [['key_name', 'question']]
):response.key_name::string
```

### AI_AGG not available

If you get "Unknown function AI_AGG", check your Snowflake version and region. AI_AGG is a newer function and may not be available in all accounts yet.

### Streamlit deployment fails

**Check connection and warehouse:**
```bash
snow connection test
snow sql -q "SELECT CURRENT_WAREHOUSE()"
```

**Resume warehouse if suspended:**
```sql
ALTER WAREHOUSE COMPUTE_WH RESUME IF SUSPENDED;
```

### Import errors in Streamlit

**Redeploy with replace flag:**
```bash
snow streamlit deploy --replace
```

## 📊 Use Cases by Industry Segment

### Cyber Insurance
- Extract incident types from claim reports
- Classify social media posts about cyber threats
- Analyze ransomware claim trends
- Generate incident response summaries

### Directors & Officers (D&O)
- Parse securities litigation documents
- Extract coverage limits and retention amounts
- Classify D&O market sentiment
- Generate board communication templates

### Errors & Omissions (E&O)
- Extract professional liability claim details
- Classify E&O risks by industry
- Analyze claim frequency patterns
- Generate coverage recommendations

### Employment Practices Liability (EPLI)
- Parse employment claim documents
- Extract settlement amounts
- Classify claim types
- Generate policy summaries

### Product Liability
- Extract product defect information
- Analyze claim severity trends
- Classify manufacturing risks
- Generate underwriting guidelines

## 🎓 Learning Resources

- [Snowflake Cortex AISQL Documentation](https://docs.snowflake.com/en/user-guide/snowflake-cortex/aisql)
- [AI_EXTRACT Function](https://docs.snowflake.com/en/sql-reference/functions/ai_extract)
- [AI_AGG Function](https://docs.snowflake.com/en/sql-reference/functions/ai_agg)
- [AI_CLASSIFY Function](https://docs.snowflake.com/en/sql-reference/functions/ai_classify)
- [Snowflake CLI Documentation](https://docs.snowflake.com/en/developer-guide/snowflake-cli)
- [Streamlit in Snowflake](https://docs.snowflake.com/en/developer-guide/streamlit/about-streamlit)

## 💡 Customization

### Adding Your Own Insurance Data

1. Modify `setup_data.sql` to include your data:
```sql
INSERT INTO customer_tickets VALUES
(11, 'Your Company', 'Ticket text...', 'Claims', '2024-01-20');
```

2. Redeploy:
```bash
snow sql -f setup_data.sql
snow streamlit deploy --replace
```

### Adding New Insurance Lines

1. Update classification categories in `streamlit_app.py`:
```python
categories = [
    "cyber_insurance",
    "directors_officers",
    "marine_liability",  # New
    "aviation_insurance"  # New
]
```

2. Add corresponding sample data in `setup_data.sql`

### Changing Analysis Prompts

Customize prompts in `streamlit_app.py`:
```python
prompts = {
    "Claims Trends": "Identify claims frequency, severity, and emerging patterns",
    "Coverage Gaps": "Identify potential coverage gaps and exposure areas"
}
```

## 🔒 Security & Privacy

- All data processing happens within your Snowflake account
- No data leaves the Snowflake environment
- LLMs are fully managed by Snowflake
- Follows Snowflake's security and governance model
- Supports Snowflake's row-level security and masking policies

## 📊 Cost Considerations

Cortex AISQL functions incur compute costs based on:
- Model used (larger models = higher cost)
- Number of input/output tokens
- Function complexity

**Track costs:**
```sql
SELECT * 
FROM SNOWFLAKE.ACCOUNT_USAGE.METERING_HISTORY
WHERE SERVICE_TYPE = 'CORTEX';
```

**Cost optimization tips:**
- Use llama3.1-8b for simple tasks
- Use llama3.1-70b for complex analysis
- Batch process when possible
- Cache results for repeated queries

## 🧪 Testing

### Verify Database Setup
```sql
USE DATABASE CORTEX_AISQL_DEMO;
USE SCHEMA DEMO_DATA;

-- Check tables
SHOW TABLES;

-- Verify data
SELECT COUNT(*) FROM customer_tickets;
SELECT COUNT(*) FROM product_reviews;
```

### Test Individual Functions
```sql
-- Test AI_EXTRACT
SELECT AI_EXTRACT(
    'Policy number DO-2024-123 with $5M limit',
    [['policy','What is the policy number?']]
):response.policy::string;

-- Test AI_CLASSIFY
SELECT AI_CLASSIFY(
    'Our cyber insurance saved us during the ransomware attack',
    ['cyber_insurance', 'directors_officers', 'errors_omissions']
);

-- Test AI_SENTIMENT
SELECT AI_SENTIMENT('Excellent claims handling! Very satisfied.');

-- Test AI_TRANSLATE
SELECT AI_TRANSLATE('Claim approved', 'en', 'es');
```

### Test Streamlit App
1. Deploy: `snow streamlit deploy --replace`
2. Open the app URL
3. Test each demo section
4. Check for errors in the Streamlit logs:
```bash
snow streamlit get-logs cortex_aisql_demo
```

## 🚀 Deployment Options

### Development
```bash
# Deploy with logging
snow streamlit deploy --replace
```

### Production
```bash
# Deploy to specific role and warehouse
snow streamlit deploy \
  --replace \
  --role INSURANCE_ANALYTICS_ROLE \
  --warehouse INSURANCE_WH
```

## 🤝 Contributing

Ideas for extending this application:
- Add more insurance lines (Marine, Aviation, Political Risk)
- Integrate with Cortex Search for document retrieval
- Add Cortex Analyst for natural language querying
- Create dashboards with claim analytics
- Add predictive models for loss forecasting
- Implement workflow automation for claim processing

## 📝 Version History

- **v1.0** - Initial release with 8 Cortex AISQL demos
- **v1.1** - Added specialty insurance data (D&O, Cyber, E&O, EPLI)
- **v1.2** - Updated to use AI_ prefixed functions
- **v1.3** - Fixed AI_EXTRACT structured outputs format
- **v1.4** - Insurance-specific classification categories

## 🆘 Support

**For Snowflake-specific issues:**
- [Snowflake Community](https://community.snowflake.com/)
- [Snowflake Support](https://support.snowflake.com/)

**For application issues:**
- Review deployment logs: `snow streamlit get-logs cortex_aisql_demo`
- Check query history in Snowsight
- Verify Cortex function availability: `SHOW FUNCTIONS LIKE '%AI_%' IN ACCOUNT`

## 📈 Next Steps

1. **Explore the demos** - Try each of the 8 demonstration sections
2. **Experiment with prompts** - Modify analysis prompts to see different results
3. **Add your data** - Connect to your insurance data sources
4. **Build workflows** - Create automated insurance analytics pipelines
5. **Scale up** - Process large volumes of claims and policy documents

---

**Built with ❤️ using Snowflake Cortex AISQL**

*Demonstrating AI-native insurance analytics within Snowflake*

**Industry Focus:** Specialty Insurance | **Functions:** 8 Cortex AISQL Functions | **Data:** 50+ Insurance Records
