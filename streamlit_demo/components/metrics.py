import streamlit as st

def render_usage_metrics():
    with st.container(border=True, height=150):
        st.subheader("총 이용 건수")
        col1, col2 = st.columns(2)
        with col1:
            st.metric(label="이번 달", value="301,661", delta="-5%")
        with col2:
            st.metric(label="지난 달", value="312,379")

def render_member_metrics():
    with st.container(border=True, height=150):
        st.subheader("회원 현황")
        col1, col2 = st.columns(2)
        with col1:
            st.metric(label="정기권", value="60%", delta="3%")
        with col2:
            st.metric(label="일일권", value="40%", delta="-3%")

def render_station_metrics():
    with st.container(border=True, height=150):
        st.subheader("대여소 현황")
        col1, col2 = st.columns(2)
        with col1:
            st.metric(label="운영 대여소", value="2,789", delta="10개")
        with col2:
            st.metric(label="자전거 수", value="37,500", delta="500대") 