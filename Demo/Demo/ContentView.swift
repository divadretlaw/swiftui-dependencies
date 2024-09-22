import SwiftUI
import Dependencies

struct ContentView: View {
    @Environment(\.dependencyContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Dependency(\.mode) private var mode
    
    @State private var showDemo = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    LabeledContent("Context", value: context.description)
                    
                    if mode != .demo {
                        Button {
                            showDemo = true
                        } label: {
                            Text("Demo")
                        }
                    }
                }
                
                Section {
                    NavigationLink {
                        ObserveableObjectView()
                    } label: {
                        Text("Default")
                    }
                    
                    NavigationLink {
                        CustomObserveableObjectView()
                    } label: {
                        Text("Custom init")
                    }
                } header: {
                    Text("ObservableObject")
                        .headerProminence(.increased)
                }
                 
                Section {
                    NavigationLink {
                        ObservationView()
                    } label: {
                        Text("Default")
                    }
                    
                    NavigationLink {
                        CustomObservationView()
                    } label: {
                        Text("Custom init")
                    }
                } header: {
                    Text("Observation")
                        .headerProminence(.increased)
                }
                
                Section {
                    NavigationLink {
                        SwiftUIView()
                    } label: {
                        Text("Default")
                    }
                } header: {
                    Text("SwiftUI")
                        .headerProminence(.increased)
                }
            }
            .listStyle(.insetGrouped)
            .fullScreenCover(isPresented: $showDemo) {
                ContentView()
                    .dependency(\.mode, .demo)
                    .dependency(\.api, DemoAPI())
            }
            .navigationTitle(mode == .demo ? "Demo" : "Dependencies")
            .modifier(DemoViewModifier())
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    if mode == .demo {
                        Button {
                            dismiss()
                        } label: {
                            Text("Close")
                        }
                    }
                }
            }
        }
    }
}

#Preview("Content View") {
    ContentView()
}

#Preview("Content View with overriden dependency") {
    ContentView()
        .dependency(\.api, AppAPI(session: .shared))
}
