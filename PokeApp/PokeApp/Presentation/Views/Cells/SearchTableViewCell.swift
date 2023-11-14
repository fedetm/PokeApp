//
//  SearchTableViewCell.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 11/14/23.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: BasicPokemon! {
        didSet {
            nameLabel.text = pokemon.name.capitalized
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
