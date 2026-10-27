import SwiftUI

struct ContentView: View {
    
    let model = LocationViewModel()
    @State var updatingLocation = false
    
    var body: some View {
        VStack {
            
            Text("Start/Stop updates").font(.headline)
            Button(updatingLocation ? "Stop" : "Start"){
                if (updatingLocation){
                    model.stop()
                } else {
                    model.start()
                }
                updatingLocation.toggle()
            }
                   
            Spacer()
            Text("CLLocation attributes").font(.headline)
            LabelledValue(model.latitude, label: "Latitude")
            LabelledValue(model.longitude, label: "Longitude")
            LabelledValue(model.accuracy, label: "Accuracy")
            LabelledValue(model.course, label: "Course")
            LabelledValue(model.speed, label: "Speed")
            LabelledValue(model.altitude, label: "Altitude")
            
            Spacer()
            Text("CLHeading attributes").font(.headline)
            Text("Requires physical device").font(.subheadline)
            LabelledValue(model.heading, label: "Heading")
            Spacer()
            
            Text("Address").font(.headline)
            Button("Lookup address"){
                model.updateAddress()
            }
            Text(model.address ?? "")
            Text("\(model.distanceFromChester) from Chester")
        }
        .padding()
    }
}

/**
 Simple View for presenting a value with a label to the left of it
 */
struct LabelledValue: View {
    
    init(_ value: String, label: String) {
        self.label = label
        self.value = value
    }
    
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .frame(width: 100, alignment: .leading)
            Text(value)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    ContentView()
}
