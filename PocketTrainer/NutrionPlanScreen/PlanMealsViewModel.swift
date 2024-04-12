//
//  PlanMealsViewModel.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 29.03.2024.
//

import Foundation

class PlanMealsViewModel: ObservableObject {
    @Published var planMeals = [
        PlanMeals(name: "Pump Up", kkal: "2300", imageName: "pumpUp", meals: [
            Meals(name: "Orange oatmeal with fruit", imageName: "oatmeal", kkal: "501", proteins: "9.90", fats: "19.20", carbs: "72.20", recipe: 
                    """
                  Here is the recipe for oatmeal with orange and fruits :
                  Ingredients:
                  Oatmeal: 330 g
                  Sugar: to taste
                  Canned peaches: to taste
                  Canned pineapples: to taste
                  82.5% butter: 60 g
                  Salt: to taste
                  Orange juice: to taste
                  Preparation:
                  Pour a sufficient amount of water into a saucepan and bring it to a boil.
                  Add the oatmeal and simmer until cooked (about 15 minutes).
                  While the oatmeal is cooking, cut the canned peaches and pineapples into small pieces.
                  When the oatmeal is ready, add the butter, sugar, and salt. Stir until the sugar and salt are completely dissolved.
                  Add the chopped fruits and orange juice. Stir.
                  Serve the oatmeal hot. Enjoy your meal!
"""),

            Meals(name: "Hot dog with chicken boiled pork", imageName: "hotdog", kkal: "735", proteins: "51.20", fats: "26.50", carbs: "72.80", recipe: "")]),
        PlanMeals(name: "Body balance", kkal: "1700", imageName: "bodyBalance", meals: [
            Meals(name: "Orange oatmeal with fruit", imageName: "oatmeal", kkal: "501", proteins: "9.90", fats: "19.20", carbs: "72.20", recipe: ""),
            Meals(name: "Hot dog with chicken boiled pork", imageName: "hotdog", kkal: "735", proteins: "51.20", fats: "26.50", carbs: "72.80", recipe: "")]),
                   
    ]
}
