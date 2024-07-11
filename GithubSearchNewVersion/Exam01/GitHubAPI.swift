//
//  GitHubAPI.swift
//  GithubSearchNewVersion
//
//  Created by psynet on 7/11/24.
//

import Foundation
import Moya

enum GitHubAPI {
    case searchRepositories(String)
}

extension GitHubAPI: TargetType {
    var baseURL: URL { URL(string: "https://api.github.com")! }
    
    var path: String {
        switch self {
        case .searchRepositories:
            return "/search/repositories"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchRepositories:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .searchRepositories(let query):
            return .requestParameters(parameters: ["q": query], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Accept": "application/vnd.github.v3+json"]
    }
}
