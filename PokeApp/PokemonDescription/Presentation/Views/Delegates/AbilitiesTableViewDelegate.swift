//
//  AbilitiesTableViewDelegate.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 11/13/23.
//

import Foundation
import UIKit

class AbilitiesTableViewDelegate: NSObject, UITableViewDataSource {
    
    weak var view: PokemonDescriptionView!
    
    init(view: PokemonDescriptionView) {
        self.view = view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return view.pokemon.abilities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AbilityTableViewCell", for: indexPath) as! AbilityTableViewCell
        
        let pokemonAbility = view.pokemon.abilities[indexPath.row]
        
        if pokemonAbility.isHidden {
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.italicSystemFont(ofSize: 19.0)
            ]

            let attributedString = NSAttributedString(string: pokemonAbility.ability.name.capitalized, attributes: attributes)
            
            cell.nameLabel.attributedText = attributedString
            cell.nameLabel.textColor = .lightGray
        } else {
            cell.nameLabel.text = pokemonAbility.ability.name.capitalized
        }
        
        cell.hiddenLabel.isHidden = !pokemonAbility.isHidden
        
        return cell
    }
}
