import Foundation

struct LoginResponse: Codable {
    var args: UserResponse
}

struct UserResponse: Codable {
    var name: String
}
