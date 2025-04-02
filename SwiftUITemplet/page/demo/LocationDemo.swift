import SwiftUI
import CoreLocation

/// 定位地图
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var city: String = ""
    @Published var address: String = ""
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10 // 10米更新一次
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        
        // 获取城市信息
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                DispatchQueue.main.async {
                    // 城市
                    if let city = placemark.locality {
                        self.city = city
                    }
                    
                    // 详细地址
                    var addressComponents: [String] = []
                    if let country = placemark.country {
                        addressComponents.append(country)
                    }
                    if let administrativeArea = placemark.administrativeArea {
                        addressComponents.append(administrativeArea)
                    }
                    if let locality = placemark.locality {
                        addressComponents.append(locality)
                    }
                    if let subLocality = placemark.subLocality {
                        addressComponents.append(subLocality)
                    }
                    if let thoroughfare = placemark.thoroughfare {
                        addressComponents.append(thoroughfare)
                    }
                    
                    self.address = addressComponents.joined(separator: " ")
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
}


struct LocationDemo: View {
    @StateObject private var locationManager = LocationManager()
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            // 状态显示
            Group {
                switch locationManager.authorizationStatus {
                case .notDetermined:
                    Text("请允许访问位置信息")
                        .foregroundColor(.orange)
                case .restricted, .denied:
                    Text("请在设置中允许访问位置信息")
                        .foregroundColor(.red)
                case .authorizedWhenInUse, .authorizedAlways:
                    Text("已获得位置权限")
                        .foregroundColor(.green)
                @unknown default:
                    Text("未知状态")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            // 位置信息显示
            if let location = locationManager.location {
                VStack(alignment: .leading, spacing: 10) {
                    Text("纬度: \(location.coordinate.latitude)")
                    Text("经度: \(location.coordinate.longitude)")
                    Text("海拔: \(location.altitude)米")
                    Text("速度: \(location.speed)米/秒")
                    Text("方向: \(location.course)°")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
            
            // 城市信息
            if !locationManager.city.isEmpty {
                VStack(alignment: .leading, spacing: 10) {
                    Text("城市: \(locationManager.city)")
                    Text("地址: \(locationManager.address)")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
            
            // 定位按钮
            Button(action: {
                locationManager.requestLocation()
            }) {
                Text("开始定位")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle("位置信息")
        .alert("提示", isPresented: $showAlert) {
            Button("确定", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
        .onAppear {
            locationManager.requestLocation()
            DDLog([locationManager.authorizationStatus.rawValue].asMap())
        }
    }
} 


#Preview {
    LocationDemo()
}
