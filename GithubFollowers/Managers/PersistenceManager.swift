//
//  PersistenceManager.swift
//  GithubFollowers
//
//  Created by Jung Choi on 6/9/23.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    private static let defaults = UserDefaults.standard
    
    static func update(with favorite: Follower, actionType: PersistenceActionType, completion: @escaping (GFError?) -> Void) {
        retreiveFavorites { result in
            switch result {
            case .success(let favorites):
                var favorites = favorites
                
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completion(.repeatedFavorites)
                        return
                    }
                    favorites.append(favorite)
                    
                case .remove:
                    favorites.removeAll { $0.login == favorite.login }
                }
                
                completion(saveFavorites(favorites: favorites))
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    static func retreiveFavorites(completion: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.unableToRetreiveFavorites))
        }
    }
    
    static func saveFavorites(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let favoritesData = try encoder.encode(favorites)
            defaults.set(favoritesData, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToSaveFavorites
        }
    }
}
