# Snowflake Cortex AISQL Demo - Specialty Insurance Analytics

A comprehensive Streamlit application demonstrating all Cortex AISQL functions with real-world specialty insurance use cases featuring 8 insurance product lines: Cyber, D&O, E&O, EPLI, Product Liability, Marine, Aviation, and Political Risk.

## 🎯 Overview

This application showcases the full capabilities of Snowflake Cortex AISQL functions through interactive insurance industry demonstrations:

- **📊 Claims Analytics Dashboard** - Comprehensive claims intelligence with AI-powered insights
- **📝 Entity Extraction** - Extract policy numbers, claim amounts, and insurance types
- **📈 Insights Aggregation** - Analyze trends across insurance claims and tickets
- **🏷️ Content Classification** - Classify content by insurance type and urgency
- **😊 Sentiment Analysis** - Analyze policyholder satisfaction and feedback
- **🌍 Translation & Localization** - Translate policy communications in 10+ languages
- **📄 Document Parsing** - Parse insurance policies, claims reports, and underwriting guides
- **🔍 Advanced Filtering** - Filter content using natural language conditions
- **💬 Text Completion** - Generate claim responses and policy summaries

## 🏢 Insurance Lines Supported

The application covers **8 specialty insurance product lines**:

1. **Cyber Insurance** - Ransomware, data breaches, business interruption, regulatory fines
2. **Directors & Officers (D&O)** - Board liability, securities litigation, fiduciary duty
3. **Errors & Omissions (E&O)** - Professional liability for consultants and service providers
4. **Employment Practices Liability (EPLI)** - Employment discrimination, wrongful termination
5. **Product Liability** - Manufacturing defects, product recalls, failure to warn
6. **Marine Insurance** - Hull damage, cargo claims, P&I coverage, war risk, piracy
7. **Aviation Insurance** - Aircraft hull damage, aviation liability, war and terrorism
8. **Political Risk** - Government expropriation, currency inconvertibility, contract frustration

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
# Set up database and sample insurance data (18 claims, 14 reviews, 8 documents)
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

### 0. Claims Analytics Dashboard (NEW!)
Comprehensive claims intelligence combining multiple AI functions:

**📈 Key Metrics:**
- Total claims count
- Unique insurance types (8 lines)
- Average sentiment analysis
- Urgent claims tracking

**Visual Analytics:**
- Claims distribution by insurance line (bar chart)
- Sentiment analysis distribution
- Claims timeline (trend analysis)

**🤖 AI-Powered Insights:**
- **Claims Summary**: AI_AGG analyzes all claims for patterns and recommendations
- **High-Value Claims**: Extract amounts, identify patterns, provide risk management guidance
- **Risk Analysis**: Insurance type-specific risk patterns with prevention recommendations
- **Category Analysis**: Deep-dive analysis by insurance category

**📋 Recent Claims Feed:**
- Interactive expandable cards for each claim
- Auto-classification of urgency (urgent/normal/low_priority)
- Real-time insurance type and sentiment analysis

### 1. Entity Extraction (AI_EXTRACT)
Extract structured information from insurance documents:
- **Policy numbers** from customer tickets
- **Claim amounts** and dollar values
- **Insurance types** across all 8 product lines
- **Contact information** from unstructured text
- Custom entity extraction with natural language prompts

**Example Query:**
```sql
SELECT 
    ticket_id,
    customer_name,
    AI_EXTRACT(
        ticket_text,
        [['policy_number','What is the policy number?']]
    ):response.policy_number::string as policy_number,
    AI_EXTRACT(
        ticket_text,
        [['claim_amount','What is the claim amount?']]
    ):response.claim_amount::string as claim_amount,
    AI_EXTRACT(
        ticket_text,
        [['insurance_type','What type of insurance? Answer with one of: D&O, Cyber, E&O, EPLI, Product Liability, Marine, Aviation, Political Risk']]
    ):response.insurance_type::string as insurance_type
FROM customer_tickets;
```

### 2. Insights Aggregation (AI_AGG)
Analyze patterns across insurance data:
- **Common Issues** - Identify recurring claim types
- **Trend Analysis** - Track frequency and severity
- **Category Analysis** - Claims, New Business, Renewals, Feedback
- **Product Reviews** - Aggregate feedback on insurance products

**Important Note:** AI_AGG processes all rows together and cannot be used with GROUP BY. For category-specific analysis, use separate queries with WHERE clauses.

**Example Query:**
```sql
-- Analyze Claims tickets
SELECT 
    AI_AGG(
        ticket_text,
        'Summarize the key issues in these Claims tickets. Provide actionable recommendations.'
    ) as claims_insights
FROM customer_tickets
WHERE category = 'Claims';
```

### 3. Content Classification (AI_CLASSIFY)
Automatically categorize insurance content:
- **Social Media** - Classify by insurance type (cyber, D&O, E&O, EPLI, marine, aviation, political_risk)
- **Product Reviews** - Categorize by topic (claims_handling, coverage_quality, pricing)
- **Ticket Routing** - Route to correct department (claims, underwriting, policy_services)

**Example Query:**
```sql
SELECT 
    post_id,
    post_text,
    AI_CLASSIFY(
        post_text,
        ['cyber_insurance', 'directors_officers', 'errors_omissions', 'marine', 'aviation', 'political_risk']
    ):labels[0]::string as category
FROM social_media_posts;
```

### 4. Sentiment Analysis (AI_SENTIMENT)
Measure policyholder satisfaction:
- **Product reviews** sentiment scoring (positive/neutral/negative)
- **Frustrated customer** identification
- **Social media** sentiment trends
- **Ticket sentiment** analysis by category

**Example Query:**
```sql
SELECT 
    ticket_id,
    ticket_text,
    AI_SENTIMENT(ticket_text):categories[0].sentiment::string as sentiment
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
    content_id,
    original_text,
    AI_TRANSLATE(
        original_text,
        source_language,
        'en'
    ) as translated_text
FROM multilingual_content;
```

### 6. Document Parsing (AI_EXTRACT, AI_SUMMARIZE_AGG)
Analyze insurance documents:
- **Summarize Policy Terms** - Extract coverage types and key terms
- **Extract Coverage Limits** - Find policy limits and monetary amounts
- **Identify Claims Metrics** - Extract claims statistics and frequencies
- **Extract Premium & Retention** - Find premium amounts and deductibles
- **List Exclusions** - Identify policy exclusions and limitations

**Document Types:**
- Claims reports (Cyber, Marine, Aviation, Political Risk)
- Policy terms and conditions
- Underwriting guidelines
- Market analysis reports
- Risk assessment guides

**Example Query:**
```sql
SELECT 
    document_name,
    AI_EXTRACT(
        document_text,
        [['coverage_limit','What is the policy coverage limit?']]
    ):response.coverage_limit::string as limit,
    AI_EXTRACT(
        document_text,
        [['premium','What is the annual premium?']]
    ):response.premium::string as premium
FROM documents;
```

### 7. Advanced Filtering (AI_FILTER)
Filter insurance data with natural language:
- Find tickets mentioning specific claim types
- Filter policies by coverage conditions
- Custom filter builder for any dataset

**Example Query:**
```sql
SELECT 
    ticket_id,
    ticket_text
FROM customer_tickets
WHERE AI_FILTER(
    PROMPT('Does this mention a cyber security incident? {0}', ticket_text)
) = TRUE;
```

### 8. Text Completion (AI_COMPLETE)
Generate insurance content:
- **Claim responses** - Personalized replies to policyholders
- **Marketing content** - Policy descriptions, blog posts, social media
- **Summaries** - Claim summaries, incident reports
- **Custom prompts** - Any insurance-related text generation

**Example Query:**
```sql
SELECT 
    AI_COMPLETE(
        'llama3.1-70b',
        'Write a professional response to a marine insurance claim for cargo damage during a storm'
    ) as response;
```

## 🏢 Insurance Sample Data

The application includes realistic specialty insurance data across 8 product lines:

### Customer Tickets (18 records)
- **Categories:** Claims, New Business, Renewal, Feedback
- **Insurance Types:** D&O (2), Cyber (2), E&O (1), EPLI (1), Product Liability (1), Marine (3), Aviation (2), Political Risk (2)
- **Content:** Policy inquiries, claim reports, coverage questions across all 8 insurance lines

### Product Reviews (14 records)
- Insurance products across all lines with detailed feedback
- Ratings and reviews on claims handling, coverage quality, pricing
- Marine, Aviation, and Political Risk product reviews included

### Social Media Posts (14 records)
- Posts about all 8 insurance lines
- Platforms: LinkedIn, Twitter
- Topics: Market trends, claims experiences, regulatory updates, piracy risks, aviation safety

### Multilingual Content (10 records)
- Insurance communications in 10 languages
- Claims notifications, policy confirmations, renewal reminders
- Coverage for Cyber, D&O, and E&O in multiple languages

### Documents (8 records)
- **Cyber Claims Report Q4 2023** - Quarterly claims analysis
- **D&O Policy Terms** - Comprehensive policy conditions
- **E&O Underwriting Guidelines** - Rating factors and eligibility
- **Claims Committee Minutes** - Large loss review
- **Marine Market Analysis 2024** - Market trends, war risk, P&I coverage
- **Aviation Underwriting Manual** - Coverage types, rating factors, drone coverage
- **Political Risk Assessment Guide** - Coverage areas, risk factors, claims process
- **TPA Service Agreement** - Third-party administrator contract

### Unstructured Data (8 records)
- Claim notifications for all insurance lines
- Premium invoices and quotes
- Marine, Aviation, and Political Risk claim alerts

## 🤖 Supported LLM Models

- **llama3.1-70b** - Large, high-quality responses (recommended for complex analysis)
- **llama3.1-8b** - Fast, efficient responses (good for simple tasks)
- **mistral-large2** - Advanced reasoning capabilities
- **mixtral-8x7b** - Balanced performance

## 📁 Project Structure

```
sqlai/
├── snowflake.yml              # Snowflake application configuration
├── streamlit_app.py           # Main Streamlit application (1,726 lines)
├── environment.yml            # Python dependencies
├── setup_data.sql             # Database and sample data (258 lines, 18 claims)
├── example_queries.sql        # Example Cortex AISQL queries (449 lines)
├── README.md                  # This file
└── CLAIMS_DASHBOARD_GUIDE.md  # Claims Analytics Dashboard documentation
```

## 🔧 Configuration

### snowflake.yml
```yaml
definition_version: 2
entities:
  CORTEX_AISQL_DEMO.DEMO_DATA.cortex_aisql_demo:
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

**JSON Parsing:**
AI_CLASSIFY and AI_SENTIMENT return JSON that must be parsed:
```python
AI_CLASSIFY(text, categories):labels[0]::string
AI_SENTIMENT(text):categories[0].sentiment::string
```

**PROMPT Function:**
AI_FILTER requires the PROMPT() function:
```python
AI_FILTER(PROMPT('question {0}', text_column))
```

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

**Common mistakes:**
- ❌ `AI_EXTRACT(prompt, text)` - Wrong argument order
- ✅ `AI_EXTRACT(text, [['key', 'question']])` - Correct

### AI_AGG with GROUP BY error

AI_AGG cannot be used with GROUP BY. Use separate queries with WHERE clauses:

```sql
-- ❌ INCORRECT - Will fail
SELECT category, AI_AGG(text, 'prompt') FROM table GROUP BY category;

-- ✅ CORRECT - Use separate queries
SELECT AI_AGG(text, 'prompt') FROM table WHERE category = 'Claims';
```

### AI_CLASSIFY returns JSON

Parse the JSON output to get the label:

```sql
-- ❌ Returns: {"labels": ["cyber_insurance"]}
AI_CLASSIFY(text, ['cyber_insurance', 'directors_officers'])

-- ✅ Returns: cyber_insurance
AI_CLASSIFY(text, ['cyber_insurance', 'directors_officers']):labels[0]::string
```

### AI_FILTER argument error

Use the PROMPT() function:

```sql
-- ❌ INCORRECT
AI_FILTER(text_column, 'question')

-- ✅ CORRECT
AI_FILTER(PROMPT('question {0}', text_column))
```

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
- Track regulatory fines under GDPR and CCPA

### Directors & Officers (D&O)
- Parse securities litigation documents
- Extract coverage limits and retention amounts
- Classify D&O market sentiment
- Generate board communication templates
- Analyze Side A, B, and C coverage

### Errors & Omissions (E&O)
- Extract professional liability claim details
- Classify E&O risks by industry
- Analyze claim frequency patterns
- Generate coverage recommendations
- Review policy exclusions

### Employment Practices Liability (EPLI)
- Parse employment claim documents
- Extract settlement amounts
- Classify claim types (discrimination, wrongful termination)
- Generate policy summaries

### Product Liability
- Extract product defect information
- Analyze recall costs and frequencies
- Classify manufacturing risks
- Generate underwriting guidelines

### Marine Insurance
- Parse cargo damage claims
- Extract vessel information and voyage details
- Analyze P&I coverage and crew injury claims
- Track war risk and piracy incidents
- Calculate general average contributions

### Aviation Insurance
- Extract aircraft damage details
- Analyze hull and liability claims
- Track drone and UAV coverage
- Monitor war and terrorism risk
- Review pilot certifications and maintenance history

### Political Risk
- Parse expropriation claims
- Extract project values and contract details
- Analyze currency inconvertibility events
- Track political violence and civil unrest
- Review international arbitration cases

## 🎓 Learning Resources

- [Snowflake Cortex AISQL Documentation](https://docs.snowflake.com/en/user-guide/snowflake-cortex/aisql)
- [AI_EXTRACT Function](https://docs.snowflake.com/en/sql-reference/functions/ai_extract)
- [AI_AGG Function](https://docs.snowflake.com/en/sql-reference/functions/ai_agg)
- [AI_CLASSIFY Function](https://docs.snowflake.com/en/sql-reference/functions/ai_classify)
- [AI_SENTIMENT Function](https://docs.snowflake.com/en/sql-reference/functions/ai_sentiment)
- [AI_FILTER Function](https://docs.snowflake.com/en/sql-reference/functions/ai_filter)
- [Snowflake CLI Documentation](https://docs.snowflake.com/en/developer-guide/snowflake-cli)
- [Streamlit in Snowflake](https://docs.snowflake.com/en/developer-guide/streamlit/about-streamlit)

## 💡 Customization

### Adding Your Own Insurance Data

1. Modify `setup_data.sql` to include your data:
```sql
INSERT INTO customer_tickets VALUES
(19, 'Your Company', 'your.email@company.com', 'Ticket text...', '2024-02-15', 'Claims');
```

2. Redeploy:
```bash
snow sql -f setup_data.sql
snow streamlit deploy --replace
```

### Customizing the Claims Dashboard

The Claims Analytics Dashboard can be customized by modifying `streamlit_app.py`:

1. **Add new metrics**: Update the Key Metrics section
2. **Change insurance type filters**: Modify the insurance type list in Risk Analysis
3. **Customize AI prompts**: Update the AI_AGG prompts for different insights
4. **Adjust visualizations**: Modify chart types and data groupings

See `CLAIMS_DASHBOARD_GUIDE.md` for detailed customization instructions.

### Changing Analysis Prompts

Customize prompts in `streamlit_app.py`:
```python
prompts = {
    "Claims Trends": "Identify claims frequency, severity, and emerging patterns",
    "Coverage Gaps": "Identify potential coverage gaps and exposure areas",
    "Risk Patterns": "Analyze risk patterns specific to Marine insurance claims"
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
WHERE SERVICE_TYPE = 'CORTEX'
ORDER BY START_TIME DESC
LIMIT 100;
```

**Cost optimization tips:**
- Use llama3.1-8b for simple tasks
- Use llama3.1-70b for complex analysis
- Batch process when possible
- Cache results for repeated queries
- Use AI_FILTER to reduce rows before expensive AI operations

## 🧪 Testing

### Verify Database Setup
```sql
USE DATABASE CORTEX_AISQL_DEMO;
USE SCHEMA DEMO_DATA;

-- Check tables
SHOW TABLES;

-- Verify data counts
SELECT 'Customer Tickets: ' || COUNT(*) FROM customer_tickets
UNION ALL
SELECT 'Product Reviews: ' || COUNT(*) FROM product_reviews
UNION ALL
SELECT 'Documents: ' || COUNT(*) FROM documents
UNION ALL
SELECT 'Social Media: ' || COUNT(*) FROM social_media_posts;
```

### Test Individual Functions

**Test AI_EXTRACT:**
```sql
SELECT 
    AI_EXTRACT(
        'Policy MAR-2024-556677 with cargo value $8.5M',
        [['policy','What is the policy number?']]
    ):response.policy::string as policy_number;
```

**Test AI_CLASSIFY:**
```sql
SELECT 
    AI_CLASSIFY(
        'Marine insurance claim for hull damage during storm',
        ['cyber_insurance', 'directors_officers', 'marine', 'aviation']
    ):labels[0]::string as category;
```

**Test AI_SENTIMENT:**
```sql
SELECT 
    AI_SENTIMENT('Exceptional marine insurance coverage! Claims settled quickly.'):categories[0].sentiment::string;
```

**Test AI_FILTER:**
```sql
SELECT 
    ticket_id, 
    ticket_text
FROM customer_tickets
WHERE AI_FILTER(PROMPT('Does this mention marine insurance? {0}', ticket_text)) = TRUE;
```

**Test AI_AGG:**
```sql
SELECT 
    AI_AGG(
        ticket_text,
        'Summarize the main issues in these Claims tickets'
    )
FROM customer_tickets
WHERE category = 'Claims';
```

### Test with Snow CLI

You can also test queries directly using Snow CLI:
```bash
# Test AI_EXTRACT
snow sql -q "SELECT AI_EXTRACT('Policy AVI-2024-778899', [['policy','What is the policy?']]):response.policy::string;"

# Test against your data
snow sql -q "SELECT COUNT(*) FROM CORTEX_AISQL_DEMO.DEMO_DATA.customer_tickets WHERE category = 'Claims';"
```

### Test Streamlit App
1. Deploy: `snow streamlit deploy --replace`
2. Open the app URL
3. Test each demo section:
   - Claims Analytics Dashboard (all tabs)
   - Entity Extraction (all 3 tabs)
   - Insights Aggregation (both tabs)
   - Content Classification (all 3 tabs)
   - Sentiment Analysis (all 3 tabs)
   - Translation (both tabs)
   - Document Parsing (all analyses)
   - Advanced Filtering (all filters)
   - Text Completion (both types)
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

## 📝 Version History

- **v1.0** - Initial release with 8 Cortex AISQL demos
- **v1.1** - Added specialty insurance data (D&O, Cyber, E&O, EPLI, Product Liability)
- **v1.2** - Updated to use AI_ prefixed functions
- **v1.3** - Fixed AI_EXTRACT structured outputs format
- **v1.4** - Insurance-specific classification categories
- **v1.5** - Added Marine, Aviation, and Political Risk insurance lines (18 claims)
- **v1.6** - Added Claims Analytics Dashboard with AI-powered insights
- **v1.7** - Updated button text and extraction fields for clarity

## 🤝 Contributing

The application is designed to be extensible. Ideas for future enhancements:
- ✅ ~~Add Claims Analytics Dashboard~~ (Completed in v1.6)
- ✅ ~~Add Marine, Aviation, Political Risk insurance~~ (Completed in v1.5)
- Integrate with Cortex Search for document retrieval
- Add Cortex Analyst for natural language querying
- Add predictive models for loss forecasting
- Implement workflow automation for claim processing
- Create underwriting automation with AI recommendations
- Add reinsurance treaty analysis

## 🆘 Support

**For Snowflake-specific issues:**
- [Snowflake Community](https://community.snowflake.com/)
- [Snowflake Support](https://support.snowflake.com/)

**For application issues:**
- Review deployment logs: `snow streamlit get-logs cortex_aisql_demo`
- Check query history in Snowsight
- Verify Cortex function availability: `SHOW FUNCTIONS LIKE '%AI_%' IN ACCOUNT`
- Review `CLAIMS_DASHBOARD_GUIDE.md` for dashboard-specific questions

## 📈 Next Steps

1. **Explore the Claims Dashboard** - Start with the comprehensive claims analytics
2. **Try entity extraction** - Extract policy numbers and claim amounts from your data
3. **Test sentiment analysis** - Understand customer satisfaction levels
4. **Experiment with prompts** - Modify analysis prompts to see different results
5. **Add your data** - Connect to your insurance data sources
6. **Build workflows** - Create automated insurance analytics pipelines
7. **Scale up** - Process large volumes of claims and policy documents

---

**Built with ❤️ using Snowflake Cortex AISQL**

*Demonstrating AI-native insurance analytics within Snowflake*

**Industry Focus:** Specialty Insurance  
**Insurance Lines:** 8 (Cyber, D&O, E&O, EPLI, Product Liability, Marine, Aviation, Political Risk)  
**Functions:** 9 Cortex AISQL Functions  
**Data:** 18 Claims + 14 Reviews + 8 Documents + 14 Social Posts  
**Features:** Claims Analytics Dashboard with AI-Powered Insights
