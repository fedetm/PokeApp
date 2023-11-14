//
//  IPokemonIntToPresenter.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/3/23.
//

import Foundation

protocol IPokemonIntToPresenter: AnyObject {
    
    func setPokemonsAndGenerations(_ pokemons: [BasicPokemon], _ generations: [BasicPokemonGeneration], _ firstPokemonGeneration: [PokemonSpecieResponse], _ secondPokemonGeneration: [PokemonSpecieResponse])
    
}
