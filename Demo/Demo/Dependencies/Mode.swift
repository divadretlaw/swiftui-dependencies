import Foundation
import Dependencies
import SwiftUI

enum Mode: Sendable {
    case live
    case demo
    
    var navigationBarVisibility: Visibility {
        switch self {
        case .live:
            return .automatic
        case .demo:
            return .visible
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .live:
            return .clear
        case .demo:
            return .accentColor.opacity(0.2)
        }
    }
}

private struct ModeKey: DependencyKey {
    static let defaultValue: Mode = .live
}

extension DependencyValues {
    var mode: Mode {
        get { self[ModeKey.self] }
        set { self[ModeKey.self] = newValue }
    }
}

struct DemoViewModifier: ViewModifier {
    @Dependency(\.mode) private var mode
    
    func body(content: Content) -> some View {
        content
            .toolbarBackground(mode.backgroundColor)
            .toolbarBackground(mode.navigationBarVisibility, for: .navigationBar)
            .safeAreaInset(edge: .top) {
                if mode == .demo {
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 10)
                }
            }
    }
}
