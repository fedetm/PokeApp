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
        let serialQueue = DispatchQueue(label: "serialQueue")
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
        
        var firstPokemonGeneration: [BasicPokemon]!
        serialQueue.async { [weak self] in
            group.wait()
            group.enter()
            guard let self = self else { return }
            self.repository.getPokemonsByGeneration(id: 1) { pokemons in
                firstPokemonGeneration = pokemons
                group.leave()
            }
        }
        
        serialQueue.async { [weak self] in
            group.wait()
            group.enter()
            guard let self = self else { return }
            self.presenter.setPokemonsAndGenerations(basicPokemons, pokemonGenerations, firstPokemonGeneration)
            group.leave()
        }
    }
    
    func getPokemonImageAndBaseExperience(from urlString: String, completion: @escaping (_ pokemon: Pokemon, _ data: Data) -> Void) {
        let pokemonURL = URL(string: urlString)!
        self.repository.getPokemon(from: pokemonURL) { pokemon in
            let imageURL = URL(string: pokemon.sprites.other.officialArtwork.frontDefault)!
            self.repository.getPokemonImage(from: imageURL) { data in
                completion(pokemon, data)
            }
        }
    }
    
}
