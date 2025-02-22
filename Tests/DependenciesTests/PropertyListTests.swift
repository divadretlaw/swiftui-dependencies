import Testing
@testable import Dependencies

struct PropertyListTests {
    @Test
    func empty() {
        let list = PropertyList()
        #expect(list.isEmpty)
        #expect(list.description == "[]")
    }
    
    @Test
    func add() throws {
        var list = PropertyList()
        #expect(list.isEmpty)
        list[TestDependencyKey.self] = "Test"
        #expect(!list.isEmpty)
        #expect(list[TestDependencyKey.self] == "Test")
        #expect(list.description == "[TestDependencyKey = Test]")
    }
}

private struct TestDependencyKey: DependencyKey {
    static var defaultValue: String { "default" }
    static var previewValue: String { "preview" }
    static var testingValue: String { "testing" }
}
