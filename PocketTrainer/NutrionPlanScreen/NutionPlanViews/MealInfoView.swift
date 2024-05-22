//
//  PlanMealView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 12.04.2024.
//

import SwiftUI

struct MealInfoView: View {
    let meals: Meals
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading, spacing: 16) {
                Text(meals.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                HStack {
                    Spacer()
                    Image(meals.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 170)
                        .padding(.bottom, 16)
                    Spacer()
                }
                
                
                HStack {
                    VStack {
                        Text("Calories")
                        Text(meals.kkal)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    VStack {
                        Text("Proteins")
                        Text("\(meals.proteins)g")
                            .fontWeight(.bold)
                    }
                    Spacer()
                    VStack {
                        Text("Fats")
                        Text("\(meals.fats)g")
                            .fontWeight(.bold)
                    }
                        Spacer()
                    VStack {
                        Text("Carbs")
                        Text("\(meals.carbs)g")
                            .fontWeight(.bold)
                    }
                }
                .padding(.bottom, 16)
                
                Text("Recipe")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom, 8)
                
                ScrollView {
                    Text(meals.recipe)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(action: { self.presentationMode.wrappedValue.dismiss() }))
                          }
    }



#Preview {
    MealInfoView(meals: Meals(name: "Orange oatmeal with fruit", imageName: "hotdog", kkal: "501", proteins: "9.90", fats: "19.20", carbs: "72.20", recipe:
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
                                """))
}
