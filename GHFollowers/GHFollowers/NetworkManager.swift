//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 21.01.2024.
//

import UIKit

enum GFNetworkError: String, Error {
    case invalidUsername = "This username created an invalid request please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorites = "There was a error favoriting this user. Plsease try again."
    case alreadyInFavorites = "You've already favorited this user You must REALLY like them!."
}

final class NetworkManager {
    static let shared = NetworkManager()

    private let baseURL: String = "https://api.github.com/users/"
    private let cache = NSCache<NSString, UIImage>()

    private init() {}

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
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data else {
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
            guard let data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }

    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        guard let url = URL(string: urlString) else { completion(nil); return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self else {
                completion(nil)
                return
            }
            if error != nil {
                completion(nil)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil)
                return
            }
            guard let data else {
                completion(nil)
                return
            }
            guard let image = UIImage(data: data) else { completion(nil); return }
            cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
}
