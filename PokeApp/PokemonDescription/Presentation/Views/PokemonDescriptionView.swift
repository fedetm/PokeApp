//
//  PokemonDescriptionView.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/25/23.
//

import UIKit

class PokemonDescriptionView: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spritesLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: IPokemonDescriptionPresenter!
    
    var activityIndicator: UIActivityIndicatorView!
    
    var pokemon: Pokemon!
    var pokemonImage: UIImage!
    var sprites: [UIImage]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = pokemon.name.capitalized
        imageView.image = pokemonImage
        configureActivityIndicator()
        presenter.getSprites(from: pokemon.sprites)
        configureTableView()
    }
    
    func configureActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        
        activityIndicator.center = collectionView.center
        
        view.addSubview(activityIndicator)
    }
    
    func configureTableView() {
        tableView.dataSource = self
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

extension PokemonDescriptionView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTypeTableViewCell", for: indexPath) as! TypeTableViewCell
        
        let pokemonType = pokemon.types[indexPath.row]
        cell.typeLabel.text = pokemonType.type.name.capitalized
        
        return cell
    }
    
}
