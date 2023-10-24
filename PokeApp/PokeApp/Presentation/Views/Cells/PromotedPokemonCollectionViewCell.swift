//
//  PromotedPokemonCollectionViewCell.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/4/23.
//

import UIKit

class PromotedPokemonCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "PromotedPokemonCollectionViewCell"
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.alignment = .fill
        
        return stackView
    }()
    
    let headlineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor.systemBlue
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.textColor = UIColor.label
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.textColor = UIColor.secondaryLabel
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5.0
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stackView.addArrangedSubview(headlineLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        stackView.setCustomSpacing(10, after: subTitleLabel)
        stackView.addArrangedSubview(imageView)
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ pokemon: BasicPokemon) {
        headlineLabel.text = "Now Trending".uppercased()
        titleLabel.text = pokemon.name
        subTitleLabel.text = "Base Experience: "
        imageView.image = UIImage(systemName: "photo.on.rectangle")
    }
    
    func configureCell(_ pokemon: Pokemon, _ image: UIImage) {
        titleLabel.text = pokemon.name
        subTitleLabel.text = "Base Experience: \(pokemon.baseExperience)"
        imageView.image = image
    } 
}
