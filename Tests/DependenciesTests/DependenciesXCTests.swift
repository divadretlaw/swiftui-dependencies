import XCTest
@testable import Dependencies

final class DependenciesXCTests: XCTestCase {
    func testContext() throws {
        XCTAssertEqual(DependencyContext.current, .testing)
    }

    func testKey() throws {
        var values = DependencyValues()
        XCTAssertEqual(values.test, TestDependencyKey.testingValue)
        values.test = 1
        XCTAssertEqual(values.test, 1)
    }

    func testOnlyDefaultValue() throws {
        struct TestOnlyDependencyKey: DependencyKey {
            static var defaultValue: Int { 0 }
        }

        XCTAssertEqual(TestOnlyDependencyKey.defaultValue, TestOnlyDependencyKey.previewValue)
        XCTAssertEqual(TestOnlyDependencyKey.defaultValue, TestOnlyDependencyKey.testingValue)
        XCTAssertEqual(TestOnlyDependencyKey.previewValue, TestOnlyDependencyKey.testingValue)
    }

    func testAllValues() throws {
        struct TestOnlyDependencyKey: DependencyKey {
            static var defaultValue: Int { 1 }
            static var previewValue: Int { 2 }
            static var testingValue: Int { 3 }
        }

        XCTAssertNotEqual(TestOnlyDependencyKey.defaultValue, TestOnlyDependencyKey.previewValue)
        XCTAssertNotEqual(TestOnlyDependencyKey.defaultValue, TestOnlyDependencyKey.testingValue)
        XCTAssertNotEqual(TestOnlyDependencyKey.previewValue, TestOnlyDependencyKey.testingValue)
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
