def load_css():
    return """
    <style>
    .main {
        background-color: #ffffff;
    }
    .stTitle {
        color: #4CAF50 !important;
        font-size: 32px;
        font-weight: bold;
        margin-bottom: 1rem;
    }
    .metric-card {
        background-color: #f1f8e9;
        padding: 1rem;
        border-radius: 0.5rem;
        border: 1px solid #81c784;
        color: #2e7d32;
    }
    /* Streamlit 기본 UI 요소 숨기기 */
    #MainMenu {
        visibility: hidden;
    }
    .stDeployButton {
        display: none !important;
    }
    header {
        visibility: hidden;
    }
    footer {
        visibility: hidden;
    }
    /* 추가 Streamlit 요소 숨기기 */
    .reportview-container .main footer {
        visibility: hidden;
    }
    .stToolbar {
        display: none !important;
    }
    </style>
    """ 