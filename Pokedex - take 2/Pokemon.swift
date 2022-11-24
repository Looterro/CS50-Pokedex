//
//  Pokemon.swift
//  Pokedex - take 2
//
//  Created by Jakub Łata on 23/11/2022.
//

import Foundation

//First get a list of pokemon that is returned with api url then use pokemon struct to get single pieces of data in an array
struct PokemonList: Codable {
    let results: [Pokemon]
}

//struct dont have methods in them thats why they are different than classes, this one contains link to more information and name for the list of all pokemons
struct Pokemon: Codable {
    let name: String
    //let number: Int
    let url: String
}

// Data to present in the PokemonViewController, after other structs of lower level have created data
struct PokemonData: Codable {
    let id: Int
    let types: [PokemonTypeEntry]
    
}

// Struct created because the type is embeded in an additional object in types in the API
struct PokemonType: Codable {
    let name: String
    let url: String
}

// Decode the type object in the API
struct PokemonTypeEntry: Codable {
    let slot: Int
    let type: PokemonType
}
