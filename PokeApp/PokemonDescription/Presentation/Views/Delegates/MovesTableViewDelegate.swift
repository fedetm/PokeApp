//
//  MovesTableViewDelegate.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 11/13/23.
//

import Foundation
import UIKit

class MovesTableViewDelegate: NSObject, UITableViewDataSource {
    
    weak var view: PokemonDescriptionView!
    
    init(view: PokemonDescriptionView) {
        self.view = view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return view.pokemon.moves.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoveTableViewCell", for: indexPath) as! MoveTableViewCell
        
        let pokemonMove = view.pokemon.moves[indexPath.row]
        cell.nameLabel.text = pokemonMove.move.name.capitalized
        
        return cell
    }
    
}
