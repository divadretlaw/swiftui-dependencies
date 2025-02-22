import Testing
@testable import Dependencies

struct DependenciesTests {
    @Test
    func context() throws {
        #expect(DependencyContext.current == .testing)
    }
    
    @Test
    func key() throws {
        var values = DependencyValues()
        #expect(values.test == TestDependencyKey.testingValue)
        values.test = 1
        #expect(values.test == 1)
    }
    
    @Test
    func onlyDefaultValue() throws {
        struct TestOnlyDependencyKey: DependencyKey {
            static var defaultValue: Int { 0 }
        }
        
        #expect(TestOnlyDependencyKey.defaultValue == TestOnlyDependencyKey.previewValue)
        #expect(TestOnlyDependencyKey.defaultValue == TestOnlyDependencyKey.testingValue)
        #expect(TestOnlyDependencyKey.previewValue == TestOnlyDependencyKey.testingValue)
    }
    
    @Test
    func allValues() throws {
        struct TestOnlyDependencyKey: DependencyKey {
            static var defaultValue: Int { 1 }
            static var previewValue: Int { 2 }
            static var testingValue: Int { 3 }
        }
        
        #expect(TestOnlyDependencyKey.defaultValue != TestOnlyDependencyKey.previewValue)
        #expect(TestOnlyDependencyKey.defaultValue != TestOnlyDependencyKey.testingValue)
        #expect(TestOnlyDependencyKey.previewValue != TestOnlyDependencyKey.testingValue)
    }
}

private struct TestDependencyKey: DependencyKey {
    static var defaultValue: Int { -1 }
    static var previewValue: Int { -1 }
    static var testingValue: Int { 0 }
}

private extension DependencyValues {
    var test: Int {
        get { self[TestDependencyKey.self] }
        set { self[TestDependencyKey.self] = newValue }
    }
}
