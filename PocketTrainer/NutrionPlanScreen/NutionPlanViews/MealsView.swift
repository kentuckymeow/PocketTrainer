//
//  MealsView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 29.03.2024.
//

import SwiftUI

struct MealsView: View {
    @ObservedObject var viewModel: MealsViewModel
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.meals) { meals in
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
    MealsView(viewModel: MealsViewModel())
}
