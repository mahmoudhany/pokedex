//
//  Pokemon.swift
//  pokedex
//
//  Created by Mahmoud on 6/13/17.
//  Copyright © 2017 Mahmoud. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexID: Int!
    private var _nextPokedexID: String!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _pokemonURL: String!
    
    var nextPokedexID: String{
        
        if _nextPokedexID == nil {
            _nextPokedexID = ""
        }
        return _nextPokedexID
    }
    
    var description: String{
        
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String{
        
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String{
        
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String{
        
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String{
        
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    
    var attack: String{
        
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionTxt: String{
        
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var name: String{
        return _name
    }
    var pokedexID: Int{
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexID)/"
        
    }
    
    
    func dowloadPokemonDetail(completed: @escaping dowloadComplete){
        Alamofire.request(_pokemonURL).responseJSON { response in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
                if let height = dict["height"] as? String{
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, AnyObject>] , types.count > 0 {
                    
                    if let name = types[0]["name"] as? String{
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        for i in 1..<types.count {
                            
                            if let name = types[i]["name"] as? String{
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                }else{
                    self._type = ""
                }
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String, AnyObject>], descriptions.count > 0 {
                    
                    if let url = descriptions[0]["resource_uri"] as? String {
                        
                        let descURL = "\(URL_BASE)\(url)"
                        
                        Alamofire.request(URL(string: descURL)!).responseJSON(completionHandler: { response in
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                if let description = descDict["description"] as? String {
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "pokemon")
                                    self._description = newDescription
                                }
                            }
                            completed()
                        })
                        
                    }
                }else{
                    self._description = ""
                }
                
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] {
                    if evolutions.count > 0 {
                        
                        if let to = evolutions[0]["to"] as? String {
                            self._nextEvolutionTxt = "Next Evolution Level: \(to) "
                        }
                        if let level = evolutions[0]["level"] as? Int {
                            self._nextEvolutionTxt! += " LVL - \(level)"
                        }
                            
                        if let url = evolutions[0]["resource_uri"] as? String {
                            
                            let descURL = "\(URL_BASE)\(url)"
                            
                            Alamofire.request(URL(string: descURL)!).responseJSON(completionHandler: { response in
                                
                                if let nextEvoDict = response.result.value as? Dictionary<String, AnyObject> {
                                    if let pkdx_id = nextEvoDict["pkdx_id"] as? Int {
                                        self._nextPokedexID = "\(pkdx_id)"
                                    }
                                }
                                completed()
                            })
                            
                        
                    }///////end
                        
                    }
                    
                    
                    
                }
                
                
            }
             completed() //typed inside response closure
        }
    }
}







