//
//  PokemonDescriptionView.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/25/23.
//

import UIKit

class PokemonDescriptionView: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var typesTableView: UITableView!
    @IBOutlet weak var movesTableView: UITableView!
    @IBOutlet weak var abilitiesTableView: UITableView!
    @IBOutlet weak var statsTableView: UITableView!
    
    var presenter: IPokemonDescriptionPresenter!
    
    var typesTableViewDelegate: TypesTableViewDelegate!
    var movesTableViewDelegate: MovesTableViewDelegate!
    var abilitiesTableViewDelegate: AbilitiesTableViewDelegate!
    var statsTableViewDelegate: StatsTableViewDelegate!
    
    var activityIndicator: UIActivityIndicatorView!
    
    var pokemon: Pokemon!
    var pokemonImage: UIImage!
    var sprites: [UIImage]!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = pokemon.name.capitalized
        imageView.image = pokemonImage
        configureActivityIndicator()
        presenter.getSprites(from: pokemon.sprites)
        configureTypesTableView()
        configureMovesTableView()
        configureAbilitiesTableView()
        configureStatsTableView()
    }
    
    func configureStatsTableView() {
        statsTableViewDelegate = StatsTableViewDelegate(view: self)
        statsTableView.dataSource = statsTableViewDelegate
    }
    
    func configureAbilitiesTableView() {
        abilitiesTableViewDelegate = AbilitiesTableViewDelegate(view: self)
        abilitiesTableView.dataSource = abilitiesTableViewDelegate
    }
    
    func configureMovesTableView() {
        movesTableViewDelegate = MovesTableViewDelegate(view: self)
        movesTableView.dataSource = movesTableViewDelegate
    }
    
    func configureTypesTableView() {
        typesTableViewDelegate = TypesTableViewDelegate(view: self)
        typesTableView.dataSource = typesTableViewDelegate
    }
    
    func configureActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        
        activityIndicator.center = collectionView.center
        
        view.addSubview(activityIndicator)
    }
    
    func updateCollectionViewHeight() {
        collectionViewHeightConstraint.constant = collectionView.collectionViewLayout.collectionViewContentSize.height * 2
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
