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
                        Text("Каллории")
                        Text(meals.kkal)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    VStack {
                        Text("Белки")
                        Text("\(meals.proteins)г")
                            .fontWeight(.bold)
                    }
                    Spacer()
                    VStack {
                        Text("Жиры")
                        Text("\(meals.fats)г")
                            .fontWeight(.bold)
                    }
                        Spacer()
                    VStack {
                        Text("Углеводы")
                        Text("\(meals.carbs)г")
                            .fontWeight(.bold)
                    }
                }
                .padding(.bottom, 16)
                
                Text("Рецепт")
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
    MealInfoView(meals: Meals(name: "Апельсиновая овсянка с фруктами", imageName: "hotdog", kkal: "501", proteins: "9.90", fats: "19.20", carbs: "72.20", recipe:
                                """
                                Вот рецепт овсяной каши с апельсином и фруктами:
                                                                  
                                Ингредиенты:
                                Овсянка: 330 g
                                Сахар: по вкусу
                                Консервированные персики: по вкусу
                                Консервированные ананасы: по вкусу
                                Сливочное масло 82,5%: 60 g
                                Соль: по вкусу
                                Апельсиновый сок: по вкусу
                                Приготовление:
                                Налейте в кастрюлю достаточное количество воды и доведите ее до кипения.
                                Добавьте овсянку и варите до готовности (около 15 минут).
                                Пока овсянка варится, нарежьте консервированные персики и ананасы на мелкие кусочки.
                                Когда овсянка будет готова, добавьте масло, сахар и соль. Перемешайте до полного растворения сахара и соли.
                                Добавьте нарезанные фрукты и апельсиновый сок. Перемешайте.
                                Подавайте овсянку горячей. Приятного аппетита!
                                """))
}
