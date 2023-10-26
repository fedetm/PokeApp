//
//  IPokemonPresenter.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/2/23.
//

import Foundation
import UIKit

protocol IPokemonPresenter {
    
    func getPokemonsAndGenerations()
    
    func getPokemonImageAndBaseExperience(pokemonURL urlString: String, cell: PromotedPokemonCollectionViewCell)
    
    func getPokemonImageAndBaseExperience(specieURL urlString: String, cell: StandardAppCollectionViewCell)
    
    func showSelectedPokemon(_ pokemon: Pokemon, _ pokemonImage: UIImage)
    
}
