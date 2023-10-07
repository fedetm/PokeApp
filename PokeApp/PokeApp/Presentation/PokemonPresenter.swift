//
//  PokemonPresenter.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/2/23.
//

import Foundation

class PokemonPresenter: IPokemonPresenter, IPokemonIntToPresenter {
    
    var interactor: IPokemonInteractor
    weak var view: PokemonView!
    
    init(interactor: IPokemonInteractor, view: PokemonView) {
        self.interactor = interactor
        self.view = view
    }
    
    func getPokemonsAndGenerations() {
        interactor.getPokemonsAndGenerations()
    }
    
    func setPokemonsAndGenerations(_ pokemons: [BasicPokemon], _ generations: [PokemonGeneration]) {
        var basicPokemons = [Item]()
        for pokemon in pokemons {
            basicPokemons.append(.pokemon(pokemon))
        }
        Item.promotedPokemons = basicPokemons
        
        var pokemonGenerations = [Item]()
        for generation in generations {
            pokemonGenerations.append(.generation(generation))
        }
        Item.generations = pokemonGenerations
        
        DispatchQueue.main .async { [weak self] in
            self!.view.collectionViewSetup()
        }
    }
    
}
