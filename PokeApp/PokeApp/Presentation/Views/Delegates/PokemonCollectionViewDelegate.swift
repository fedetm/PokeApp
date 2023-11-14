//
//  PokemonCollectionViewDelegate.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/25/23.
//

import Foundation
import UIKit

class PokemonCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    weak var view: PokemonView?
    
    init(view: PokemonView) {
        self.view = view
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let view = view else { return }
        let section = view.sections[indexPath.section]
        switch section {
        case .promoted:
            let cell = collectionView.cellForItem(at: indexPath) as! PromotedPokemonCollectionViewCell
            
            view.showSelectedPokemon(cell.pokemon, cell.pokemonImage)
        case .standard:
            let cell = collectionView.cellForItem(at: indexPath) as! StandardAppCollectionViewCell
            
            view.showSelectedPokemon(cell.pokemon, cell.pokemonImage)
            break
        case .categories:
            break
        }
    }
}
