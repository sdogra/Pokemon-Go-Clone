//
//  CoreDataHelper.swift
//  Pokemon Go Clone
//
//  Created by Sahil Dogra on 7/11/19.
//  Copyright © 2019 Sahil Dogra. All rights reserved.
//

import UIKit
import CoreData

func addAllPokemon() {
    createPokemon(name: "Abra", imageName: "abra")
    createPokemon(name: "Bellsprout", imageName: "bellsprout")
    createPokemon(name: "Bullbasaur", imageName: "bullbasaur")
    createPokemon(name: "Caterpie", imageName: "caterpie")
    createPokemon(name: "Charmander", imageName: "charmander")
    createPokemon(name: "Dratini", imageName: "dratini")
    createPokemon(name: "Eevee", imageName: "eevee")
    createPokemon(name: "Jigglypuff", imageName: "jigglypuff")
    createPokemon(name: "Mankey", imageName: "mankey")
    createPokemon(name: "Meowth", imageName: "meowth")
    createPokemon(name: "Mew", imageName: "mew")
    createPokemon(name: "Pidgey", imageName: "pidgey")
    createPokemon(name: "Pikachu", imageName: "pikachu-2")
    createPokemon(name: "Psyduck", imageName: "psyduck")
    createPokemon(name: "Rattata", imageName: "rattata")
    createPokemon(name: "Snorlax", imageName: "snorlax")
    createPokemon(name: "Squirtle", imageName: "squirtle")
    createPokemon(name: "Venonat", imageName: "venonat")
    createPokemon(name: "Weedle", imageName: "weedle")
    createPokemon(name: "Zubat", imageName: "zubat")
}

func createPokemon(name:String, imageName:String){
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        let pokemon = Pokemon(context: context)
        pokemon.imageName = imageName
        pokemon.name = name
        try? context.save()
    }
}

func getAllPokemon() -> [Pokemon]{
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        if let pokemonData = try? context.fetch(Pokemon.fetchRequest()) as? [Pokemon] {
            let pokemons = pokemonData
                if pokemons.count == 0 {
                    addAllPokemon()
                    return getAllPokemon()
                }
                else {
                    return pokemons
                }
            
        }
    }
    return []
}
