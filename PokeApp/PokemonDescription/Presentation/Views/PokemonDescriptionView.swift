//
//  PokemonDescriptionView.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/25/23.
//

import UIKit

class PokemonDescriptionView: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spritesLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: IPokemonDescriptionPresenter!
    
    var activityIndicator: UIActivityIndicatorView!
    
    var pokemon: Pokemon!
    var pokemonImage: UIImage!
    var sprites: [UIImage]!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureActivityIndicator()
        imageView.image = pokemonImage
        nameLabel.text = pokemon.name.capitalized
        presenter.getSprites(from: pokemon.sprites)
    }
    
    func configureActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        
        activityIndicator.center = view.center
        
        view.addSubview(activityIndicator)
    }

}

extension PokemonDescriptionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sprites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =
        collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonSpritesCollectionViewCell", for: indexPath) as! SpriteCollectionViewCell
        
        cell.imageView.image = sprites[indexPath.row]
        
        return cell
    }
    
}
