//
//  PokemonDescriptionPresenter.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/25/23.
//

import Foundation

class PokemonDescriptionPresenter: IPokemonDescriptionPresenter {
    
    var interactor: IPokemonDescriptionInteractor
    weak var view: PokemonDescriptionView?
    
    init(interactor: IPokemonDescriptionInteractor, view: PokemonDescriptionView) {
        self.interactor = interactor
        self.view = view
    }
    
}
