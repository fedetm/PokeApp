//
//  PokemonView.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/2/23.
//

import UIKit

class PokemonView: UIViewController {
    
    var presenter: IPokemonPresenter!
    
    enum Section: Hashable {
        case promoted
        case standard(String)
        case categories
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initPokemonModule()
        presenter.getPokemonsAndGenerations()
    }
    
    func initPokemonModule() {
        let router = PokemonRouter()
        router.initPokemonModule(view: self)
    }
    
    // MARK: Collection View Setup
    func collectionViewSetup() {
        collectionView.collectionViewLayout = createLayout()
        
        collectionView.register(PromotedPokemonCollectionViewCell.self, forCellWithReuseIdentifier: PromotedPokemonCollectionViewCell.reuseIdentifier)
        
        configureDataSource()
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout
        { (sectionIndex, layoutEnvironment) ->
            NSCollectionLayoutSection? in
            let section = self.sections[sectionIndex]
            switch section {
            case .promoted:
                // MARK: Promoted Section Layout
                let itemSize =
                NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize =
                NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.92),
                    heightDimension: .estimated(300)
                )
                let group =
                NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            default:
                return nil
            }
        }
        return layout
    }
    
    func configureDataSource() {
        // MARK: Data Source Initialization
        dataSource = .init(collectionView: collectionView, cellProvider: {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            let section = self.sections[indexPath.section]
            switch section {
            case .promoted:
                let cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: PromotedPokemonCollectionViewCell.reuseIdentifier, for: indexPath) as! PromotedPokemonCollectionViewCell
                cell.configureCell(item.pokemon!)
                
                return cell
            default:
                fatalError("Not yet implemented.")
            }
        })
        // MARK: Snapshot Definition
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.promoted])
        snapshot.appendItems(Item.promotedPokemons, toSection: .promoted)
        sections = snapshot.sectionIdentifiers
        
        dataSource.apply(snapshot)
    }
    
}
