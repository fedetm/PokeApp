//
//  PokemonRouter.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/2/23.
//

import Foundation
import UIKit

class PokemonRouter {
    
    func initPokemonModule(view: PokemonView) {
        let interactor = PokemonInteractor()
        let presenter = PokemonPresenter(interactor: interactor, view: view)
        
        view.presenter = presenter
        interactor.presenter = presenter
    }
    
}
