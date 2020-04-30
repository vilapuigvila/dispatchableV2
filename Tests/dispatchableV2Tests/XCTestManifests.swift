import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(dispatchableV2Tests.allTests),
    ]
}
#endif
