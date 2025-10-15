"""
Cortex AISQL Functions Demonstration
A comprehensive Streamlit app showcasing all Cortex AISQL capabilities
"""

import streamlit as st
from snowflake.snowpark.context import get_active_session
from snowflake.snowpark.functions import col, lit
import pandas as pd

# Page configuration
st.set_page_config(
    page_title="Cortex AISQL Demo",
    page_icon="🤖",
    layout="wide",
    initial_sidebar_state="expanded"
)

# Get Snowpark session
session = get_active_session()

# Custom CSS
st.markdown("""
<style>
    .main-header {
        font-size: 3rem;
        font-weight: bold;
        color: #29B5E8;
        text-align: center;
        padding: 1rem 0;
    }
    .section-header {
        font-size: 1.8rem;
        font-weight: bold;
        color: #29B5E8;
        padding: 1rem 0;
        border-bottom: 2px solid #29B5E8;
        margin-bottom: 1rem;
    }
    .info-box {
        background-color: #f0f8ff;
        padding: 1rem;
        border-radius: 0.5rem;
        border-left: 4px solid #29B5E8;
        margin: 1rem 0;
    }
    .success-box {
        background-color: #d4edda;
        padding: 1rem;
        border-radius: 0.5rem;
        border-left: 4px solid #28a745;
        margin: 1rem 0;
    }
    .stTabs [data-baseweb="tab-list"] {
        gap: 2rem;
    }
    .stTabs [data-baseweb="tab"] {
        padding: 1rem 2rem;
        font-size: 1.1rem;
    }
</style>
""", unsafe_allow_html=True)

# Title
st.markdown('<div class="main-header">🤖 Snowflake Cortex AISQL Demo</div>', unsafe_allow_html=True)
st.markdown("**Comprehensive demonstration of all Cortex AISQL functions with real-world scenarios**")

# Sidebar navigation
st.sidebar.image("https://www.snowflake.com/wp-content/themes/snowflake/assets/img/brand-guidelines/logo-sno-blue-example.svg", width=200)
st.sidebar.markdown("## 📑 Navigation")

demo_option = st.sidebar.radio(
    "Select Demo:",
    [
        "🏠 Overview",
        "📝 Entity Extraction",
        "📊 Insights Aggregation", 
        "🏷️ Content Classification",
        "😊 Sentiment Analysis",
        "🌍 Translation & Localization",
        "📄 Document Parsing",
        "🔍 Advanced Filtering",
        "💬 Text Completion"
    ]
)

# Database setup check
st.sidebar.markdown("---")
st.sidebar.markdown("### Database Setup")
try:
    # Verify tables exist using fully qualified names (no USE statements in stored procedures)
    tables = session.sql("SHOW TABLES IN CORTEX_AISQL_DEMO.DEMO_DATA").collect()
    if len(tables) == 0:
        st.sidebar.error("⚠️ No tables found in DEMO_DATA schema!")
        st.error("### Database Setup Required\n\nPlease run the setup script:\n```bash\nsnow sql -f setup_data.sql\n```")
        st.stop()
    
    st.sidebar.success(f"✅ Connected to CORTEX_AISQL_DEMO ({len(tables)} tables)")
except Exception as e:
    st.sidebar.error(f"⚠️ Database connection error!")
    st.error(f"### Connection Error\n\n{str(e)}\n\nPlease ensure:\n1. Database CORTEX_AISQL_DEMO exists\n2. Schema DEMO_DATA exists\n3. You have proper permissions\n4. Run: `snow sql -f setup_data.sql`")
    st.stop()

# ============================================================
# OVERVIEW PAGE
# ============================================================
if demo_option == "🏠 Overview":
    st.markdown('<div class="section-header">Welcome to Cortex AISQL Demo</div>', unsafe_allow_html=True)
    
    col1, col2 = st.columns(2)
    
    with col1:
        st.markdown("""
        ### 🎯 What is Cortex AISQL?
        
        Snowflake Cortex AISQL provides industry-leading AI capabilities directly within Snowflake:
        
        - **No Setup Required**: Fully hosted and managed by Snowflake
        - **Data Security**: Your data stays within Snowflake
        - **Multiple LLMs**: Access models from OpenAI, Anthropic, Meta, Mistral, and more
        - **SQL Native**: Use AI functions directly in SQL queries
        """)
        
    with col2:
        st.markdown("""
        ### 🚀 Available Functions
        
        This demo showcases:
        
        1. **AI_EXTRACT**: Extract entities and information
        2. **AI_AGG**: Aggregate insights across rows
        3. **AI_CLASSIFY**: Classify text into categories
        4. **AI_FILTER**: Filter content by natural language
        5. **AI_SENTIMENT**: Analyze sentiment
        6. **AI_TRANSLATE**: Translate between languages
        7. **AI_COMPLETE**: Generate completions with LLMs
        8. **AI_SUMMARIZE_AGG**: Summarize aggregated text
        """)
    
    st.markdown("---")
    
    # Show sample data statistics
    st.markdown("### 📊 Demo Data Overview")
    
    stats_cols = st.columns(3)
    
    with stats_cols[0]:
        tickets_count = session.sql("SELECT COUNT(*) as cnt FROM CORTEX_AISQL_DEMO.DEMO_DATA.customer_tickets").collect()[0]['CNT']
        st.metric("Customer Tickets", tickets_count)
        
        reviews_count = session.sql("SELECT COUNT(*) as cnt FROM CORTEX_AISQL_DEMO.DEMO_DATA.product_reviews").collect()[0]['CNT']
        st.metric("Product Reviews", reviews_count)
        
    with stats_cols[1]:
        multi_count = session.sql("SELECT COUNT(*) as cnt FROM CORTEX_AISQL_DEMO.DEMO_DATA.multilingual_content").collect()[0]['CNT']
        st.metric("Multilingual Content", multi_count)
        
        docs_count = session.sql("SELECT COUNT(*) as cnt FROM CORTEX_AISQL_DEMO.DEMO_DATA.documents").collect()[0]['CNT']
        st.metric("Documents", docs_count)
        
    with stats_cols[2]:
        social_count = session.sql("SELECT COUNT(*) as cnt FROM CORTEX_AISQL_DEMO.DEMO_DATA.social_media_posts").collect()[0]['CNT']
        st.metric("Social Media Posts", social_count)
        
        unstructured_count = session.sql("SELECT COUNT(*) as cnt FROM CORTEX_AISQL_DEMO.DEMO_DATA.unstructured_data").collect()[0]['CNT']
        st.metric("Unstructured Data", unstructured_count)
    
    st.info("👈 Use the sidebar to navigate between different demos. Each demo showcases specific Cortex AISQL capabilities with real-world scenarios.")

# ============================================================
# ENTITY EXTRACTION
# ============================================================
elif demo_option == "📝 Entity Extraction":
    st.markdown('<div class="section-header">Entity Extraction with AI_EXTRACT</div>', unsafe_allow_html=True)
    
    st.markdown("""
    ### Use Case: Extracting Entities to Enrich Metadata and Streamline Validation
    
    `AI_EXTRACT` extracts specific information from unstructured text, useful for:
    - Extracting order numbers, dates, and product IDs from customer tickets
    - Parsing contact information from emails
    - Identifying key entities in documents
    """)
    
    tab1, tab2, tab3 = st.tabs(["📧 Customer Tickets", "📄 Unstructured Data", "🎯 Custom Extraction"])
    
    with tab1:
        st.subheader("Extract Key Information from Customer Tickets")
        
        # Load tickets
        tickets_df = session.sql("SELECT * FROM CORTEX_AISQL_DEMO.DEMO_DATA.customer_tickets LIMIT 5").to_pandas()
        
        st.dataframe(tickets_df[['TICKET_ID', 'CUSTOMER_NAME', 'TICKET_TEXT']], use_container_width=True)
        
        if st.button("🔍 Extract Order Numbers, Dates, and Products", key="extract_tickets"):
            with st.spinner("Extracting entities..."):
                
                # Extract information using AI_EXTRACT (text first, then question in array)
                query1 = """
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
                        [['insurance_type','What type of insurance is this? D&O, Cyber, E&O, EPLI, or Product Liability?']]
                    ):response.insurance_type::string as insurance_type
                FROM CORTEX_AISQL_DEMO.DEMO_DATA.customer_tickets
                LIMIT 5
                """
                
                results = session.sql(query1).to_pandas()
                
                st.success("✅ Extraction Complete!")
                st.dataframe(results, use_container_width=True)
                
                with st.expander("📋 View SQL Query"):
                    st.code(query1, language="sql")
    
    with tab2:
        st.subheader("Extract Structured Information from Unstructured Text")
        
        unstructured_df = session.sql("SELECT * FROM CORTEX_AISQL_DEMO.DEMO_DATA.unstructured_data").to_pandas()
        st.dataframe(unstructured_df, use_container_width=True)
        
        extraction_type = st.selectbox(
            "What to extract?",
            ["Email Addresses", "Phone Numbers", "Dates", "Amounts", "Names"]
        )
        
        if st.button("🔍 Extract Information", key="extract_unstructured"):
            with st.spinner(f"Extracting {extraction_type}..."):
                
                prompts = {
                    "Email Addresses": "Extract all email addresses. Return as a comma-separated list.",
                    "Phone Numbers": "Extract all phone numbers. Return as a comma-separated list.",
                    "Dates": "Extract all dates mentioned. Return in YYYY-MM-DD format as comma-separated list.",
                    "Amounts": "Extract all monetary amounts. Return with currency symbols.",
                    "Names": "Extract all person names mentioned. Return as comma-separated list."
                }
                
                query = f"""
                SELECT 
                    data_id,
                    data_source,
                    raw_text,
                    AI_EXTRACT(
                        raw_text,
                        [['value','{prompts[extraction_type]}']]
                    ):response.value::string as extracted_info
                FROM CORTEX_AISQL_DEMO.DEMO_DATA.unstructured_data
                """
                
                results = session.sql(query).to_pandas()
                
                st.success(f"✅ {extraction_type} Extracted!")
                st.dataframe(results, use_container_width=True)
                
                with st.expander("📋 View SQL Query"):
                    st.code(query, language="sql")
    
    with tab3:
        st.subheader("Custom Entity Extraction")
        
        sample_text = st.text_area(
            "Enter text to analyze:",
            value="Contact Sarah Johnson at sarah.j@company.com or call +1-555-0199. Meeting on January 25, 2024 at 2:00 PM. Project budget: $50,000.",
            height=100
        )
        
        extraction_prompt = st.text_input(
            "What do you want to extract?",
            value="Extract all contact information including names, emails, and phone numbers."
        )
        
        if st.button("🔍 Extract", key="custom_extract"):
            with st.spinner("Extracting..."):
                query = f"""
                SELECT AI_EXTRACT(
                    '{sample_text}',
                    [['value','{extraction_prompt}']]
                ):response.value::string as result
                """
                
                result = session.sql(query).collect()[0]['RESULT']
                
                st.success("✅ Extraction Complete!")
                st.markdown(f"**Result:** {result}")
                
                with st.expander("📋 View SQL Query"):
                    st.code(query, language="sql")

# ============================================================
# INSIGHTS AGGREGATION
# ============================================================
elif demo_option == "📊 Insights Aggregation":
    st.markdown('<div class="section-header">Aggregating Insights with AI_AGG</div>', unsafe_allow_html=True)
    
    st.markdown("""
    ### Use Case: Aggregating Insights Across Customer Tickets
    
    `AI_AGG` aggregates text across multiple rows and generates insights without context window limitations.
    Perfect for analyzing large volumes of customer feedback, tickets, or reviews.
    """)
    
    tab1, tab2 = st.tabs(["🎫 Customer Tickets Analysis", "⭐ Product Reviews Analysis"])
    
    with tab1:
        st.subheader("Aggregate Insights from Customer Tickets")
        
        # Show sample tickets
        tickets_preview = session.sql("SELECT ticket_id, category, ticket_text FROM CORTEX_AISQL_DEMO.DEMO_DATA.customer_tickets").to_pandas()
        st.dataframe(tickets_preview.head(5), use_container_width=True)
        
        st.markdown(f"**Total Tickets:** {len(tickets_preview)}")
        
        analysis_type = st.selectbox(
            "Select Analysis Type:",
            [
                "Common Issues Summary",
                "Urgent Issues Identification",
                "Product Mentions",
                "Customer Pain Points"
            ]
        )
        
        if st.button("📊 Analyze All Tickets", key="agg_tickets"):
            with st.spinner("Analyzing all customer tickets..."):
                
                prompts = {
                    "Common Issues Summary": "Summarize the most common issues and complaints mentioned across all tickets. Group by issue type.",
                    "Urgent Issues Identification": "Identify urgent or critical issues that need immediate attention. List them with priority.",
                    "Product Mentions": "List all products mentioned and any issues associated with them.",
                    "Customer Pain Points": "Identify the main customer pain points and areas for improvement."
                }
                
                query = f"""
                SELECT 
                    AI_AGG(
                        ticket_text,
                        '{prompts[analysis_type]}'
                    ) as aggregated_insights
                FROM CORTEX_AISQL_DEMO.DEMO_DATA.customer_tickets
                """
                
                result = session.sql(query).collect()[0]['AGGREGATED_INSIGHTS']
                
                st.success("✅ Analysis Complete!")
                st.markdown("### 📋 Insights:")
                st.markdown(result)
                
                with st.expander("📋 View SQL Query"):
                    st.code(query, language="sql")
        
        st.markdown("---")
        st.subheader("Category-Specific Analysis")
        
        category = st.selectbox(
            "Select Category:",
            ["Claims", "New Business", "Renewal", "Feedback"]
        )
        
        if st.button("📊 Analyze Category", key="agg_category"):
            with st.spinner(f"Analyzing {category} tickets..."):
                
                query = f"""
                SELECT 
                    AI_AGG(
                        ticket_text,
                        'Summarize the key issues and themes in these {category} tickets. Provide actionable recommendations.'
                    ) as category_insights
                FROM CORTEX_AISQL_DEMO.DEMO_DATA.customer_tickets
                WHERE category = '{category}'
                """
                
                result = session.sql(query).collect()[0]['CATEGORY_INSIGHTS']
                
                st.success(f"✅ {category} Analysis Complete!")
                st.markdown("### 📋 Category Insights:")
                st.markdown(result)
                
                with st.expander("📋 View SQL Query"):
                    st.code(query, language="sql")
    
    with tab2:
        st.subheader("Aggregate Product Review Insights")
        
        reviews_preview = session.sql("SELECT review_id, product_name, review_text, rating FROM CORTEX_AISQL_DEMO.DEMO_DATA.product_reviews").to_pandas()
        st.dataframe(reviews_preview, use_container_width=True)
        
        if st.button("📊 Analyze All Reviews", key="agg_reviews"):
            with st.spinner("Analyzing product reviews..."):
                
                query = """
                SELECT 
                    AI_AGG(
                        review_text,
                        'Summarize customer satisfaction levels, common complaints, and praised features across all product reviews.'
                    ) as review_insights
                FROM CORTEX_AISQL_DEMO.DEMO_DATA.product_reviews
                """
                
                result = session.sql(query).collect()[0]['REVIEW_INSIGHTS']
                
                st.success("✅ Review Analysis Complete!")
                st.markdown("### 📋 Overall Review Insights:")
                st.markdown(result)
                
                with st.expander("📋 View SQL Query"):
                    st.code(query, language="sql")

# ============================================================
# CONTENT CLASSIFICATION
# ============================================================
elif demo_option == "🏷️ Content Classification":
    st.markdown('<div class="section-header">Content Classification with AI_CLASSIFY</div>', unsafe_allow_html=True)
    
    st.markdown("""
    ### Use Case: Filtering and Classifying Content by Natural Language
    
    `AI_CLASSIFY` automatically categorizes text into user-defined categories.
    Useful for content moderation, routing, and organization.
    """)
    
    tab1, tab2, tab3 = st.tabs(["📱 Social Media", "⭐ Product Reviews", "🎫 Ticket Routing"])
    
    with tab1:
        st.subheader("Classify Social Media Posts")
        
        posts_df = session.sql("SELECT post_id, username, post_text, platform FROM CORTEX_AISQL_DEMO.DEMO_DATA.social_media_posts").to_pandas()
        st.dataframe(posts_df, use_container_width=True)
        
        categories = st.multiselect(
            "Select Categories to Classify:",
            ["cyber_insurance", "directors_officers", "errors_omissions", "employment_practices", "product_liability", "claims_discussion", "market_trends", "regulatory_compliance"],
            default=["cyber_insurance", "directors_officers", "errors_omissions", "employment_practices"]
        )
        
        if st.button("🏷️ Classify Posts", key="classify_social"):
            if len(categories) > 0:
                with st.spinner("Classifying posts..."):
                    
                    # Format categories as array: ['cat1', 'cat2', 'cat3']
                    categories_array = "['" + "', '".join(categories) + "']"
                    
                    query = f"""
                    SELECT 
                        post_id,
                        username,
                        post_text,
                        platform,
                        AI_CLASSIFY(
                            post_text,
                            {categories_array}
                        ):labels[0]::string as category
                    FROM CORTEX_AISQL_DEMO.DEMO_DATA.social_media_posts
                    """
                    
                    results = session.sql(query).to_pandas()
                    
                    st.success("✅ Classification Complete!")
                    st.dataframe(results, use_container_width=True)
                    
                    # Show distribution
                    st.markdown("### 📊 Category Distribution")
                    category_counts = results['CATEGORY'].value_counts()
                    st.bar_chart(category_counts)
                    
                    with st.expander("📋 View SQL Query"):
                        st.code(query, language="sql")
            else:
                st.warning("Please select at least one category.")
    
    with tab2:
        st.subheader("Classify Product Reviews by Topic")
        
        reviews_df = session.sql("SELECT review_id, product_name, review_text, rating FROM CORTEX_AISQL_DEMO.DEMO_DATA.product_reviews").to_pandas()
        st.dataframe(reviews_df.head(5), use_container_width=True)
        
        review_categories = ["claims_handling", "coverage_quality", "pricing_premium", "customer_service", "policy_clarity"]
        
        if st.button("🏷️ Classify Reviews", key="classify_reviews"):
            with st.spinner("Classifying reviews..."):
                
                categories_str = "', '".join(review_categories)
                
                query = f"""
                SELECT 
                    review_id,
                    product_name,
                    review_text,
                    rating,
                    AI_CLASSIFY(
                        review_text,
                        ['{categories_str}']
                    ):labels[0]::string as review_type
                FROM CORTEX_AISQL_DEMO.DEMO_DATA.product_reviews
                """
                
                results = session.sql(query).to_pandas()
                
                st.success("✅ Classification Complete!")
                st.dataframe(results, use_container_width=True)
                
                col1, col2 = st.columns(2)
                with col1:
                    st.markdown("### 📊 Review Type Distribution")
                    type_counts = results['REVIEW_TYPE'].value_counts()
                    st.bar_chart(type_counts)
                
                with col2:
                    st.markdown("### ⭐ Rating Distribution")
                    rating_counts = results['RATING'].value_counts().sort_index()
                    st.bar_chart(rating_counts)
                
                with st.expander("📋 View SQL Query"):
                    st.code(query, language="sql")
    
    with tab3:
        st.subheader("Intelligent Ticket Routing")
        
        st.markdown("Automatically route tickets to the right department based on content.")
        
        tickets_df = session.sql("SELECT ticket_id, customer_name, ticket_text, category FROM CORTEX_AISQL_DEMO.DEMO_DATA.customer_tickets").to_pandas()
        st.dataframe(tickets_df.head(5), use_container_width=True)
        
        departments = ["claims", "underwriting", "policy_services", "renewals", "customer_service"]
        
        if st.button("🏷️ Route Tickets", key="route_tickets"):
            with st.spinner("Routing tickets..."):
                
                departments_str = "', '".join(departments)
                
                query = f"""
                SELECT 
                    ticket_id,
                    customer_name,
                    ticket_text,
                    category as original_category,
                    AI_CLASSIFY(
                        ticket_text,
                        ['{departments_str}']
                    ):labels[0]::string as recommended_department
                FROM CORTEX_AISQL_DEMO.DEMO_DATA.customer_tickets
                """
                
                results = session.sql(query).to_pandas()
                
                st.success("✅ Ticket Routing Complete!")
                st.dataframe(results, use_container_width=True)
                
                st.markdown("### 📊 Department Distribution")
                dept_counts = results['RECOMMENDED_DEPARTMENT'].value_counts()
                st.bar_chart(dept_counts)
                
                with st.expander("📋 View SQL Query"):
                    st.code(query, language="sql")

# ============================================================
# SENTIMENT ANALYSIS
# ============================================================
elif demo_option == "😊 Sentiment Analysis":
    st.markdown('<div class="section-header">Sentiment Analysis with AI_SENTIMENT</div>', unsafe_allow_html=True)
    
    st.markdown("""
    ### Use Case: Sentiment and Aspect-Based Analysis for Service Improvement
    
    `AI_SENTIMENT` analyzes the emotional tone of text, returning scores from -1 (very negative) to 1 (very positive).
    Essential for understanding customer satisfaction and identifying areas for improvement.
    """)
    
    tab1, tab2, tab3 = st.tabs(["⭐ Product Reviews", "🎫 Customer Tickets", "📱 Social Media"])
    
    with tab1:
        st.subheader("Analyze Product Review Sentiment")
        
        reviews_df = session.sql("SELECT * FROM CORTEX_AISQL_DEMO.DEMO_DATA.product_reviews ORDER BY review_date DESC").to_pandas()
        st.dataframe(reviews_df[['REVIEW_ID', 'PRODUCT_NAME', 'REVIEW_TEXT', 'RATING']], use_container_width=True)
        
        if st.button("😊 Analyze Sentiment", key="sentiment_reviews"):
            with st.spinner("Analyzing sentiment..."):
                
                query = """
                SELECT 
                    review_id,
                    product_name,
                    review_text,
                    rating,
                    AI_SENTIMENT(review_text):categories[0].sentiment::string as sentiment_label
                FROM CORTEX_AISQL_DEMO.DEMO_DATA.product_reviews
                ORDER BY review_date DESC
                """
                
                results = session.sql(query).to_pandas()
                
                st.success("✅ Sentiment Analysis Complete!")
                st.dataframe(results, use_container_width=True)
                
                col1, col2 = st.columns(2)
                
                with col1:
                    st.markdown("### 📊 Sentiment Distribution")
                    sentiment_counts = results['SENTIMENT_LABEL'].value_counts()
                    st.bar_chart(sentiment_counts)
                
                with col2:
                    st.markdown("### 📈 Sentiment by Product")
                    product_sentiment = results.groupby(['PRODUCT_NAME', 'SENTIMENT_LABEL']).size().unstack(fill_value=0)
                    st.bar_chart(product_sentiment)
                
                st.markdown("### 🎯 Insights")
                positive_count = len(results[results['SENTIMENT_LABEL'] == 'positive'])
                negative_count = len(results[results['SENTIMENT_LABEL'] == 'negative'])
                total = len(results)
                st.metric("Positive Reviews", f"{positive_count}/{total} ({positive_count/total*100:.1f}%)")
                
                most_positive = results[results['SENTIMENT_LABEL'] == 'positive'].head(1)
                most_negative = results[results['SENTIMENT_LABEL'] == 'negative'].head(1)
                
                col3, col4 = st.columns(2)
                with col3:
                    if len(most_positive) > 0:
                        st.success(f"**Example Positive Review:**\n\n{most_positive.iloc[0]['PRODUCT_NAME']}\n\nRating: {most_positive.iloc[0]['RATING']}/5")
                
                with col4:
                    if len(most_negative) > 0:
                        st.error(f"**Example Negative Review:**\n\n{most_negative.iloc[0]['PRODUCT_NAME']}\n\nRating: {most_negative.iloc[0]['RATING']}/5")
                
                with st.expander("📋 View SQL Query"):
                    st.code(query, language="sql")
    
    with tab2:
        st.subheader("Analyze Customer Ticket Sentiment")
        
        tickets_df = session.sql("SELECT * FROM CORTEX_AISQL_DEMO.DEMO_DATA.customer_tickets ORDER BY created_date DESC").to_pandas()
        st.dataframe(tickets_df[['TICKET_ID', 'CUSTOMER_NAME', 'TICKET_TEXT', 'CATEGORY']].head(5), use_container_width=True)
        
        if st.button("😊 Analyze Ticket Sentiment", key="sentiment_tickets"):
            with st.spinner("Analyzing ticket sentiment..."):
                
                query = """
                SELECT 
                    ticket_id,
                    customer_name,
                    category,
                    ticket_text,
                    AI_SENTIMENT(ticket_text):categories[0].sentiment::string as sentiment_label
                FROM CORTEX_AISQL_DEMO.DEMO_DATA.customer_tickets
                ORDER BY created_date DESC
                """
                
                results = session.sql(query).to_pandas()
                
                st.success("✅ Ticket Sentiment Analysis Complete!")
                st.dataframe(results, use_container_width=True)
                
                col1, col2 = st.columns(2)
                
                with col1:
                    st.markdown("### 📊 Sentiment Distribution")
                    sentiment_counts = results['SENTIMENT_LABEL'].value_counts()
                    st.bar_chart(sentiment_counts)
                
                with col2:
                    st.markdown("### 📈 Sentiment by Category")
                    category_sentiment = results.groupby(['CATEGORY', 'SENTIMENT_LABEL']).size().unstack(fill_value=0)
                    st.bar_chart(category_sentiment)
                
                # Identify negative sentiment customers
                negative = results[results['SENTIMENT_LABEL'] == 'negative']
                if len(negative) > 0:
                    st.warning(f"⚠️ **{len(negative)} Negative Sentiment Tickets Detected** - May require immediate attention!")
                    st.dataframe(negative[['TICKET_ID', 'CUSTOMER_NAME', 'CATEGORY', 'SENTIMENT_LABEL']], use_container_width=True)
                
                with st.expander("📋 View SQL Query"):
                    st.code(query, language="sql")
    
    with tab3:
        st.subheader("Analyze Social Media Sentiment")
        
        posts_df = session.sql("SELECT * FROM CORTEX_AISQL_DEMO.DEMO_DATA.social_media_posts ORDER BY post_date DESC").to_pandas()
        st.dataframe(posts_df[['POST_ID', 'USERNAME', 'POST_TEXT', 'PLATFORM']].head(5), use_container_width=True)
        
        if st.button("😊 Analyze Social Media Sentiment", key="sentiment_social"):
            with st.spinner("Analyzing social media sentiment..."):
                
                query = """
                SELECT 
                    post_id,
                    username,
                    platform,
                    post_text,
                    AI_SENTIMENT(post_text):categories[0].sentiment::string as sentiment_label
                FROM CORTEX_AISQL_DEMO.DEMO_DATA.social_media_posts
                ORDER BY post_date DESC
                """
                
                results = session.sql(query).to_pandas()
                
                st.success("✅ Social Media Sentiment Analysis Complete!")
                st.dataframe(results, use_container_width=True)
                
                col1, col2 = st.columns(2)
                
                with col1:
                    st.markdown("### 📊 Sentiment Distribution")
                    sentiment_dist = results['SENTIMENT_LABEL'].value_counts()
                    st.bar_chart(sentiment_dist)
                
                with col2:
                    st.markdown("### 📈 Sentiment by Platform")
                    platform_sentiment = results.groupby(['PLATFORM', 'SENTIMENT_LABEL']).size().unstack(fill_value=0)
                    st.bar_chart(platform_sentiment)
                
                with st.expander("📋 View SQL Query"):
                    st.code(query, language="sql")

# ============================================================
# TRANSLATION & LOCALIZATION
# ============================================================
elif demo_option == "🌍 Translation & Localization":
    st.markdown('<div class="section-header">Translation with AI_TRANSLATE</div>', unsafe_allow_html=True)
    
    st.markdown("""
    ### Use Case: Translating and Localizing Multilingual Content
    
    `AI_TRANSLATE` translates text between multiple languages, essential for:
    - Global customer support
    - Multilingual content management
    - International marketing campaigns
    """)
    
    tab1, tab2 = st.tabs(["🌐 Batch Translation", "✍️ Custom Translation"])
    
    with tab1:
        st.subheader("Translate Multilingual Content")
        
        content_df = session.sql("SELECT * FROM CORTEX_AISQL_DEMO.DEMO_DATA.multilingual_content ORDER BY content_id").to_pandas()
        st.dataframe(content_df, use_container_width=True)
        
        target_languages = st.multiselect(
            "Select target languages:",
            ["en", "es", "fr", "de", "it", "pt", "ja", "ko", "zh"],
            default=["en", "es"]
        )
        
        if st.button("🌍 Translate Content", key="translate_batch"):
            if len(target_languages) > 0:
                with st.spinner("Translating content..."):
                    
                    translations = []
                    
                    for target_lang in target_languages:
                        query = f"""
                        SELECT 
                            content_id,
                            content_type,
                            original_text,
                            source_language,
                            '{target_lang}' as target_language,
                            AI_TRANSLATE(
                                original_text,
                                source_language,
                                '{target_lang}'
                            ) as translated_text
                        FROM CORTEX_AISQL_DEMO.DEMO_DATA.multilingual_content
                        WHERE source_language != '{target_lang}'
                        """
                        
                        results = session.sql(query).to_pandas()
                        translations.append(results)
                    
                    all_translations = pd.concat(translations, ignore_index=True)
                    
                    st.success("✅ Translation Complete!")
                    st.dataframe(all_translations, use_container_width=True)
                    
                    st.markdown("### 📊 Translation Summary")
                    summary_col1, summary_col2 = st.columns(2)
                    
                    with summary_col1:
                        st.metric("Total Translations", len(all_translations))
                        st.metric("Unique Content Items", all_translations['CONTENT_ID'].nunique())
                    
                    with summary_col2:
                        st.metric("Target Languages", len(target_languages))
                        lang_dist = all_translations['TARGET_LANGUAGE'].value_counts()
                        st.bar_chart(lang_dist)
                    
                    with st.expander("📋 View Sample SQL Query"):
                        st.code(query, language="sql")
            else:
                st.warning("Please select at least one target language.")
    
    with tab2:
        st.subheader("Custom Text Translation")
        
        col1, col2 = st.columns(2)
        
        with col1:
            source_lang = st.selectbox(
                "Source Language:",
                ["en", "es", "fr", "de", "it", "pt", "ja", "ko", "zh", "nl", "pl"],
                index=0
            )
        
        with col2:
            target_lang = st.selectbox(
                "Target Language:",
                ["en", "es", "fr", "de", "it", "pt", "ja", "ko", "zh", "nl", "pl"],
                index=1
            )
        
        input_text = st.text_area(
            "Enter text to translate:",
            value="Your cyber insurance claim has been approved. Our incident response team will contact you within 24 hours. Coverage includes forensics, legal fees, and notification costs up to policy limits. Claims support is available 24/7.",
            height=150
        )
        
        if st.button("🌍 Translate", key="translate_custom"):
            if input_text and source_lang != target_lang:
                with st.spinner(f"Translating from {source_lang} to {target_lang}..."):
                    
                    query = f"""
                    SELECT AI_TRANSLATE(
                        '{input_text}',
                        '{source_lang}',
                        '{target_lang}'
                    ) as translation
                    """
                    
                    result = session.sql(query).collect()[0]['TRANSLATION']
                    
                    st.success("✅ Translation Complete!")
                    
                    result_col1, result_col2 = st.columns(2)
                    
                    with result_col1:
                        st.markdown(f"**Original ({source_lang}):**")
                        st.info(input_text)
                    
                    with result_col2:
                        st.markdown(f"**Translation ({target_lang}):**")
                        st.success(result)
                    
                    with st.expander("📋 View SQL Query"):
                        st.code(query, language="sql")
            else:
                if source_lang == target_lang:
                    st.warning("Source and target languages must be different.")
                else:
                    st.warning("Please enter text to translate.")

# ============================================================
# DOCUMENT PARSING
# ============================================================
elif demo_option == "📄 Document Parsing":
    st.markdown('<div class="section-header">Document Analysis with AI_SUMMARIZE_AGG</div>', unsafe_allow_html=True)
    
    st.markdown("""
    ### Use Case: Parsing Documents for Analytics and RAG Pipelines
    
    Process and analyze documents for:
    - Document summarization
    - Key information extraction
    - Knowledge base creation
    - RAG (Retrieval Augmented Generation) pipelines
    """)
    
    tab1, tab2 = st.tabs(["📚 Document Analysis", "📊 Document Insights"])
    
    with tab1:
        st.subheader("Analyze and Summarize Documents")
        
        docs_df = session.sql("SELECT doc_id, document_name, doc_type, created_date FROM CORTEX_AISQL_DEMO.DEMO_DATA.documents").to_pandas()
        st.dataframe(docs_df, use_container_width=True)
        
        selected_doc = st.selectbox(
            "Select a document to analyze:",
            docs_df['DOCUMENT_NAME'].tolist()
        )
        
        if st.button("📄 View Document", key="view_doc"):
            doc_text = session.sql(f"""
                SELECT document_text 
                FROM CORTEX_AISQL_DEMO.DEMO_DATA.documents 
                WHERE document_name = '{selected_doc}'
            """).collect()[0]['DOCUMENT_TEXT']
            
            st.markdown("### 📄 Document Content:")
            st.text_area("", value=doc_text, height=200, disabled=True)
        
        analysis_options = st.multiselect(
            "Select analysis to perform:",
            ["Summarize Policy Terms", "Extract Coverage Limits", "Identify Claims Metrics", "Extract Premium & Retention", "List Exclusions"],
            default=["Summarize Policy Terms"]
        )
        
        if st.button("🔍 Analyze Document", key="analyze_doc"):
            if len(analysis_options) > 0:
                with st.spinner("Analyzing document..."):
                    
                    for option in analysis_options:
                        st.markdown(f"### 📋 {option}")
                        
                        prompts = {
                            "Summarize Policy Terms": "Provide a concise summary of this insurance document highlighting coverage types, key terms, and important details.",
                            "Extract Coverage Limits": "Extract all coverage limits, policy limits, and monetary amounts mentioned in this document.",
                            "Identify Claims Metrics": "Identify all claims-related metrics, statistics, frequencies, severities, and trends mentioned.",
                            "Extract Premium & Retention": "Extract premium amounts, retention amounts, deductibles, and payment terms.",
                            "List Exclusions": "List all policy exclusions, limitations, and restrictions mentioned in this document."
                        }
                        
                        query = f"""
                        SELECT 
                            AI_EXTRACT(
                                document_text,
                                [['value','{prompts[option]}']]
                            ):response.value::string as result
                        FROM CORTEX_AISQL_DEMO.DEMO_DATA.documents
                        WHERE document_name = '{selected_doc}'
                        """
                        
                        result = session.sql(query).collect()[0]['RESULT']
                        
                        st.success(result)
                        st.markdown("---")
                    
                    with st.expander("📋 View SQL Query"):
                        st.code(query, language="sql")
            else:
                st.warning("Please select at least one analysis option.")
    
    with tab2:
        st.subheader("Aggregate Document Insights")
        
        st.markdown("Analyze patterns across all documents")
        
        doc_type_filter = st.selectbox(
            "Filter by document type (optional):",
            ["All Types", "claims_report", "policy_terms", "underwriting_guide", "meeting_minutes", "service_agreement"]
        )
        
        insight_type = st.selectbox(
            "Select insight type:",
            [
                "Claims Trends Analysis",
                "Coverage Limits Summary",
                "Risk Assessment Factors",
                "Premium & Pricing Insights"
            ]
        )
        
        if st.button("📊 Generate Insights", key="doc_insights"):
            with st.spinner("Generating insights..."):
                
                where_clause = "" if doc_type_filter == "All Types" else f"WHERE doc_type = '{doc_type_filter}'"
                
                prompts = {
                    "Claims Trends Analysis": "Identify claims trends, incident types, severity patterns, and frequency patterns across these insurance documents.",
                    "Coverage Limits Summary": "Summarize all coverage limits, policy limits, retention amounts, and deductibles mentioned across documents.",
                    "Risk Assessment Factors": "Identify risk factors, underwriting criteria, exclusions, and coverage limitations mentioned.",
                    "Premium & Pricing Insights": "Extract premium amounts, pricing structures, rating factors, and fee information across documents."
                }
                
                query = f"""
                SELECT 
                    AI_AGG(
                        document_text,
                        '{prompts[insight_type]}'
                    ) as insights
                FROM CORTEX_AISQL_DEMO.DEMO_DATA.documents
                {where_clause}
                """
                
                result = session.sql(query).collect()[0]['INSIGHTS']
                
                st.success("✅ Insights Generated!")
                st.markdown("### 📋 Results:")
                st.markdown(result)
                
                with st.expander("📋 View SQL Query"):
                    st.code(query, language="sql")

# ============================================================
# ADVANCED FILTERING
# ============================================================
elif demo_option == "🔍 Advanced Filtering":
    st.markdown('<div class="section-header">Content Filtering with AI_FILTER</div>', unsafe_allow_html=True)
    
    st.markdown("""
    ### Use Case: Filter Content Using Natural Language Conditions
    
    `AI_FILTER` evaluates natural language conditions and returns True/False, enabling:
    - Intelligent content filtering
    - Rule-based data selection
    - Dynamic query conditions
    """)
    
    tab1, tab2, tab3 = st.tabs(["🎫 Filter Tickets", "⭐ Filter Reviews", "✍️ Custom Filter"])
    
    with tab1:
        st.subheader("Filter Customer Tickets with Natural Language")
        
        tickets_df = session.sql("SELECT ticket_id, customer_name, ticket_text, category FROM CORTEX_AISQL_DEMO.DEMO_DATA.customer_tickets").to_pandas()
        st.markdown(f"**Total Tickets:** {len(tickets_df)}")
        st.dataframe(tickets_df.head(3), use_container_width=True)
        
        filter_conditions = [
            "Does this ticket mention a cyber security incident or ransomware?",
            "Is this a claim notification requiring immediate attention?",
            "Does this ticket mention D AND O or directors and officers insurance?",
            "Is this ticket requesting a policy quote or new business?",
            "Does this mention coverage limits, retention, or deductibles?"
        ]
        
        selected_filter = st.selectbox("Select filter condition:", filter_conditions)
        
        if st.button("🔍 Apply Filter", key="filter_tickets"):
            with st.spinner("Filtering tickets..."):
                
                query = f"""
                SELECT 
                    ticket_id,
                    customer_name,
                    ticket_text,
                    category,
                    AI_FILTER(
                        PROMPT('{selected_filter} {{0}}', ticket_text)
                    ) as matches_condition
                FROM CORTEX_AISQL_DEMO.DEMO_DATA.customer_tickets
                """
                
                results = session.sql(query).to_pandas()
                
                matching = results[results['MATCHES_CONDITION'] == True]
                
                st.success(f"✅ Filter Applied! Found {len(matching)} matching tickets out of {len(results)} total.")
                
                col1, col2 = st.columns(2)
                
                with col1:
                    st.markdown("### ✅ Matching Tickets")
                    st.dataframe(matching[['TICKET_ID', 'CUSTOMER_NAME', 'CATEGORY']], use_container_width=True)
                
                with col2:
                    st.markdown("### ❌ Non-Matching Tickets")
                    non_matching = results[results['MATCHES_CONDITION'] == False]
                    st.dataframe(non_matching[['TICKET_ID', 'CUSTOMER_NAME', 'CATEGORY']], use_container_width=True)
                
                st.markdown("### 📄 Matching Ticket Details")
                st.dataframe(matching, use_container_width=True)
                
                with st.expander("📋 View SQL Query"):
                    st.code(query, language="sql")
    
    with tab2:
        st.subheader("Filter Product Reviews")
        
        reviews_df = session.sql("SELECT review_id, product_name, review_text, rating FROM CORTEX_AISQL_DEMO.DEMO_DATA.product_reviews").to_pandas()
        st.markdown(f"**Total Reviews:** {len(reviews_df)}")
        st.dataframe(reviews_df.head(3), use_container_width=True)
        
        review_filters = [
            "Does this review mention claims handling or claims service?",
            "Is the reviewer satisfied with the coverage provided?",
            "Does this review mention premium pricing concerns?",
            "Does this review discuss response time or service speed?",
            "Would the reviewer recommend this insurance product?"
        ]
        
        selected_review_filter = st.selectbox("Select filter condition:", review_filters)
        
        if st.button("🔍 Apply Review Filter", key="filter_reviews"):
            with st.spinner("Filtering reviews..."):
                
                query = f"""
                SELECT 
                    review_id,
                    product_name,
                    review_text,
                    rating,
                    AI_FILTER(
                        PROMPT('{selected_review_filter} {{0}}', review_text)
                    ) as matches_condition
                FROM CORTEX_AISQL_DEMO.DEMO_DATA.product_reviews
                """
                
                results = session.sql(query).to_pandas()
                matching = results[results['MATCHES_CONDITION'] == True]
                
                st.success(f"✅ Found {len(matching)} matching reviews out of {len(results)} total.")
                
                st.markdown("### ✅ Matching Reviews")
                st.dataframe(matching, use_container_width=True)
                
                if len(matching) > 0:
                    avg_rating = matching['RATING'].mean()
                    st.metric("Average Rating of Matching Reviews", f"{avg_rating:.2f} ⭐")
                
                with st.expander("📋 View SQL Query"):
                    st.code(query, language="sql")
    
    with tab3:
        st.subheader("Custom Filter Builder")
        
        data_source = st.radio(
            "Select data source:",
            ["Customer Tickets", "Product Reviews", "Social Media Posts"]
        )
        
        custom_condition = st.text_input(
            "Enter your filter condition (natural language):",
            value="Does this mention a cyber security incident or data breach?"
        )
        
        if st.button("🔍 Apply Custom Filter", key="custom_filter"):
            with st.spinner("Applying custom filter..."):
                
                table_mapping = {
                    "Customer Tickets": ("customer_tickets", "ticket_text", ["ticket_id", "customer_name", "ticket_text"]),
                    "Product Reviews": ("product_reviews", "review_text", ["review_id", "product_name", "review_text"]),
                    "Social Media Posts": ("social_media_posts", "post_text", ["post_id", "username", "post_text"])
                }
                
                table_name, text_column, display_columns = table_mapping[data_source]
                columns_str = ", ".join(display_columns)
                
                query = f"""
                SELECT 
                    {columns_str},
                    AI_FILTER(
                        PROMPT('{custom_condition} {{0}}', {text_column})
                    ) as matches_condition
                FROM CORTEX_AISQL_DEMO.DEMO_DATA.{table_name}
                """
                
                results = session.sql(query).to_pandas()
                matching = results[results['MATCHES_CONDITION'] == True]
                
                st.success(f"✅ Found {len(matching)} matching records out of {len(results)} total.")
                
                st.markdown("### ✅ Matching Records")
                st.dataframe(matching, use_container_width=True)
                
                st.markdown("### 📊 Filter Results")
                match_pct = (len(matching) / len(results) * 100) if len(results) > 0 else 0
                st.metric("Match Percentage", f"{match_pct:.1f}%")
                
                with st.expander("📋 View SQL Query"):
                    st.code(query, language="sql")

# ============================================================
# TEXT COMPLETION
# ============================================================
elif demo_option == "💬 Text Completion":
    st.markdown('<div class="section-header">Text Generation with AI_COMPLETE</div>', unsafe_allow_html=True)
    
    st.markdown("""
    ### Use Case: Generate Responses and Content with LLMs
    
    `AI_COMPLETE` (formerly COMPLETE) generates text using state-of-the-art LLMs from OpenAI, Anthropic, Meta, and more.
    Perfect for automated responses, content generation, and creative tasks.
    """)
    
    tab1, tab2, tab3 = st.tabs(["✉️ Response Generation", "📝 Content Creation", "🤖 Custom Prompts"])
    
    with tab1:
        st.subheader("Generate Customer Response Templates")
        
        tickets_df = session.sql("SELECT ticket_id, customer_name, ticket_text, category FROM CORTEX_AISQL_DEMO.DEMO_DATA.customer_tickets LIMIT 3").to_pandas()
        
        st.markdown("**Sample Tickets:**")
        st.dataframe(tickets_df, use_container_width=True)
        
        ticket_id = st.selectbox("Select a ticket:", tickets_df['TICKET_ID'].tolist())
        
        response_model = st.selectbox(
            "Select LLM Model:",
            ["llama3.1-70b", "llama3.1-8b", "mistral-large2", "mixtral-8x7b"]
        )
        
        if st.button("✉️ Generate Response", key="generate_response"):
            with st.spinner("Generating personalized response..."):
                
                ticket_data = tickets_df[tickets_df['TICKET_ID'] == ticket_id].iloc[0]
                
                # Escape single quotes in the text to prevent SQL errors
                customer_name = str(ticket_data['CUSTOMER_NAME']).replace("'", "''")
                category = str(ticket_data['CATEGORY']).replace("'", "''")
                ticket_text = str(ticket_data['TICKET_TEXT']).replace("'", "''")
                
                prompt = f"""You are a professional insurance customer service representative. 

Customer: {customer_name}
Category: {category}
Ticket: {ticket_text}

Write a professional, empathetic response addressing the customer's insurance concerns. 
Be specific, helpful, and maintain a friendly tone."""
                
                # Escape single quotes in the prompt for SQL
                escaped_prompt = prompt.replace("'", "''")
                
                query = f"""
                SELECT AI_COMPLETE(
                    '{response_model}',
                    '{escaped_prompt}'
                ) as response
                """
                
                result = session.sql(query).collect()[0]['RESPONSE']
                
                st.success("✅ Response Generated!")
                
                col1, col2 = st.columns([1, 1])
                
                with col1:
                    st.markdown("### 📧 Customer Ticket")
                    st.info(ticket_data['TICKET_TEXT'])
                
                with col2:
                    st.markdown("### 💬 Generated Response")
                    st.success(result)
                
                with st.expander("📋 View SQL Query"):
                    st.code(query, language="sql")
    
    with tab2:
        st.subheader("Content Creation Assistant")
        
        content_type = st.selectbox(
            "Select content type:",
            ["Policy Summary", "Claims Notification Email", "Social Media Post", "Coverage Explanation", "FAQ Answer"]
        )
        
        topic = st.text_input(
            "Enter topic or insurance product:",
            value="Cyber Insurance Coverage"
        )
        
        tone = st.selectbox(
            "Select tone:",
            ["Professional", "Casual", "Enthusiastic", "Technical", "Friendly"]
        )
        
        model = st.selectbox(
            "Select Model:",
            ["llama3.1-70b", "mistral-large2", "mixtral-8x7b", "llama3.1-8b"],
            key="content_model"
        )
        
        if st.button("📝 Generate Content", key="generate_content"):
            with st.spinner(f"Generating {content_type}..."):
                
                prompts = {
                    "Policy Summary": f"Write a clear policy summary for {topic}. Highlight key coverage features, limits, and benefits. Tone: {tone}.",
                    "Claims Notification Email": f"Write a claims notification email about {topic}. Include next steps, what is covered, and contact information. Tone: {tone}.",
                    "Social Media Post": f"Write an engaging social media post about {topic} insurance. Keep it concise and include relevant insurance hashtags. Tone: {tone}.",
                    "Coverage Explanation": f"Write a clear explanation of {topic} for policyholders. Explain what is covered, exclusions, and why it matters. Tone: {tone}.",
                    "FAQ Answer": f"Write a comprehensive FAQ answer about {topic} insurance. Be clear, helpful, and address common concerns. Tone: {tone}."
                }
                
                prompt = prompts[content_type]
                
                query = f"""
                SELECT AI_COMPLETE(
                    '{model}',
                    '{prompt}'
                ) as content
                """
                
                result = session.sql(query).collect()[0]['CONTENT']
                
                st.success("✅ Content Generated!")
                st.markdown(f"### 📄 {content_type}")
                st.markdown(result)
                
                col1, col2, col3 = st.columns(3)
                with col1:
                    st.metric("Model Used", model)
                with col2:
                    st.metric("Content Type", content_type)
                with col3:
                    st.metric("Tone", tone)
                
                with st.expander("📋 View SQL Query"):
                    st.code(query, language="sql")
    
    with tab3:
        st.subheader("Custom Prompt Playground")
        
        st.markdown("Test any prompt with different models")
        
        custom_model = st.selectbox(
            "Select Model:",
            ["llama3.1-70b", "llama3.1-8b", "mistral-large2", "mixtral-8x7b"],
            key="custom_model"
        )
        
        custom_prompt = st.text_area(
            "Enter your prompt:",
            value="Explain the benefits of using Snowflake Cortex AISQL functions in a data analytics workflow.",
            height=150
        )
        
        col1, col2 = st.columns(2)
        with col1:
            max_tokens = st.slider("Max Tokens", 50, 1000, 500)
        with col2:
            temperature = st.slider("Temperature", 0.0, 1.0, 0.7, 0.1)
        
        if st.button("🤖 Generate", key="custom_complete"):
            with st.spinner("Generating response..."):
                
                # Note: Temperature and max_tokens options depend on Snowflake's implementation
                query = f"""
                SELECT AI_COMPLETE(
                    '{custom_model}',
                    '{custom_prompt}'
                ) as result
                """
                
                result = session.sql(query).collect()[0]['RESULT']
                
                st.success("✅ Generation Complete!")
                st.markdown("### 💬 Response:")
                st.markdown(result)
                
                st.markdown("### ⚙️ Configuration")
                config_col1, config_col2, config_col3 = st.columns(3)
                with config_col1:
                    st.metric("Model", custom_model)
                with config_col2:
                    st.metric("Max Tokens", max_tokens)
                with config_col3:
                    st.metric("Temperature", temperature)
                
                with st.expander("📋 View SQL Query"):
                    st.code(query, language="sql")

# Footer
st.markdown("---")
st.markdown("""
<div style='text-align: center; color: #666; padding: 2rem;'>
    <p>Built with ❤️ using Snowflake Cortex AISQL</p>
    <p>Powered by: llama3.1-70b, mistral-large2, and other industry-leading LLMs</p>
</div>
""", unsafe_allow_html=True)

