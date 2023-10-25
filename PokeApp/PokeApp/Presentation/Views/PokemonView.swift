//
//  PokemonView.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/2/23.
//

import UIKit

class PokemonView: UIViewController {
    
    var presenter: IPokemonPresenter!
    
    var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Section Definitions
    enum Section: Hashable {
        case promoted
        case standard(String)
        case categories
    }
    
    // MARK: Supplementary View Definition
    enum SupplementaryViewKind {
        static let header = "header"
        static let topLine = "topLine"
        static let bottomLine = "bottomLine"
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initPokemonModule()
        configureActivityIndicator()
        presenter.getPokemonsAndGenerations()
    }
    
    func initPokemonModule() {
        let router = PokemonRouter()
        router.initPokemonModule(view: self)
    }
    
    func configureActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        
        activityIndicator.center = view.center
        
        view.addSubview(activityIndicator)
    }
    
    // MARK: Collection View Setup
    func collectionViewSetup() {
        collectionView.collectionViewLayout = createLayout()
        
        registerCollectionViewCells()
        
        registerCollectionReusableViews()
        
        configureDataSource()
    }
    
    func registerCollectionViewCells() {
        collectionView.register(PromotedPokemonCollectionViewCell.self, forCellWithReuseIdentifier: PromotedPokemonCollectionViewCell.reuseIdentifier)
        
        collectionView.register(StandardAppCollectionViewCell.self,
           forCellWithReuseIdentifier:
           StandardAppCollectionViewCell.reuseIdentifier)
        
        collectionView.register(CategoryCollectionViewCell.self,
           forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
    }
    
    func registerCollectionReusableViews() {
        collectionView.register(SectionHeaderView.self,
           forSupplementaryViewOfKind: SupplementaryViewKind.header,
           withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        collectionView.register(LineView.self, forSupplementaryViewOfKind:
           SupplementaryViewKind.topLine, withReuseIdentifier:
           LineView.reuseIdentifier)
        collectionView.register(LineView.self, forSupplementaryViewOfKind:
           SupplementaryViewKind.bottomLine, withReuseIdentifier:
           LineView.reuseIdentifier)
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout
        { (sectionIndex, layoutEnvironment) ->
            NSCollectionLayoutSection? in
            
            let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .estimated(44))
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: SupplementaryViewKind.header, alignment: .top)
            headerItem.contentInsets = NSDirectionalEdgeInsets( top: 0, leading: 4, bottom: 0, trailing: 4)
            
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
                section.boundarySupplementaryItems = [headerItem]
                
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
                section.boundarySupplementaryItems = [headerItem]
                
                return section
            }
        }
        return layout
    }
    
    func configureDataSource() {
        // MARK: Data Source Initialization
        dataSource = .init(collectionView: collectionView, cellProvider: { [weak self] (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard let self = self else { return nil }
            let section = self.sections[indexPath.section]
            switch section {
            case .promoted:
                let cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: PromotedPokemonCollectionViewCell.reuseIdentifier, for: indexPath) as! PromotedPokemonCollectionViewCell
                
                cell.configureCell(item.pokemon!)
                
                self.presenter.getPokemonImageAndBaseExperience(pokemonURL: item.pokemon!.url, cell: cell)
                
                return cell
            case .standard:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StandardAppCollectionViewCell.reuseIdentifier, for: indexPath) as! StandardAppCollectionViewCell
                
                let isThirdItem = (indexPath.row + 1).isMultiple(of: 3)
                cell.configureCell(hideBottomLine: isThirdItem)
                
                self.presenter.getPokemonImageAndBaseExperience(specieURL: item.firstPokemonGeneration!.pokemonSpecieURL, cell: cell)
                
                return cell
            case .categories:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
                let isLastItem = collectionView.numberOfItems(inSection: indexPath.section) == indexPath.row + 1
                cell.configureCell(item.generation!, hideBottomLine: isLastItem)
                
                return cell
            }
        })
        
        // MARK: Supplementary View Provider
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            switch kind {
            case SupplementaryViewKind.header:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: SupplementaryViewKind.header, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as! SectionHeaderView
                
                let section = self.sections[indexPath.section]
                let sectionName: String
                switch section {
                case .promoted:
                    return nil
                case .standard(let name):
                    sectionName = name
                case .categories:
                    sectionName = "Generations"
                }
                
                headerView.setTitle(sectionName)
                
                return headerView
        
            case SupplementaryViewKind.topLine, SupplementaryViewKind.bottomLine:
                let lineView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LineView.reuseIdentifier, for: indexPath) as! LineView
                return lineView
        
            default:
                return nil
            }
        }
        
        // MARK: Snapshot Definition
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.promoted])
        snapshot.appendItems(Item.promotedPokemons, toSection: .promoted)
        
        let popularSection = Section.standard("First Generation")
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
