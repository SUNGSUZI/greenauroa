import streamlit as st
import folium
import json
import requests
import pandas as pd
from streamlit_folium import folium_static
from folium.plugins import MarkerCluster

# 기본 설정
PAGE_CONFIG = {
    "layout": "wide",
    "page_title": "Green Aurora Dashboard"
}

# 색상 테마
COLORS = {
    "primary": "#66bb6a",
    "secondary": "#a5d6a7",
    "background": "#ffffff"
}

# 지도 설정
MAP_CONFIG = {
    "seoul_center": [37.5665, 126.9780],
    "zoom_level": 11,
    "tile_style": 'CartoDB positron'
}

def get_bike_data():
    """서울시 공공자전거 실시간 대여정보 API 호출"""
    API_KEY = "4a5148476d7a657238397858415851"
    urls = [
        f"http://openapi.seoul.go.kr:8088/{API_KEY}/json/bikeList/1/1000",
        f"http://openapi.seoul.go.kr:8088/{API_KEY}/json/bikeList/1001/2000",
        f"http://openapi.seoul.go.kr:8088/{API_KEY}/json/bikeList/2001/3000"
    ]
    
    try:
        dfs = []
        for url in urls:
            response = requests.get(url)
            data = response.json()
            dfs.append(pd.DataFrame(data['rentBikeStatus']['row']))
        return pd.concat(dfs, ignore_index=True)
    except:
        return pd.DataFrame()

def render_seoul_map():
    with st.container(border=True, height=600):
        st.subheader("서울시 자전거 대여소 현황")
        
        # 기본 지도 생성
        m = folium.Map(
            location=MAP_CONFIG["seoul_center"],
            zoom_start=MAP_CONFIG["zoom_level"],
            tiles=None,
            control_scale=True
        )

        # 타일 레이어 추가
        folium.TileLayer('CartoDB positron', name='Light Map').add_to(m)
        folium.TileLayer('CartoDB dark_matter', name='Dark Map').add_to(m)
        folium.TileLayer('OpenStreetMap', name='Street Map').add_to(m)

        # GeoJSON 데이터 로드
        geo_json_url = 'https://raw.githubusercontent.com/southkorea/seoul-maps/refs/heads/master/kostat/2013/json/seoul_municipalities_geo_simple.json'
        geo_data = requests.get(geo_json_url).json()
        
        # 실시간 대여 데이터 가져오기
        bike_data = get_bike_data()
        
        # 구별 자전거 수 집계
        if not bike_data.empty:
            district_stats = bike_data.groupby('stationName').agg({
                'parkingBikeTotCnt': 'sum',
                'stationLatitude': 'first',
                'stationLongitude': 'first'
            }).reset_index()

            # GeoJSON 스타일링
            folium.GeoJson(
                geo_data,
                style_function=lambda x: {
                    'fillColor': '#2c3e50',
                    'color': '#34495e',
                    'weight': 1.5,
                    'fillOpacity': 0.2
                }
            ).add_to(m)

            # 마커 클러스터 생성
            marker_cluster = MarkerCluster(
                options={
                    'maxClusterRadius': 35,
                    'disableClusteringAtZoom': 14,
                    'spiderfyOnMaxZoom': True,
                    'showCoverageOnHover': True,
                    'zoomToBoundsOnClick': True
                }
            ).add_to(m)
            
            # 마커 추가
            for _, row in district_stats.iterrows():
                bikes = int(row['parkingBikeTotCnt'])
                if bikes > 20:
                    color = '#2ecc71'    # 많음
                elif bikes > 10:
                    color = '#3498db'    # 보통
                else:
                    color = '#e74c3c'    # 적음
                
                folium.CircleMarker(
                    location=[float(row['stationLatitude']), 
                             float(row['stationLongitude'])],
                    radius=min(max(bikes/8, 4), 12),
                    color=color,
                    fill=True,
                    popup=folium.Popup(
                        f"""<div style='font-family: "Noto Sans KR", sans-serif; 
                                      text-align: center;
                                      padding: 5px;'>
                            <b>{row['stationName']}</b><br>
                            대여 가능한 자전거: <b>{bikes}대</b>
                        </div>""",
                        max_width=200
                    ),
                    fill_opacity=0.8,
                    weight=1.5,
                    stroke=True
                ).add_to(marker_cluster)

            # 범례 디자인
            legend_html = '''
            <div style="position: fixed; 
                        bottom: 50px; right: 50px; 
                        border-radius: 8px;
                        background-color: rgba(255, 255, 255, 0.95);
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                        padding: 12px 15px;
                        font-family: 'Noto Sans KR', sans-serif;
                        font-size: 13px;
                        color: #2c3e50;
                        z-index: 9999;">
                <p style="margin: 0 0 8px 0;"><strong>자전거 대여 현황</strong></p>
                <p style="margin: 4px 0;">● <span style="color: #2ecc71;">20대 이상</span></p>
                <p style="margin: 4px 0;">● <span style="color: #3498db;">10-20대</span></p>
                <p style="margin: 4px 0;">● <span style="color: #e74c3c;">10대 미만</span></p>
            </div>
            '''
            m.get_root().html.add_child(folium.Element(legend_html))
        
        # 레이어 컨트롤 추가
        folium.LayerControl().add_to(m)
        
        # 지도 표시
        folium_static(m, height=550)

def main():
    st.set_page_config(**PAGE_CONFIG)
    render_seoul_map()

if __name__ == "__main__":
    main()
