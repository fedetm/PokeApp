//
//  PokemonDataSource.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/2/23.
//

import Foundation

class PokemonDataSource {
    
    var baseURL: URL
    
    init() {
        baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    }
    
    func getPokemons(completion: @escaping (_ response: BasicPokemonResponse) -> Void) {
        let pokemonsURL = baseURL.appending(path: "pokemon/")
        
        Task.init {
            do {
                let (data, response) = try await URLSession.shared.data(from: pokemonsURL)
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else { return }
                
                let decoder = JSONDecoder()
                let pokemonRespone = try decoder.decode(BasicPokemonResponse.self, from: data)
                
                completion(pokemonRespone)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getPokemon(from url: URL, completion: @escaping (_ pokemon: Pokemon) -> Void) {
        Task.init {
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                
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
    
    func getGenerations(completion: @escaping (_ response: BasicPokemonGenerationResponse) -> Void) {
        let pokemonsURL = baseURL.appending(path: "generation/")
        
        Task.init {
            do {
                let (data, response) = try await URLSession.shared.data(from: pokemonsURL)
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else { return }
                
                let decoder = JSONDecoder()
                let pokemonRespone = try decoder.decode(BasicPokemonGenerationResponse.self, from: data)
                
                completion(pokemonRespone)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getPokemonsByGeneration(id: Int, completion: @escaping (_ pokemonsByGeneration: PokemonsByGenerationResponse) -> Void) {
        let pokemonTypeURL = baseURL.appending(path: "generation/\(id)")
        Task.init {
            do {
                let (data, response) = try await URLSession.shared.data(from: pokemonTypeURL)
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else { return }
                
                let decoder = JSONDecoder()
                let pokemonsByGeneration = try decoder.decode(PokemonsByGenerationResponse.self, from: data)
                
                completion(pokemonsByGeneration)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getPokemonImage(from url: URL, completion: @escaping (_ data: Data) -> Void) {
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
    
    func getPokemonSpecie(from url: URL, completion: @escaping (_ specie: PokemonSpecie) -> Void) {
        Task.init {
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else { return }
                
                let decoder = JSONDecoder()
                let specie = try decoder.decode(PokemonSpecie.self, from: data)
                
                completion(specie)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
