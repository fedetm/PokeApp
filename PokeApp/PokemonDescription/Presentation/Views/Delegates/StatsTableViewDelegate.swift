//
//  StatsTableViewDelegate.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 11/13/23.
//

import Foundation
import UIKit

class StatsTableViewDelegate: NSObject, UITableViewDataSource {
    
    weak var view: PokemonDescriptionView!
    
    init(view: PokemonDescriptionView) {
        self.view = view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return view.pokemon.stats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatTableViewCell", for: indexPath) as! StatTableViewCell
        
        let pokemonStat = view.pokemon.stats[indexPath.row]
        cell.nameLabel.text = pokemonStat.stat.name.capitalized
        
        cell.baseStatLabel.text = "Base stat: \(pokemonStat.baseStat)"
        
        return cell
    }
    
}
