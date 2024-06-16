//
//  SelectedPlanMealView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 29.03.2024.
//

import SwiftUI

struct SelectedPlanMealView: View {
    let planMeals: PlanMeals
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(planMeals.meals) { meals in
                    NavigationLink(destination: MealInfoView(meals: meals)) {
                        HStack() {
                            VStack(alignment:.leading) {
                                Text(meals.name)
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .padding(.leading)
                                Text("ккал: \(meals.kkal)")
                                    .font(.caption2)
                                    .fontWeight(.medium)
                                    .padding(.leading)
                                Text("БЖУ: \(meals.proteins)/\(meals.fats)/\(meals.carbs)")
                                    .font(.caption2)
                                    .fontWeight(.medium)
                                    .padding(.leading)
                            }
                            Spacer()
                            Image(meals.imageName)
                                .frame(width:145,height: 150)
                                .scaledToFit()
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
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(action: { self.presentationMode.wrappedValue.dismiss() }))
    }
}

#Preview {
    SelectedPlanMealView(planMeals: PlanMeals(name: "Набрать мышечную массу", kkal: "2300", imageName: "pumpUp", meals: [
        Meals(name: "Orange oatmeal with fruit", imageName: "oatmeal", kkal: "501", proteins: "9.90", fats: "19.20", carbs: "72.20", recipe: ""),
        Meals(name: "Hot dog with chicken boiled pork", imageName: "hotdog", kkal: "735", proteins: "51.20", fats: "26.50", carbs: "72.80", recipe: "")]))
}

