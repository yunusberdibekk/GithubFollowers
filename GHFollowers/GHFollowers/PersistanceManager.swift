//
//  PersistanceManager.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 28.01.2024.
//

import Foundation

// TODO: PERSISTANCE MANAGER İŞLEMLERİ CORE DATA İLE YAPILABİLİR.

enum PersistanceActionType {
    case add, remove
}

enum PersistanceManager {
    enum Keys {
        static let favorites = "favorites"
    }

    private static let defaults = UserDefaults.standard

    static func updateWith(favorite: Follower, actionType: PersistanceActionType, completion: @escaping (GFNetworkError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrivedFavorites = favorites
                switch actionType {
                case .add:
                    guard !retrivedFavorites.contains(favorite) else {
                        completion(.alreadyInFavorites)
                        return
                    }
                    retrivedFavorites.append(favorite)
                case .remove:
                    retrivedFavorites.removeAll(where: { $0.login == favorite.login })
                }
                completion(save(favorites: retrivedFavorites))
            case .failure(let error):
                completion(error)
            }
        }
    }

    static func retrieveFavorites(completion: @escaping (Result<[Follower], GFNetworkError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.unableToFavorites))
        }
    }

    static func save(favorites: [Follower]) -> GFNetworkError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.setValue(encodedFavorites, forKey: Keys.favorites)
        } catch {
            return .unableToFavorites
        }
        return nil
    }
}
