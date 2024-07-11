//
//  Models.swift
//  GithubSearchNewVersion
//
//  Created by psynet on 7/11/24.
//

import Foundation

struct Repository: Identifiable, Equatable, Codable {
    let id: Int
    let name: String
    let fullName: String
    let description: String?
    let stargazersCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case fullName = "full_name"
        case description
        case stargazersCount = "stargazers_count"
    }
}

struct SearchResponse: Codable {
    let items: [Repository]
}
