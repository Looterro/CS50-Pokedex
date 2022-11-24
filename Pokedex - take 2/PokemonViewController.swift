//
//  PokemonViewController.swift
//  Pokedex - take 2
//
//  Created by Jakub Łata on 23/11/2022.
//

import UIKit

class PokemonViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var type1Label: UILabel!
    @IBOutlet var type2Label: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Clear the text so it doesnt show placeholders
        type1Label.text = ""
        type2Label.text = ""
        
        let url = URL(string: pokemon.url)
        
        //Data cannot be optional
        guard let u = url else {
            return
        }
        
        //Method for reading API and fetching the data
        URLSession.shared.dataTask(with: u) { data, response, error in
            
            guard let data = data else {
                return
            }
            
            //Guard against object not being a valid json, and then decode, structs must be codable in order for this to happen as it is described in a protocol
            do {
                
                let pokemonData = try JSONDecoder().decode(PokemonData.self, from: data)
                
                DispatchQueue.main.async {
                    
                    // Populate labels with data from the previous view and then API for number
                    self.nameLabel.text = self.pokemon.name
                    self.numberLabel.text = String(format: "#%03d", pokemonData.id)
                    
                    
                    for typeEntry in pokemonData.types {
                        if typeEntry.slot == 1 {
                            self.type1Label.text = typeEntry.type.name
                        }
                        else if typeEntry.slot == 2 {
                            self.type2Label.text = typeEntry.type.name
                        }
                    }
                    
                }
                
            } catch let error {
                print("\(error)")
            }
            
        }.resume()
        
        
    }
    
}

