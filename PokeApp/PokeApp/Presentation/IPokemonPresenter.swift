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
    
    func getPokemonImageAndBaseExperience(from urlString: String, cell: UICollectionViewCell)
    
}
