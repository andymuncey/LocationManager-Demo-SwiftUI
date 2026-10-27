
import CoreLocation
import MapKit

class ReverseGeocoder {
    
    var address: String? = nil
    
    /**
     Historically we would use CLGeocoider, but now we use MapKit
     */
    func reverseGeocode(location: CLLocation) async {
        if let request = MKReverseGeocodingRequest(location: location) {
            let mapitems = try? await request.mapItems
            if let mapitem = mapitems?.first {
                address = mapitem.address?.fullAddress
            }
        }
    }
}


