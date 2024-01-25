//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 21.01.2024.
//

import UIKit

// TODO: Ilk olarak MVVM Geçirmeden önce bu yapıyı daha generic bir şekilde kurmak lazım. MVC kullanılsa bile her network çağrısı için network manager içerisinde ayrı fonksiyon yazmak avellik.

enum GFNetworkError: String, Error {
    case invalidUsername = "This username created an invalid request please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}

final class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL: String = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()

    private init() {}

    // TODO: - BU MANAGER DAHA GENERİC HALE GELEBİLİR. RESULT KULLANILABİLİR. URL REQUEST HEADER AND CONTENT EKLE.
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GFNetworkError>) -> Void) {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            // TODO: - RESPONSE STATUS KONTROLU DAHA İYİ YAPILABİLİR.
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }

    func getUserInfo(for username: String, completion: @escaping (Result<User, GFNetworkError>) -> Void) {
        let endpoint = baseURL + "\(username)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }

    // TODO: Bu fonksiyonu kullanarak ilerde daha generic bir network manager yapılabilir.
    func execute<T: Codable>(with request: URLRequest, expecting type: T.Type, completion: @escaping (Result<T, GFNetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200
            else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
