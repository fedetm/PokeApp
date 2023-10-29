//
//  PokemonDescriptionDataSource.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/28/23.
//

import Foundation

class PokemonDescriptionDataSource {
    
    var baseURL: URL
    
    init() {
        baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    }
    
    func getSprite(from url: URL, completion: @escaping (_ data: Data) -> Void) {
        Task.init {
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else { return }
                
                completion(data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
