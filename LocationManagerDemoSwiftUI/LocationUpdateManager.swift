/**
 This uses a newer approach, async instead of delegation
 No support for headings however
 **/

import CoreLocation

@Observable
@MainActor
final class LocationUpdateManager {
    
    var location: CLLocation?
    private(set) var isUpdating = false
    
    //track the tasks (types are task return type, and Failure type (Never means won't throw)
    private var updateTask: Task<Void, Never>?
    
    func start() {
        //don't start a task if already running
        guard updateTask == nil else {return}
        
        isUpdating = true
        
        let updates : CLLocationUpdate.Updates = CLLocationUpdate.liveUpdates()
        
        updateTask = Task {
            defer {
                //like finally, but after task ends
                updateTask = nil
                isUpdating = false
            }
            do {
                for try await update in updates {
                    location = update.location
                }
            } catch {
                //something has done wrong
            }
        }
    }
    
    func stop() {
        //cancel the task
        updateTask?.cancel()
        updateTask = nil
        
        isUpdating = false
        location = nil
    }
    
}

