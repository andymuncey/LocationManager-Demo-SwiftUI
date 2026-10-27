import SwiftUI

@Observable
@MainActor
final class LocationManager : NSObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    private(set) var location: CLLocation?
    private(set) var heading: CLHeading?
    
    override init(){
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
    }
    
    func start(){
        manager.startUpdatingLocation()
        manager.startUpdatingHeading()
    }
    
    func stop(){
        manager.stopUpdatingLocation()
        manager.stopUpdatingHeading()
        
        heading = nil
        location = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        heading = newHeading
    }
    
    
}

