//
//  SelectedPlanMealView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 29.03.2024.
//

import SwiftUI

struct SelectedPlanMealView: View {
    let planMeals: PlanMeals
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(planMeals.meals) { meals in
                        NavigationLink(destination: MealInfoView(meals: meals)) {
                            HStack() {
                                VStack(alignment:.leading) {
                                    Text(meals.name)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .padding(.leading)
                                    Text("kkal\(meals.kkal)")
                                        .font(.caption2)
                                        .fontWeight(.bold)
                                        .padding(.leading)
                                    Text("PFC:\(meals.proteins)/\(meals.fats)/\(meals.carbs)")
                                        .font(.caption2)
                                        .fontWeight(.bold)
                                        .padding(.leading)
                                }
                                Spacer()
                                    Image(meals.imageName)
                                    .frame(width:145,height: 150)
                                    .scaledToFill()
                                    .padding(.trailing)
                                }
                            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.black, lineWidth: 2))
                                .padding(.init(top: 10, leading: 15, bottom: 15, trailing: 15))
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
    }


#Preview {
    SelectedPlanMealView(planMeals: PlanMeals(name: "Pump Up", kkal: "2300", imageName: "pumpUp", meals: [
        Meals(name: "Orange oatmeal with fruit", imageName: "oatmeal", kkal: "501", proteins: "9.90", fats: "19.20", carbs: "72.20", recipe: ""),
        Meals(name: "Hot dog with chicken boiled pork", imageName: "hotdog", kkal: "735", proteins: "51.20", fats: "26.50", carbs: "72.80", recipe: "")]))
}

