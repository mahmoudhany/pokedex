//
//  PokeCell.swift
//  pokedex
//
//  Created by Mahmoud on 6/14/17.
//  Copyright © 2017 Mahmoud. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5
    }
    
    
    func configureCell(pokemon: Pokemon){
        
        self.pokemon = pokemon
        
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexID)")
        nameLabel.text = self.pokemon.name.capitalized
        
    }
}





