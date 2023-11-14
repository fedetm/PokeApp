//
//  PokemonDescriptionPresenter.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/25/23.
//

import Foundation
import UIKit

class PokemonDescriptionPresenter: IPokemonDescriptionPresenter, IPokemonDescriptionIntToPresenter {
    
    var interactor: IPokemonDescriptionInteractor
    weak var view: PokemonDescriptionView!
    
    init(interactor: IPokemonDescriptionInteractor, view: PokemonDescriptionView) {
        self.interactor = interactor
        self.view = view
    }
    
    func getSprites(from sprites: Sprites) {
        view.activityIndicator.startAnimating()
        interactor.getSprites(from: sprites)
    }
    
    func setSpritesData(_ dataArray: [Data]) {
        var images = [UIImage]()
        for data in dataArray {
            let image = UIImage(data: data)
            images.append(image!)
        }
        view.sprites = images
        view.collectionView.dataSource = view
        
        view.updateCollectionViewHeight()
        self.view.activityIndicator.stopAnimating()
    }
    
}
