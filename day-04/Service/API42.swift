//
//  API42.swift
//  FindPeer
//
//  Created by Anton Ivanov on 30.07.2022.
//

import Foundation

// MARK: - Minecraft, причем полный
let uid = ""
let secret = ""
var accessToken = ""
var	code = ""

enum ApiType {

	case v2Me
	case v2Users(String)
	case oauthTokenInfo
	case oauthToken

	var baseURL: String {
		return "https://api.intra.42.fr/"
	}

	var path: String {
		switch self {
		case .v2Me:
			return "v2/me"
		case .v2Users(let login):
			return "v2/users/\(login)"
		case .oauthTokenInfo:
			return "oauth/token/info"
		case .oauthToken:
			return "oauth/token"
		}
	}

	var headers: [String : String] {
		switch self {
		case .oauthToken:
			return [ : ]
		default:
			return ["Authorization" : "Bearer \(accessToken)"]
		}
	}

	var parametrs: String {
		switch self {
		case .oauthToken:
			return "?grant_type=client_credentials&client_id=\(uid)&client_secret=\(secret)"
		default:
			return ""
		}
	}

	var request: URLRequest? {
		let baseURL = URL(string: baseURL)

		guard let url = URL(string: path + parametrs, relativeTo: baseURL) else {
			print("Invalid URL")
			return nil
		}
		
		var request = URLRequest(url: url)
		request.allHTTPHeaderFields = headers

		switch self {
		case .v2Me:
			request.httpMethod = "GET"
		case .v2Users:
			request.httpMethod = "GET"
		case .oauthTokenInfo:
			request.httpMethod = "GET"
		case .oauthToken:
			request.httpMethod = "POST"
		}

		return request
	}

}

class ApiManager {

	static let shared = ApiManager()

//	private func createTask<T>(with request: URLRequest, _ self: T) -> (T?) {
//		URLSession.shared.dataTask(with: request) { data, response, error in
//			if let error = error {
//				print(error)
//				completion(nil)
//			}
//
//			guard let data = data else {
//				print("No data available")
//				completion(nil)
//				return
//			}
//
//			if let self = try? JSONDecoder().decode(self.self, from: data) {
//				completion(self)
//			} else {
//				print("Failed to decode")
//				completion(nil)
//			}
//		}.resume()
//	}

	func getMe(completion: @escaping (User?) -> Void) {
		guard let request = ApiType.v2Me.request else {
			completion(nil)
			return
		}

		URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				print(error)
				completion(nil)
			}

			guard let data = data else {
				print("No data available")
				completion(nil)
				return
			}

			if let user = try? JSONDecoder().decode(User.self, from: data) {
				completion(user)
			} else {
				print(data, String(data: data, encoding: .utf8) ?? "*unknown encoding*")
				completion(nil)
			}

		}.resume()
	}

	func getUser(login: String, completion: @escaping (UserAll?) -> Void) {
		guard let request = ApiType.v2Users(login).request else {
			completion(nil)
			return
		}

		URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				print(error)
				completion(nil)
			}

			guard let data = data else {
				print("No data available")
				completion(nil)
				return
			}

			if let userAll = try? JSONDecoder().decode(UserAll.self, from: data) {
				completion(userAll)
			} else {
				print(data, String(data: data, encoding: .utf8) ?? "*unknown encoding*")
				completion(nil)
			}
		}.resume()
	}


	func getTokenInfo(completion: @escaping (TokenInfo?) -> Void) {
		guard let request = ApiType.oauthTokenInfo.request else {
			completion(nil)
			return
		}

		URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				print(error)
				completion(nil)
			}

			guard let data = data else {
				print("No data available")
				completion(nil)
				return
			}

			if let tokenInfo = try? JSONDecoder().decode(TokenInfo.self, from: data) {
				completion(tokenInfo)
			} else {
				print("Failed to decode")
				completion(nil)
			}
		}.resume()
	}

	func getToken(completion: @escaping (Token?) -> Void) {
		guard let request = ApiType.oauthToken.request else {
			completion(nil)
			return
		}

		URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				print(error)
				completion(nil)
			}

			guard let data = data else {
				print("No data available")
				completion(nil)
				return
			}

			if let token = try? JSONDecoder().decode(Token.self, from: data) {
				completion(token)
			} else {
				print("Failed to decode")
				completion(nil)
			}
		}.resume()
	}
}
