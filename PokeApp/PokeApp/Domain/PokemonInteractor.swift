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
        
        var pokemonGenerations: [PokemonGeneration]!
        serialQueue.async { [weak self] in
            group.wait()
            group.enter()
            guard let self = self else { return }
            self.repository.getGenerations() { generations in
                pokemonGenerations = generations
                group.leave()
            }
        }
        
        serialQueue.async { [weak self] in
            group.wait()
            group.enter()
            guard let self = self else { return }
            self.presenter.setPokemonsAndGenerations(basicPokemons, pokemonGenerations)
            group.leave()
        }
    }
}
