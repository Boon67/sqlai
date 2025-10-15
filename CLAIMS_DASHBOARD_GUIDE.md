# Claims Analytics Dashboard Guide

## Overview

The Claims Analytics Dashboard is a comprehensive insurance claims intelligence tool that leverages Snowflake Cortex AI functions to provide actionable insights on insurance claims across multiple product lines.

## Insurance Lines Covered

The dashboard now supports **8 insurance product lines**:

1. **Cyber Insurance** - Ransomware, data breaches, business interruption
2. **Directors & Officers (D&O)** - Board liability, securities litigation
3. **Errors & Omissions (E&O)** - Professional liability for consultants and service providers
4. **Employment Practices Liability (EPLI)** - Employment discrimination, wrongful termination
5. **Product Liability** - Manufacturing defects, product recalls
6. **Marine Insurance** - Hull damage, cargo claims, P&I coverage
7. **Aviation Insurance** - Aircraft hull damage, aviation liability
8. **Political Risk** - Expropriation, currency inconvertibility, contract frustration

## Dashboard Features

### 1. Key Metrics (Real-time)

- **Total Claims**: Count of all claims in the system
- **Insurance Types**: Number of unique insurance product lines
- **Average Sentiment**: Overall sentiment analysis of claims (Positive/Neutral/Negative)
- **Urgent Claims**: Claims marked with urgent keywords

### 2. Claims Distribution by Insurance Line

- **Visual Bar Chart**: Shows claim volume by insurance type
- **AI-Powered Classification**: Uses `AI_EXTRACT` to automatically identify insurance type from claim text
- **Top Insurance Lines**: Quick view of highest-volume claim types

### 3. Sentiment Analysis

- **Distribution Chart**: Visualizes positive, neutral, and negative sentiment across all claims
- **Percentage Breakdown**: Shows sentiment distribution with percentages
- **Uses `AI_SENTIMENT`**: Cortex AI function for categorical sentiment analysis

### 4. Claims Timeline

- **Line Chart**: Tracks claims over time by insurance type
- **Trend Analysis**: Helps identify patterns and seasonal variations
- **Multi-line View**: Compare claim volumes across different insurance lines

### 5. AI-Powered Claims Insights

#### Claims Summary Tab
- **Overall Analysis**: AI_AGG summarizes all claims
- **Key Insights**: Identifies common claim types, urgency patterns, processing improvements
- **One-Click Analysis**: Generate comprehensive summary with a single button

#### High-Value Claims Tab
- **Value Extraction**: Automatically extracts claim amounts using `AI_EXTRACT`
- **Pattern Analysis**: AI identifies patterns in high-value claims
- **Risk Management Recommendations**: AI provides actionable risk mitigation strategies

#### Risk Analysis Tab
- **Insurance-Specific Analysis**: Filter by insurance type (All, Cyber, D&O, E&O, EPLI, Product Liability, Marine, Aviation, Political Risk)
- **Risk Patterns**: AI identifies common risk factors and emerging threats
- **Prevention Recommendations**: Actionable suggestions to reduce claim frequency

#### Category Analysis Tab
- **Dynamic Category Detection**: Automatically discovers insurance categories in claims
- **Deep Dive Analysis**: AI_AGG provides detailed analysis for selected category
- **Claims Handler Recommendations**: Specific guidance for processing claims in each category

### 6. Recent Claims Feed

- **Interactive Expanders**: Each claim shows in a collapsible card
- **Auto-Classification**: Optional urgency classification (urgent/normal/low_priority)
- **Metadata Display**: Shows insurance type, sentiment, and urgency
- **Adjustable View**: Slider to control number of claims displayed (5-20)

## Cortex AI Functions Used

### AI_EXTRACT
```sql
AI_EXTRACT(
    ticket_text,
    [['insurance_type','What type of insurance is mentioned? Answer with one of: D&O, Cyber, E&O, EPLI, Product Liability, Marine, Aviation, Political Risk']]
):response.insurance_type::string
```
**Purpose**: Extract structured information (insurance type, claim amounts) from unstructured claim text

### AI_AGG
```sql
AI_AGG(
    ticket_text,
    'Analyze these insurance claims. Identify: 1) Most common claim types, 2) Patterns in urgency, 3) Key issues requiring immediate attention, 4) Recommendations for claims processing improvements.'
)
```
**Purpose**: Aggregate insights across multiple claims without context window limits

### AI_SENTIMENT
```sql
AI_SENTIMENT(ticket_text):categories[0].sentiment::string
```
**Purpose**: Analyze sentiment of claims (positive, neutral, negative)

### AI_CLASSIFY
```sql
AI_CLASSIFY(ticket_text, ['urgent', 'normal', 'low_priority']):labels[0]::string
```
**Purpose**: Classify claims by urgency level

## Use Cases

### 1. Claims Operations Management
- Monitor claim volumes across product lines
- Identify bottlenecks and processing delays
- Track sentiment to measure customer satisfaction

### 2. Risk Management
- Identify emerging risk patterns
- Analyze high-value claims for trends
- Get AI-powered recommendations for risk mitigation

### 3. Underwriting Intelligence
- Understand claim frequency by insurance line
- Identify problematic risks or products
- Inform pricing and underwriting decisions

### 4. Executive Reporting
- Quick overview of claims portfolio
- Sentiment analysis for customer experience metrics
- Trend analysis for strategic planning

### 5. Claims Triage
- Auto-classify claims by urgency
- Route high-value claims for priority handling
- Identify claims requiring specialist attention

## Data Sources

The dashboard analyzes data from:
- **customer_tickets**: Main claims data with ticket text, customer info, dates
- **18 total claims**: Including Cyber (6), D&O (2), E&O (1), EPLI (1), Product Liability (1), Marine (3), Aviation (2), Political Risk (2)

## Best Practices

### 1. Performance Optimization
- Dashboard caches AI results where possible
- Use filters to narrow analysis scope
- Consider creating materialized views for frequently-run queries

### 2. Data Quality
- Ensure claim text contains sufficient detail for AI extraction
- Include policy numbers, amounts, and insurance types in claim descriptions
- Use consistent terminology across claims

### 3. Analysis Frequency
- Review key metrics daily
- Run comprehensive AI analysis weekly
- Perform deep-dive category analysis monthly

### 4. Actionable Insights
- Export AI-generated summaries for management reporting
- Use risk analysis recommendations to improve processes
- Track sentiment trends to measure claims handling improvements

## Future Enhancements

Potential additions to the dashboard:

1. **Predictive Analytics**: Use AI to predict claim outcomes and settlement amounts
2. **Comparative Analysis**: Compare performance across time periods
3. **Geographic Analysis**: Map claims by location
4. **Cost Analysis**: Track claims costs and loss ratios by insurance line
5. **Automated Alerts**: Set up notifications for high-value or urgent claims
6. **Integration**: Connect to claims management systems for real-time updates

## Technical Notes

### SQL Query Patterns

**Extract with multiple fields:**
```sql
SELECT 
    ticket_id,
    AI_EXTRACT(ticket_text, [['amount','What is the claim amount?']]):response.amount::string as claim_amount,
    AI_EXTRACT(ticket_text, [['type','What type of insurance?']]):response.type::string as insurance_type
FROM customer_tickets
WHERE category = 'Claims'
```

**Aggregate analysis by category:**
```sql
SELECT 
    AI_AGG(
        ticket_text,
        'Summarize the key issues in these claims'
    ) as analysis
FROM customer_tickets
WHERE category = 'Claims'
AND LOWER(ticket_text) LIKE '%cyber%'
```

**Sentiment distribution:**
```sql
SELECT 
    AI_SENTIMENT(ticket_text):categories[0].sentiment::string as sentiment,
    COUNT(*) as count
FROM customer_tickets
WHERE category = 'Claims'
GROUP BY sentiment
```

## Support and Resources

- **Snowflake Cortex AI Documentation**: https://docs.snowflake.com/en/user-guide/snowflake-cortex
- **Streamlit Documentation**: https://docs.streamlit.io
- **Lloyd's Market Information**: For Marine, Aviation, and Political Risk coverage standards

## Accessing the Dashboard

1. Navigate to the Streamlit app in Snowflake
2. Select "📊 Claims Analytics Dashboard" from the sidebar
3. The dashboard loads automatically with all metrics
4. Click on tabs and buttons to explore different analyses
5. Adjust filters and sliders to customize your view

---

**Last Updated**: February 2024
**Version**: 1.0
**Supported Insurance Lines**: 8 (Cyber, D&O, E&O, EPLI, Product Liability, Marine, Aviation, Political Risk)

