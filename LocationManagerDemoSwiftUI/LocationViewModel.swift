import SwiftUI

@Observable class LocationViewModel {
    
    private let manager = LocationManager()
    private let reverseGeocoder = ReverseGeocoder()
    
    private(set) var address: String? = nil
    
    func updateAddress(){
        Task{
            address = "Finding address"
            guard let location = manager.location else { address = "No location found"
            return}
            address = await ReverseGeocoder.reverseGeocode(location: location)
        }
    }
    
    var latitude: String {
        format(manager.location?.coordinate.latitude, places: 4)
    }
    
    var longitude: String {
        format(manager.location?.coordinate.longitude, places: 4)
    }
    
    var course: String {
        format(manager.location?.course, places: 0, unit: "°")
    }
    
    var accuracy: String {
        format(manager.location?.horizontalAccuracy, places: 0, unit: "m")
    }
    
    var heading: String {
        format(manager.heading?.trueHeading, places: 0, unit: "°")
    }
    
    var distanceFromChester: String {
        guard let location = manager.location else {
            return ""
        }
        let chesterLocation = CLLocation(latitude: 53.2, longitude: -2.9)
        let distanceFromUoC = location.distance(from: chesterLocation)
        return format(distanceFromUoC, places: 0, unit: "m")
    }
    
    var altitude: String {
        guard let altitude = manager.location?.altitude else {return "N/A"}
        guard let accuracy = manager.location?.verticalAccuracy else {return "N/A"}
        return String(format: "%.0fm ± %.0fm", altitude, abs(accuracy))
    }
    
    var speed: String {
        guard let speed = manager.location?.speed else { return "N/A" }
        let mph = abs(speed) * 2.237
        return format(mph, places: 0, unit: " mph")
    }
    
    private func format(_ value: Double?, places: Int, unit: String = "") -> String {
        guard let value else { return "N/A" }
        let formatString = "%.\(places)f\(unit)"
        return String(format: formatString, value, unit)
    }
    
    func start(){
        manager.start()
    }
    
    func stop(){
        manager.stop()
    }
    

    
    
}
