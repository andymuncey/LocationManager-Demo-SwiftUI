import MapKit

class ReverseGeocoder {

    /**
     Historically we would use CLGeocoder, but as of iOS 26 we use MapKit
     */
    static func reverseGeocode(location: CLLocation) async -> String {
        if let request = MKReverseGeocodingRequest(location: location) {
            let mapitems = try? await request.mapItems
            if let mapitem = mapitems?.first {
                return mapitem.address?.fullAddress ?? "Place has no address"
            }
        }
        return "Place is not named"
    }
}


