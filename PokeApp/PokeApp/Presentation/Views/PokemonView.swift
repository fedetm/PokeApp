//
//  PokemonView.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/2/23.
//

import UIKit

class PokemonView: UIViewController {
    
    var presenter: IPokemonPresenter!
    
    // MARK: Section Definitions
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
        
        collectionView.register(StandardAppCollectionViewCell.self,
           forCellWithReuseIdentifier:
           StandardAppCollectionViewCell.reuseIdentifier)
        
        collectionView.register(CategoryCollectionViewCell.self,
           forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
        
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
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
                
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
                section.orthogonalScrollingBehavior = .groupPagingCentered
                
                return section
            case .standard:
                // MARK: Standard Section Layout
                let itemSize =
                NSCollectionLayoutSize(widthDimension:
                        .fractionalWidth(1), heightDimension: .fractionalWidth(1/3))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize =
                NSCollectionLayoutSize(widthDimension:
                        .fractionalWidth(0.92), heightDimension: .estimated(250))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                
                return section
            case .categories:
                // MARK: Categories Section Layout
                let itemSize =
                NSCollectionLayoutSize(widthDimension:
                        .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let availableLayoutWidth =
                layoutEnvironment.container.effectiveContentSize.width
                let groupWidth = availableLayoutWidth * 0.92
                let remainingWidth = availableLayoutWidth - groupWidth
                let halfOfRemainingWidth = remainingWidth / 2.0
                let nonCategorySectionItemInset = CGFloat(4)
                let itemLeadingAndTrailingInset = halfOfRemainingWidth + nonCategorySectionItemInset
                
                item.contentInsets = NSDirectionalEdgeInsets(
                    top: 0,
                    leading: itemLeadingAndTrailingInset,
                    bottom: 0,
                    trailing: itemLeadingAndTrailingInset
                )
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(44)
                )
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                return section
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
            case .standard:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StandardAppCollectionViewCell.reuseIdentifier, for: indexPath) as! StandardAppCollectionViewCell
                
                let isThirdItem = (indexPath.row + 1).isMultiple(of: 3)
                cell.configureCell(item.pokemon!, hideBottomLine: isThirdItem)
                
                return cell
            case .categories:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
                let isLastItem = collectionView.numberOfItems(inSection: indexPath.section) == indexPath.row + 1
                cell.configureCell(item.generation!, hideBottomLine: isLastItem)
                
                return cell
            default:
                fatalError("Not yet implemented.")
            }
        })
        
        // MARK: Snapshot Definition
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.promoted])
        snapshot.appendItems(Item.promotedPokemons, toSection: .promoted)
        
        let popularSection = Section.standard("Popular this week")
        //let essentialSection = Section.standard("Essential picks")
        let categoriesSection = Section.categories
        
        snapshot.appendSections([popularSection/*, essentialSection*/, categoriesSection])
        snapshot.appendItems(Item.firstPokemonGeneration, toSection: popularSection)
        //snapshot.appendItems(Item.generations, toSection: essentialSection)
        snapshot.appendItems(Item.generations, toSection: categoriesSection)
        
        sections = snapshot.sectionIdentifiers
        
        dataSource.apply(snapshot)
    }
    
}
