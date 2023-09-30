import XCTest
@testable import Dependencies

final class DependenciesTests: XCTestCase {
    func testContext() throws {
        XCTAssertEqual(DependencyContext.current, .testing)
    }
    
    func testKey() throws {
        var values = DependencyValues()
        XCTAssertEqual(values.test, 0)
        values.test = 1
        XCTAssertEqual(values.test, 1)
    }
}

private struct TestDependencyKey: DependencyKey {
    static var defaultValue: Int { -1 }
    static var previewValue: Int { -1 }
    static var testingValue: Int { 0 }
}

extension DependencyValues {
    var test: Int {
        get { self[TestDependencyKey.self] }
        set { self[TestDependencyKey.self] = newValue }
    }
}
