//
//  MapViewController.swift
//  MediaProject
//
//  Created by Carki on 2022/08/15.
//
import CoreLocation
import MapKit
import UIKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
     
        checkUserDeviceLocationServiceAuthorization()
      
        let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
        
        setRegionAndAnnotation(center: center)
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        showRequestLocationServiceAlert()
//    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        mapView.setRegion(region, animated: true)
        
        let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "캠퍼스"
        
        mapView.addAnnotation(annotation)
    }
    

}

//위치관련 프로토콜 선언
extension MapViewController: CLLocationManagerDelegate {
    
    //사용자 위치를 성공적으로 가져온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //현재위치 받기
        if let location = locations.last?.coordinate {
//            var nowLatitude = location.coordinate.latitude
//            var nowLongitude = location.coordinate.longitude
//
//            let center = CLLocationCoordinate2D(latitude: nowLatitude, longitude: nowLongitude)

            setRegionAndAnnotation(center: location)
        } else {

        }
//
//        if let coordinate = locations.last?.coordinate {
//            setRegionAndAnnotation(center: coordinate)
//        }
        
        locationManager.stopUpdatingLocation()
        
    }
    
    //위치 가져오기 실패
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
        print("위치가져오기 오류")
    }
    
    //사용자의 권한상태 바뀔때 알려줌(iOS14+)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDeviceLocationServiceAuthorization()
    }
    
    //사용자의 권한상태 바뀔때 알려줌(iOS14-)
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}

//위치 관련된 user def메서드
extension MapViewController {
    
    //iOS버전에 따른 분기 처리 및 iOS 위치 서비스 활성화 여부 확인
    func checkUserDeviceLocationServiceAuthorization() {
        
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("사용자의 위치 서비스가 꺼져있습니다.")
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
