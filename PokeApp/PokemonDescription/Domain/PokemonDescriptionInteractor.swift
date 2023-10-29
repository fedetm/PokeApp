//
//  PokemonDescriptionInteractor.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/25/23.
//

import Foundation

class PokemonDescriptionInteractor: IPokemonDescriptionInteractor {
    
    var repository: IPokemonDescriptionRepository
    weak var presenter: IPokemonDescriptionIntToPresenter!
    
    init() {
        repository = PokemonDescriptionRepository()
    }
    
    func getSprites(from sprites: Sprites) {
        
        var urlArray = [URL]()
        let mirror = Mirror(reflecting: sprites)
        for case let (_?, value) in mirror.children {
            if let urlString = value as? String {
                let url = URL(string: urlString)!
                urlArray.append(url)
            }
        }
        
        let serialQueue = DispatchQueue(label: "serialQueueSprites")
        let group = DispatchGroup()
        
        var dataArray = [Data]()
        
        for url in urlArray {
            serialQueue.async {
                group.wait()
                group.enter()
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.repository.getSprite(from: url) { data in
                        dataArray.append(data)
                        group.leave()
                    }
                }
            }
        }
        
        serialQueue.async {
            group.wait()
            group.enter()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.presenter.setSpritesData(dataArray)
                group.leave()
            }
        }
    }
    
}
