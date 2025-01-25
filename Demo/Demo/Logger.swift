import Foundation
import OSLog

extension Logger {
    static let demo = Logger(subsystem: "at.davidwalter.swiftui-dependencies", category: "demo")
    
    func track(fileID: String = #fileID, function: StaticString = #function) {
        info("\(fileID.replacingOccurrences(of: ".swift", with: "")).\(function)")
    }
}
