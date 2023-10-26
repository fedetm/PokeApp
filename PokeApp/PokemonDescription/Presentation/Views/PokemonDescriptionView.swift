//
//  PokemonDescriptionView.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/25/23.
//

import UIKit

class PokemonDescriptionView: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var presenter: IPokemonDescriptionPresenter!
    
    var pokemon: Pokemon!
    var pokemonImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = pokemonImage
        nameLabel.text = pokemon.name
    }

}
