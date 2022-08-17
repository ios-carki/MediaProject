//
//  WeatherViewController.swift
//  MediaProject
//
//  Created by Carki on 2022/08/15.
//

import CoreLocation
import UIKit
import MapKit

import Alamofire
import Kingfisher
import SwiftyJSON


class WeatherViewController: UIViewController {
    
    @IBOutlet weak var nowDateLabel: UILabel!
    
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var exportImageButton: UIButton!
    @IBOutlet weak var refreshImageButton: UIButton!
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humiLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var mentLabel: UILabel!
    
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("뷰디드 로드 시작 순서", #function)
        //나중에 기능 추가할 버튼
        exportImageButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        exportImageButton.tintColor = .white
        refreshImageButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        refreshImageButton.tintColor = .white
        iconImageView.backgroundColor = .white
        
        labelDesign(headLabelName: nowDateLabel, bodyLabelName: locationLabel)
        mentLabelDesign(mentLabelName: mentLabel)
        locationImageDesign(imageName: locationImageView)
        messageLabelDesign(tempLabelName: tempLabel, humiLabelName: humiLabel, windLabelName: windLabel)
        
        checkUserDeviceLocationServiceAuthorization()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 거리 정확도
        locationManager.requestWhenInUseAuthorization() // 위치데이터 사용 허용받기, Alert'
        
        if CLLocationManager.locationServicesEnabled() {
            print("위치데이터 사용 허용 상태")
            locationManager.startUpdatingLocation() //위치정보 받아오기 시작
            print(locationManager.location?.coordinate)
        } else {
            print("위치데이터 사용 불가 상태")
        }
        
    }
    
    func labelDesign(headLabelName: UILabel, bodyLabelName: UILabel) {
        headLabelName.textColor = .white
        headLabelName.font = .systemFont(ofSize: 12)
        headLabelName.text = nowDateFunc()
        
        bodyLabelName.textColor = .white
        bodyLabelName.font = .systemFont(ofSize: 18)
        
    }
    
    func mentLabelDesign(mentLabelName: UILabel) {
        mentLabelName.textColor = .black
        mentLabelName.backgroundColor = .white
        mentLabelName.clipsToBounds = true
        mentLabelName.layer.borderWidth = 1
        mentLabelName.layer.cornerRadius = 10
    }
    
    func messageLabelDesign(tempLabelName: UILabel, humiLabelName: UILabel, windLabelName: UILabel) {
        
        tempLabelName.textColor = .black
        humiLabelName.textColor = .black
        windLabelName.textColor = .black
        
        tempLabelName.backgroundColor = .white
        humiLabelName.backgroundColor = .white
        windLabelName.backgroundColor = .white
        
        tempLabelName.layer.borderWidth = 1
        humiLabelName.layer.borderWidth = 1
        windLabelName.layer.borderWidth = 1
        
        tempLabelName.layer.cornerRadius = 10
        tempLabelName.clipsToBounds = true
        
        humiLabelName.layer.cornerRadius = 10
        humiLabelName.clipsToBounds = true
        
        windLabelName.layer.cornerRadius = 10
        windLabelName.clipsToBounds = true
        
    }
    
    func locationImageDesign(imageName: UIImageView) {
        imageName.image = UIImage(systemName: "location.fill")
        imageName.tintColor = .white
    }
    
    func nowDateFunc() -> String {
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일 hh시 mm분"
        
        let convertDate = dateFormatter.string(from: nowDate)
        
        return convertDate
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        
        let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "캠퍼스"
        
    }
    
}

//위치관련 프로토콜 선언
extension WeatherViewController: CLLocationManagerDelegate {
    
//    func locationRequest() {
//        print("요청함수", #function)
//        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(UserDefaults.standard.string(forKey: "latitude")!)&lon=\(UserDefaults.standard.string(forKey: "longitude")!)&appid=\(APIKey.OpenWeather)"
//
//
//        print(mainWeatherDataList)
////        tempLabel.text = mainWeatherDataList.temper
////        print("온도\(UserDefaults.standard.string(forKey: "temper"))")
//        humiLabel.text = "\(UserDefaults.standard.integer(forKey: "humi"))% 만큼 습해요"
//        print(UserDefaults.standard.integer(forKey: "humi"))
//        windLabel.text = "\(UserDefaults.standard.integer(forKey: "wind"))m/s의 바람이 불어요"
//        print(UserDefaults.standard.integer(forKey: "wind"))
//    }
    
    //사용자 위치를 성공적으로 가져온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("이거 어디야", #function)
        if let location = locations.last?.coordinate {
            let latitude = location.latitude
            let longitude = location.longitude
            
//            UserDefaults.standard.set(latitude, forKey: "latitude")
//            UserDefaults.standard.set(longitude, forKey: "longitude")
            WeatherAPIManager.shared.weatherDataRequest(lat: latitude, longi: longitude) { data in
                DispatchQueue.main.async {
                    print(data)
                    
                    self.tempLabel.text = " 지금은 \(String(Int(data.temp - 273.15)))'C에요 "
                    self.humiLabel.text = " \(data.humidity)%만큼 습해요 "
                    self.windLabel.text = " \(Int(ceil(data.wind)))m/s의 바람이 불어요 "
                    let imageUrl = URL(string: "\(endPoint.weatherImageURL)\(data.icon)@2x.png")!
                    print(imageUrl)
                    self.iconImageView.kf.setImage(with:imageUrl)
                    self.mentLabel.text = " 오늘도 행복한 하루 보내세요 "
                }
            }
        }
            
//            let center = CLLocation(latitude: latitude, longitude: longitude)
            
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        let location = self.locationManager.location
        var locationData: [String] = []
        
            if location != nil {
                geocoder.reverseGeocodeLocation(location!) { (placemarks, error) in
                    if error != nil {
                        return
                    }
                    if let placemark = placemarks?.first {
                        var address = ""
                        
                        if let administrativeArea = placemark.administrativeArea {
                            address = "\(address) \(administrativeArea) "
                            self.locationLabel.text = address
                        }
                        if let locality = placemark.locality {
                            address = "\(address) \(locality) "
                            
                        }
                        if let thoroughfare = placemark.thoroughfare {
                            address = "\(address) \(thoroughfare) "
                            
                        }
                    }
                }
            }
        
        locationManager.stopUpdatingLocation()
    }
    
    //위치 가져오기 실패
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ERROR!")
    }
    
    //사용자의 권한상태 바뀔때 알려줌(iOS14+)
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        <#code#>
//    }
    
    //사용자의 권한상태 바뀔때 알려줌(iOS14-)
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        <#code#>
//    }
}

//위치 관련된 user def메서드
extension WeatherViewController {
    
    //iOS버전에 따른 분기 처리 및 iOS 위치 서비스 활성화 여부 확인
    func checkUserDeviceLocationServiceAuthorization() {
        
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            //인스턴스를 통해 locationManager가 가지고 있는 상태를 가져옴
            authorizationStatus = locationManager.authorizationStatus
        }else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        //iOS 위치 서비스 활성화 여부 체크 locationServicesEnabled()
        if CLLocationManager.locationServicesEnabled() {
            //default = True
            //위치 서비스가 활성화 되어 있으므로, 위치 권한 요청 가능해서 위치 권한을 요청함
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다.")
        }
    }
    
    //사용자의 위치 권한 상태 확인
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        
        switch authorizationStatus {
        case .notDetermined:
            //처음 앱을 켰을때
            print("NOTDETERMINED")
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() //앱을 사용하는 동안에 대한 위치 권한 요청
            //plist에 WhenInUse에 먼저 등록이 돼야 request 메서드를 실행할 수 있다
            //없으면 앱이 꺼지게 된다.
            
            //허용을 눌렀을때
            locationManager.startUpdatingLocation()
            
        case .restricted, .denied:
            print("DENIED, 아이폰 설정으로 유도")
        case .authorizedWhenInUse:
            print("WHEN IN USE")
            //사용자가 위치를 허용해 둔 상태라면, startUpdatingLocation 메서드를  통해 아래 extension MapViewController: CLLocationManagerDelegate의 didUpdateLocations 메서드가 실행
            locationManager.startUpdatingLocation()
        default: print("DEFAULT")
            
        }
    }
    
    func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            
            //설정까지 이동하거나 설정 세부화면까지 이동하거나
            //한 번도 설정 앱에 들어가지 않았거나, 막 다운받은 앱이거나
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        
        present(requestLocationServiceAlert, animated: true, completion: nil)
    }
}
