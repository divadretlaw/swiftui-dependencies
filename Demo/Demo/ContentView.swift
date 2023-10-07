import SwiftUI
import Dependencies

struct ContentView: View {
    @Environment(\.dependencyContext) private var context
    
    var body: some View {
        NavigationStack {
            List {
                LabeledContent("Context", value: context.description)
                
                Section {
                    NavigationLink {
                        ObserveableObjectView()
                    } label: {
                        Text("ObservableObject")
                    }
                    
                    NavigationLink {
                        CustomObserveableObjectView()
                    } label: {
                        Text("ObservableObject (custom init)")
                    }
                    
                    NavigationLink {
                        ObservationView()
                    } label: {
                        Text("Observation")
                    }
                    
                    NavigationLink {
                        SwiftUIView()
                    } label: {
                        Text("SwiftUI")
                    }
                }
            }
            .navigationTitle("Demo")
        }
    }
}

#Preview("Content View") {
    ContentView()
}

#Preview("Content View with overriden API") {
    ContentView()
        .dependency(\.api, AppAPI(session: .shared))
}
