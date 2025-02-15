package kr.co.greenaurora.config;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.util.Hashtable;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Value;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;

import kr.co.greenaurora.dto.QRForm;

public class QRCodeGenerator {
	
	@Value("${server.port}")
	static String portNumber;
	
    // 로컬 IP 주소 얻기
    public static String getLocalIP() {
        try {
            InetAddress inetAddress = InetAddress.getLocalHost();
            return inetAddress.getHostAddress();  // 로컬 IP 주소 반환
        } catch (UnknownHostException e) {
            e.printStackTrace();
            return null;  // IP를 찾을 수 없으면 null 반환
        }
    }
    
    // 오리지널 name추출
    public static String getOrgname(String fullPath) {
    	int idx = fullPath.indexOf("__qr__")+("__qr__").length(); 
		String originName = fullPath.substring(idx);
		return originName;	
    }
    
    public static String getQrFilePath(QRForm qrUrlData) {
    	 // 절대 경로로 디렉토리 지정 (프로젝트 루트 기준)
	    String uploadQRDir = System.getProperty("user.dir") + "/src/main/resources/static/upload/qr/";

	    // 디렉토리가 존재하지 않으면 생성
	    File dir = new File(uploadQRDir);
	    if (!dir.exists()) {
	        dir.mkdirs();
	    }

	    // 파일명에 "qr__사용자"를 추가하고, 랜덤 문자열을 추가한 후 파일을 해당 경로에 저장
	    String originalFilename = qrUrlData.getBicycleNumber();
	    String timestamp = String.valueOf(System.currentTimeMillis());
	    String newFilename = timestamp+"__qr__" + originalFilename;
	    String filePath = uploadQRDir + newFilename;
	    
	    // 파일을 지정된 경로로 저장
	    File qrFile = new File(uploadQRDir, newFilename);
	    if (!qrFile.exists()) {
	    	qrFile.mkdirs();  // 필요한 디렉토리 생성
	    }
	    
	    // 저장된 파일 경로를 반환
	    return uploadQRDir + newFilename; // 웹에서 접근할 수 있도록 상대 경로 반환
    }
	
    // qr 코드 필요 데이터 가공
    public static String makeQrFile(QRForm qrUrlData) {
        try {
        	// QR 코드에 담을 데이터
       	 	// 예약 데이터 설정
        	System.out.println("qr 정보 조회 :::::::: " + qrUrlData);
        	String bicycleNumber = qrUrlData.getBicycleNumber();
            String state = qrUrlData.getState();
            
            // 포트 번호 설정
            //properties 설정
            
            // 로컬 IP 주소 동적으로 얻기
            String localIP = getLocalIP();
            if (localIP == null) {
                System.out.println("로컬 IP를 찾을 수 없습니다.");
                //return "";
                localIP = "";
            }
            System.out.println();
            String baseUrl = "/rental/qr/insert";
            String url = baseUrl + "?bicycleNumber=" + URLEncoder.encode(String.valueOf(bicycleNumber), StandardCharsets.UTF_8)
            + "&state=" + state;

            System.out.println("생성 url2: "+ url);
            String filePath = getQrFilePath(qrUrlData);  // 저장할 파일 경로
           
            // 출력된 URL을 확인
            System.out.println("생성된 URL: " + url);
            
            // QR 코드 생성
            generateQRCodeImage(url, 350, 350, filePath);
            System.out.println("QR 코드 생성 완료: " + filePath);
            return filePath;
        } catch (Exception e) {
            System.out.println("QR 코드 생성 오류: " + e.getMessage());
            return null;
        }
        
    }
    
    // QR 코드 생성(그리기) 메소드
    public static void generateQRCodeImage(String data, int width, int height, String filePath) throws Exception {
        // QR 코드 생성 옵션 설정
        Hashtable<EncodeHintType, Object> hintMap = new Hashtable<>();
        hintMap.put(EncodeHintType.CHARACTER_SET, "UTF-8");  // 문자 인코딩 설정

        // QR 코드 생성
        MultiFormatWriter qrCodeWriter = new MultiFormatWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(data, BarcodeFormat.QR_CODE, width, height, hintMap);

        // 이미지를 BufferedImage로 변환
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        image.createGraphics();
        Graphics2D graphics = (Graphics2D) image.getGraphics();
        graphics.setColor(Color.WHITE);  // 배경색
        graphics.fillRect(0, 0, width, height);  // 배경을 흰색으로 채우기
        graphics.setColor(Color.BLACK);  // QR 코드 색상 (검정)

        // QR 코드의 각 비트를 이미지에 그리기
        for (int x = 0; x < width; x++) {
            for (int y = 0; y < height; y++) {
                image.setRGB(x, y, bitMatrix.get(x, y) ? Color.BLACK.getRGB() : Color.WHITE.getRGB());
            }
        }
        
        // 그래픽 리소스 해제
        graphics.dispose();
        
        // 파일로 저장
        File target = new File(filePath);
        ImageIO.write(image, "PNG", target);
        
        
//        String path = Paths.get("src/main/resources/static/upload/qr").toAbsolutePath().toString();
//        String orgName = getOrgname(filePath);
//        File copyTarget = new File(path+ File.separator +orgName);
        
        
    }
    
    // 자전거 qr 생성
    // 예약 qr이면 
//    public static String makeQrFile(QRForm qrUrlData) {
//    	String bicycleNumber = qrUrlData.getBicycleNumber();
//    	
//    	String url = baseUrl + "?bicycleNumber=" + URLEncoder.encode(String.valueOf(bicycleNumber), StandardCharsets.UTF_8)
//        + "&state=" + URLEncoder.encode(String.valueOf(state), StandardCharsets.UTF_8);
//
//    }

   
}
