//
//  SearchTableViewDelegate.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 11/14/23.
//

import UIKit

class SearchTableViewDelegate: NSObject, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    weak var view: PokemonView!
    
    var filteredPokemon: [Item] = []
    
    init(view: PokemonView) {
        self.view = view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        let item = filteredPokemon[indexPath.row]
        
        cell.pokemon = item.pokemon
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SearchTableViewCell
        
        view.presenter.showSearchedPokemon(pokemonURL: cell.pokemon.url)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.searchTableView.isHidden = false
        view.searchBar.showsCancelButton = true
        view.navigationController?.isNavigationBarHidden = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        view.searchTableView.isHidden = false
        view.searchBar.showsCancelButton = true
        view.navigationController?.isNavigationBarHidden = true
        
        filteredPokemon = Item.promotedPokemons.filter { item in
            return item.pokemon!.name.lowercased().contains(searchText.lowercased())
        }
        view.searchTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        view.searchTableView.isHidden = true
        view.searchBar.showsCancelButton = false
        view.navigationController?.isNavigationBarHidden = false
        view.searchBar.endEditing(true)
        
        filteredPokemon.removeAll()
        view.searchTableView.reloadData()
    }

}
