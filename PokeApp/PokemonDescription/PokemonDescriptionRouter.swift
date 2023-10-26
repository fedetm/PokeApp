//
//  PokemonDescriptionRouter.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/25/23.
//

import Foundation
import UIKit

class PokemonDescriptionRouter {
    
    func showPokemonDescriptionView(currentView: PokemonView, pokemon: Pokemon, image: UIImage) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let view = storyboard.instantiateViewController(withIdentifier: "PokemonDescriptionView") as! PokemonDescriptionView
        
        let interactor = PokemonDescriptionInteractor()
        let presenter = PokemonDescriptionPresenter(interactor: interactor, view: view)
        
        view.presenter = presenter
        view.pokemon = pokemon
        view.pokemonImage = image
        
        currentView.navigationController?.pushViewController(view, animated: true)
    }
    
}
