//
//  TypesTableViewDelegate.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 11/13/23.
//

import Foundation
import UIKit

class TypesTableViewDelegate: NSObject, UITableViewDataSource {
    
    weak var view: PokemonDescriptionView!
    
    init(view: PokemonDescriptionView) {
        self.view = view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return view.pokemon.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TypeTableViewCell", for: indexPath) as! TypeTableViewCell
        
        let pokemonType = view.pokemon.types[indexPath.row]
        cell.nameLabel.text = pokemonType.type.name.capitalized
        
        return cell
    }
    
}
