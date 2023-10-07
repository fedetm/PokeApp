//
//  PokemonDataSource.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/2/23.
//

import Foundation

class PokemonDataSource {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    func getPokemons(completion: @escaping (_ response: PokemonResponse) -> Void) {
        let pokemonsURL = baseURL.appending(path: "pokemon/")
        
        Task.init {
            do {
                let (data, response) = try await URLSession.shared.data(from: pokemonsURL)
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else { return }
                
                let decoder = JSONDecoder()
                let pokemonRespone = try decoder.decode(PokemonResponse.self, from: data)
                
                completion(pokemonRespone)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getPokemon(with url: String, completion: @escaping (_ pokemon: Pokemon) -> Void) {
        let pokemonURL = URL(string: url)!
        Task.init {
            do {
                let (data, response) = try await URLSession.shared.data(from: pokemonURL)
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else { return }
                
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                
                completion(pokemon)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getPokemonType(by id: Int, completion: @escaping (_ pokemonType: PokemonType) -> Void) {
        let pokemonTypeURL = baseURL.appending(path: "type/\(id)")
        Task.init {
            do {
                let (data, response) = try await URLSession.shared.data(from: pokemonTypeURL)
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else { return }
                
                let decoder = JSONDecoder()
                let pokemonType = try decoder.decode(PokemonType.self, from: data)
                
                completion(pokemonType)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getGenerations(completion: @escaping (_ response: PokemonGenerationResponse) -> Void) {
        let pokemonsURL = baseURL.appending(path: "generation/")
        
        Task.init {
            do {
                let (data, response) = try await URLSession.shared.data(from: pokemonsURL)
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else { return }
                
                let decoder = JSONDecoder()
                let pokemonRespone = try decoder.decode(PokemonGenerationResponse.self, from: data)
                
                completion(pokemonRespone)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
