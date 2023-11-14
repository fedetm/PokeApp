//
//  PokemonPresenter.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/2/23.
//

import Foundation
import UIKit

class PokemonPresenter: IPokemonPresenter, IPokemonIntToPresenter {
    
    var interactor: IPokemonInteractor
    weak var view: PokemonView!
    
    init(interactor: IPokemonInteractor, view: PokemonView) {
        self.interactor = interactor
        self.view = view
    }
    
    func getPokemonsAndGenerations() {
        view.activityIndicator.startAnimating()
        interactor.getPokemonsAndGenerations()
    }
    
    func setPokemonsAndGenerations(_ pokemons: [BasicPokemon], _ generations: [BasicPokemonGeneration], _ firstPokemonGeneration: [PokemonSpecieResponse], _ secondPokemonGeneration: [PokemonSpecieResponse]) {
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
        
        var firstPokemons = [Item]()
        for pokemon in firstPokemonGeneration {
            firstPokemons.append(.firstPokemonGeneration(pokemon))
        }
        Item.firstPokemonGeneration = firstPokemons
        
        var secondPokemons = [Item]()
        for pokemon in secondPokemonGeneration {
            secondPokemons.append(.secondPokemonGeneration(pokemon))
        }
        Item.secondPokemonGeneration = secondPokemons
        
        DispatchQueue.main .async { [weak self] in
            guard let self = self else { return }
            self.view.collectionViewSetup()
            self.view.activityIndicator.stopAnimating()
        }
    }
    
    func getPokemonImageAndBaseExperience(pokemonURL urlString: String, cell: PromotedPokemonCollectionViewCell) {
        interactor.getPokemonImageAndBaseExperience(pokemonURL: urlString) { pokemon, data in
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                cell.configureCell(pokemon, image)
            }
        }
    }
    
    func getPokemonImageAndBaseExperience(specieURL urlString: String, cell: StandardAppCollectionViewCell) {
        interactor.getPokemonImageAndBaseExperience(specieURL: urlString) { pokemon, data in
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                cell.configureCell(pokemon, image)
            }
        }
    }
    
    func showSelectedPokemon(_ pokemon: Pokemon, _ pokemonImage: UIImage) {
        let router = PokemonDescriptionRouter()
        router.showPokemonDescriptionView(currentView: self.view, pokemon: pokemon, image: pokemonImage)
    }
    
}
