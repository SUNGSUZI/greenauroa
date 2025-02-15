import streamlit as st
from datetime import datetime
from config.settings import PAGE_CONFIG
from styles.custom import load_css
from components.metrics import (
    render_usage_metrics,
    render_member_metrics,
    render_station_metrics
)
from components.charts import (
    render_district_usage,
    render_hourly_usage,
    render_age_distribution,
    render_member_types,
    render_monthly_trend
)
from components.maps import render_seoul_map

# 페이지 설정
st.set_page_config(**PAGE_CONFIG)

# 사용자 정의 CSS 로드
st.markdown(load_css(), unsafe_allow_html=True)

# 제목 및 날짜
st.title("Green Aurora Dashboard")
year = datetime.now().year
month = datetime.now().month
st.markdown(f"<p style='color: #4CAF50;'>{year}년 {month}월</p>", unsafe_allow_html=True)

# 상단 지표
top_cols = st.columns(3)
with top_cols[0]:
    render_usage_metrics()
with top_cols[1]:
    render_member_metrics()
with top_cols[2]:
    render_station_metrics()

# 중간 행
mid_cols = st.columns([1, 2, 1])
with mid_cols[0]:
    render_district_usage()
with mid_cols[1]:
    render_seoul_map()
with mid_cols[2]:
    render_hourly_usage()

# 하단 행
bottom_cols = st.columns(3)
with bottom_cols[0]:
    render_age_distribution()
with bottom_cols[1]:
    render_member_types()
with bottom_cols[2]:
    render_monthly_trend()

# 돌아가기 버튼
if st.button("Spring Boot App으로 돌아가기", key="return_button"):
    st.markdown('<meta http-equiv="refresh" content="0;url=http://localhost:8909/main">', unsafe_allow_html=True)
