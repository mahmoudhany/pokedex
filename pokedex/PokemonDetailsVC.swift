//
//  PokemonDetailsVC.swift
//  pokedex
//
//  Created by Mahmoud on 6/14/17.
//  Copyright © 2017 Mahmoud. All rights reserved.
//

import UIKit

class PokemonDetailsVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel! ////////
    @IBOutlet weak var typeLabel: UILabel!/////////
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!/////
    @IBOutlet weak var nextEvoImg: UIImageView!////////
    @IBOutlet weak var evoLabel: UILabel!////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pokemon.dowloadPokemonDetail{
            // called after network requests has completed
//            print("arrived")
            
            self.updateUI()
            
        }
    }
    
    func updateUI(){
        nameLabel.text = pokemon.name.capitalized
        mainImage.image = UIImage(named: "\(pokemon.pokedexID)")
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        pokedexLabel.text = "\(pokemon.pokedexID)"
        weightLabel.text = pokemon.weight
        attackLabel.text = pokemon.attack
        typeLabel.text = pokemon.type
        descriptionLabel.text = pokemon.description
        
        
        if pokemon.nextPokedexID != "" {
            currentEvoImage.image = UIImage(named: "\(pokemon.pokedexID)")
            nextEvoImg.image = UIImage(named: "\(pokemon.nextPokedexID)")
            evoLabel.text = pokemon.nextEvolutionTxt
            
        }else{
            currentEvoImage.image = UIImage(named: "\(pokemon.pokedexID)")
            evoLabel.text = "None"
        }

        
        
        
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}














