package kr.co.greenaurora.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import java.util.Map;
import java.util.List;

@Service
public class BikeAnalyticsService {
    
    @Value("${python.service.url}")
    private String pythonServiceUrl;
    
    private final RestTemplate restTemplate;
    
    public BikeAnalyticsService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }
    
    public Map<String, Object> getSummaryStats() {
        return restTemplate.getForObject(
            pythonServiceUrl + "/api/analytics/summary", 
            Map.class
        );
    }
    
    public Map<String, String> getUsageTrendChart() {
        return restTemplate.getForObject(
            pythonServiceUrl + "/api/analytics/charts/usage_trend", 
            Map.class
        );
    }
    
    public Map<String, String> getStationHeatmap() {
        return restTemplate.getForObject(
            pythonServiceUrl + "/api/analytics/charts/station_heatmap", 
            Map.class
        );
    }
    
    public List<Map<String, Object>> getPopularRoutes() {
        return restTemplate.getForObject(
            pythonServiceUrl + "/api/analytics/popular_routes", 
            List.class
        );
    }
} 