//
//  MealsViewModel.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 12.04.2024.
//

import Foundation

class MealsViewModel: ObservableObject {
    @Published var meals: [Meals]

    init() {
        self.meals = [
            Meals(name: "Апельсиновая овсянка с фруктами", imageName: "oatmeal", kkal: "501", proteins: "9.90", fats: "19.20", carbs: "72.20", recipe:
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
                 """),
            Meals(name: "Хот-дог с курицей и вареной свининой", imageName: "hotdog", kkal: "735", proteins: "51.20", fats: "26.50", carbs: "72.80", recipe: "")
        ]
    }
}
