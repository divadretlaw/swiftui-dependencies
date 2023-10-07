import XCTest
@testable import Dependencies

final class PropertyListTests: XCTestCase {
    func testEmpty() throws {
        let list = PropertyList()
        XCTAssertTrue(list.isEmpty)
        XCTAssertEqual(list.description, "[]")
    }
    
    func testAdd() throws {
        var list = PropertyList()
        XCTAssertTrue(list.isEmpty)
        list[TestDependencyKey.self] = "Test"
        XCTAssertFalse(list.isEmpty)
        XCTAssertEqual(list[TestDependencyKey.self], "Test")
        XCTAssertEqual(list.description, "[TestDependencyKey = Test]")
    }
}

private struct TestDependencyKey: DependencyKey {
    static var defaultValue: String { "default" }
    static var previewValue: String { "preview" }
    static var testingValue: String { "testing" }
}
