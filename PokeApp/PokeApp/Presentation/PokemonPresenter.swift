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
        interactor.getPokemonsAndGenerations()
    }
    
    func setPokemonsAndGenerations(_ pokemons: [BasicPokemon], _ generations: [BasicPokemonGeneration], _ firstPokemonGeneration: [BasicPokemon]) {
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
            firstPokemons.append(.pokemon(pokemon))
        }
        Item.firstPokemonGeneration = firstPokemons
        
        DispatchQueue.main .async { [weak self] in
            self!.view.collectionViewSetup()
        }
    }
    
    func getPokemonImageAndBaseExperience(from urlString: String, cell: UICollectionViewCell) {
        interactor.getPokemonImageAndBaseExperience(from: urlString) { pokemon, data in
            guard let image = UIImage(data: data) else { return }
            let cell = cell as! PromotedPokemonCollectionViewCell
            DispatchQueue.main .async {
                cell.configureCell(pokemon, image)
            }
        }
    }
    
}
