//
//  PokemonInteractor.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/2/23.
//

import Foundation

class PokemonInteractor: IPokemonInteractor {
    
    var repository: IPokemonRepository
    weak var presenter: IPokemonIntToPresenter!
    
    init() {
        self.repository = PokemonRepository()
    }
    
    func getPokemonsAndGenerations() {
        let serialQueue = DispatchQueue(label: "serialQueuePromoted")
        let group = DispatchGroup()
        
        var basicPokemons: [BasicPokemon]!
        group.enter()
        serialQueue.async { [weak self] in
            guard let self = self else { return }
            self.repository.getPokemons() { pokemons in
                basicPokemons = pokemons
                group.leave()
            }
        }
        
        var pokemonGenerations: [BasicPokemonGeneration]!
        serialQueue.async { [weak self] in
            group.wait()
            group.enter()
            guard let self = self else { return }
            self.repository.getGenerations() { generations in
                pokemonGenerations = generations
                group.leave()
            }
        }
        
        var firstPokemonGeneration: [PokemonSpecieResponse]!
        serialQueue.async { [weak self] in
            group.wait()
            group.enter()
            guard let self = self else { return }
            self.repository.getPokemonsByGeneration(id: 1) { pokemons in
                firstPokemonGeneration = pokemons
                group.leave()
            }
        }
        
        var secondPokemonGeneration: [PokemonSpecieResponse]!
        serialQueue.async { [weak self] in
            group.wait()
            group.enter()
            guard let self = self else { return }
            self.repository.getPokemonsByGeneration(id: 2) { pokemons in
                secondPokemonGeneration = pokemons
                group.leave()
            }
        }
        
        serialQueue.async { [weak self] in
            group.wait()
            group.enter()
            guard let self = self else { return }
            self.presenter.setPokemonsAndGenerations(basicPokemons, pokemonGenerations, firstPokemonGeneration, secondPokemonGeneration)
            group.leave()
        }
    }
    
    func getPokemonImageAndBaseExperience(pokemonURL urlString: String, completion: @escaping (_ pokemon: Pokemon, _ data: Data) -> Void) {
        let pokemonURL = URL(string: urlString)!
        self.repository.getPokemon(from: pokemonURL) { pokemon in
            let imageURL = URL(string: pokemon.sprites.other.officialArtwork.frontDefault)!
            self.repository.getPokemonImage(from: imageURL) { data in
                completion(pokemon, data)
            }
        }
    }
    
    func getPokemonImageAndBaseExperience(specieURL urlString: String, completion: @escaping (_ pokemon: Pokemon, _ data: Data) -> Void) {
        
        let serialQueue = DispatchQueue(label: "serialQueueStandard")
        let group = DispatchGroup()
        
        var pokemonSpecie: PokemonSpecie!
        group.enter()
        serialQueue.async { [weak self] in
            guard let self = self else { return }
            let specieURL = URL(string: urlString)!
            self.repository.getPokemonSpecie(from: specieURL) { specie in
                pokemonSpecie = specie
                group.leave()
            }
        }
        
        var pokemon: Pokemon!
        serialQueue.async { [weak self] in
            group.wait()
            group.enter()
            guard let self = self else { return }
            let pokemonURL = URL(string: pokemonSpecie.varieties[0].pokemon.url)!
            self.repository.getPokemon(from: pokemonURL) { poke in
                pokemon = poke
                group.leave()
            }
        }
        
        serialQueue.async { [weak self] in
            group.wait()
            group.enter()
            guard let self = self else { return }
            let imageURL = URL(string: pokemon.sprites.other.officialArtwork.frontDefault)!
            self.repository.getPokemonImage(from: imageURL) { data in
                completion(pokemon, data)
                group.leave()
            }
        }
    }
    
    func getSelectedPokemon(pokemonURL urlString: String, completion: @escaping (_ pokemon: Pokemon, _ data: Data) -> Void) {
        let pokemonURL = URL(string: urlString)!
        self.repository.getPokemon(from: pokemonURL) { pokemon in
            let imageURL = URL(string: pokemon.sprites.other.officialArtwork.frontDefault)!
            self.repository.getPokemonImage(from: imageURL) { data in
                completion(pokemon, data)
            }
        }
    }
    
}
