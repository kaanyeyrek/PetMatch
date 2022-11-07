//
//  CardItem.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/4/22.
//

import Foundation
import CardSlider
// implement to pod
struct CardItem: CardSliderItem {
    var image: UIImage
    var rating: Int?
    var title: String
    var subtitle: String?
    var description: String?
    
}
