//
//  PlanMealsView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 29.03.2024.
//

import SwiftUI

struct PlanMealsView: View {
    @ObservedObject var viewModel: PlanMealsViewModel
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.planMeals) { meals in
                        NavigationLink(destination: SelectedPlanMealView(planMeals: meals)) {
                            ZStack(alignment: .bottomLeading) {
                                Image(meals.imageName)
                                    .frame(height: 120)
                                    .cornerRadius(25)
                                VStack(alignment:.leading) {
                                    Text(meals.name)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    Text("\(meals.kkal) ккал")
                                        .font(.caption2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                                .padding(.init(top: 0, leading: 15, bottom: 15, trailing: 0))

                                    
                            }
                            .padding(.vertical)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
    }
}


#Preview {
    PlanMealsView(viewModel: PlanMealsViewModel())
}
