# SwiftUI Dependencies

SwiftUI-Environment based dependency injection

## Usage

First you create your dependencies, by creating `DependencyKey`s for them and adding them to `DependencyValues`, similar to declaring SwiftUI-Environment values.
But additionally to a `defaultValue`, you also provide a `previewValue` (automatically used in SwiftUI Previews) and `testingValue` (automatically used in Unit-Tests).
 
After you can access the dependencies in ViewModels and Views.
 
### Setup

```swift
private struct MyDependencyKey: DependencyKey {
    static var defaultValue: String {
        "Default"
    }
    
    static var previewValue: String {
        "Preview"
    }
    
    static var testingValue: String {
        "Testing"
    }
}

extension DependencyValues {
    var myDependency: String {
        get { self[MyDependencyKey.self] }
        set { self[MyDependencyKey.self] = newValue }
    }
}
```

You can always provide a custom value for views. The value will be propagated through the view hiearachy.

```swift
ContentView()
    .dependency(\.myDependency, "New Value")
```

### Usage in a `ObservableObject`

Instead of conforming to `ObservableObject` the view model should conform to `ObservableDependencyObject`. The `DependencyValues` of the current context will be provided in the required initializer.

```swift
final class ViewModel: ObservableDependencyObject {
    required init(dependencies: DependencyValues) {
        // Access the dependencies needed for this ViewModel
    }
}

struct ContentView: View {
    @DependencyObject private var viewModel: ViewModel
    
    var body: some View {
        ...
    }
}
```

In case you need a custom initializer for the view model, you can initialize the view model with dependencies like this:

```swift
final class ViewModel: ObservableDependencyObject {
    let customProperty: String
    
    required init(customProperty: String, dependencies: DependencyValues) {
        self.customProperty = customProperty
        // Access the dependencies needed for this ViewModel
    }
}

struct ContentView: View {
    @DependencyObject private var viewModel: ViewModel
    
    init() {
        _viewModel = DependencyObject { dependencies in
            ViewModel(customProperty: "Custom", dependencies: dependencies)
        }
    }
    
    var body: some View {
        ...
    }
}
```

### Usage with `Obervable`

The model should conform to `ObservableDependency` and instead of annotating your model with `State` in the view, the model should be annotated with `DependencyState`. The `DependencyValues` of the current context will be provided in the required initializer.

```swift
@Observable
final class Model: ObservableDependency {
    required init(dependencies: DependencyValues) {
        // Access the dependencies needed for this ViewModel
    }
}

struct ContentView: View {
    @DependencyState private var model: Model
    
    var body: some View {
        ...
    }
}
```

### Usage in a View

You can access dependencies directly in views by using the `Dependency` annotation.

```swift
struct ContentView: View {
    @Dependency(\.myDependency) private var myDependency
    
    var body: some View {
        Text(myDependency)
    }
}
```

### Demo

See the [demo project](Demo/Demo.xcodeproj) for some example implementations

## License

See [LICENSE](LICENSE)
