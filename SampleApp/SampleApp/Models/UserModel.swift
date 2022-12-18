// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let users = try? newJSONDecoder().decode(Users.self, from: jsonData)

import Foundation

// MARK: - Users
struct Users: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Item]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

// MARK: - Item
struct Item: Codable {
    let id: Int
    let login: String
    
    let avatarURL: String
    
    let type: String
    

    enum CodingKeys: String, CodingKey {
        case id
        
        case login
       
        case avatarURL = "avatar_url"

        case type = "type"
        
    }
}


#if DEBUG
// MARK: - Example Item
extension Item {
    
    static var example: Item {

        Item(
            id:222,    login: "anas", avatarURL: "example.com", type: "user"
        )
    }
}
#endif
