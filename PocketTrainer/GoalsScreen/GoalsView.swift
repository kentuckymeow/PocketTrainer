//
//  GoalsView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 28.03.2024.
//

import SwiftUI

struct GoalsView: View {
    @State private var showingPopup = false
    @State private var editingGoalId: UUID?
    @State private var goal = Goal(name: "", weight: "", reps: "", sets: "", date: Date())
    
    @ObservedObject var viewModel: GoalsViewModel
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }
    
    var body: some View {
    ScrollView {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    editingGoalId = nil
                    showingPopup = true
                }) {
                    Text("Добавить")
                        .frame(width: 100,height: 40)
                        .foregroundColor(.white)
                        .buttonStyle(.borderedProminent)
                        .background(.black)
                        .cornerRadius(20)
                }
                .padding(.trailing, 20)
            }
            ForEach(viewModel.goals) { goal in
                HStack {
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(goal.name)
                        Text("\(goal.weight)кг")
                        Text("\(goal.reps) повторений")
                        Text("\(goal.sets) подходов")
                        Text(dateFormatter.string(from: goal.date))
                            .fontWeight(.bold)
                            .environment(\.locale,Locale(identifier: "ru_RU"))
                    }
                    .padding()
                    .frame(width: 370,height: 140, alignment: .leading)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .onTapGesture {
                        editingGoalId = goal.id
                        self.goal = goal
                        showingPopup = true
                    }
                    Spacer()
                }
            }
            Spacer()
        }
    }
    .toolbar(.hidden, for: .tabBar)
        .sheet(isPresented: $showingPopup) {
            VStack {
                Text("Напиши свои цели")
                    .font(.title)
                    .padding()
                TextField("Название", text: $goal.name)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                TextField("Вес", text: $goal.weight)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                TextField("Повторений", text: $goal.reps)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                TextField("Подходов", text: $goal.sets)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                DatePicker("Дата", selection: $goal.date, displayedComponents: .date)
                    .datePickerStyle(.automatic)
                    .environment(\.locale, Locale(identifier: "ru_RU"))
                    .padding()
                HStack {
                    Button(action: {
                        if let id = editingGoalId {
                            viewModel.updateGoal(id: id, name: goal.name, weight: goal.weight, reps: goal.reps, sets: goal.sets, date: goal.date)
                        } else {
                            viewModel.addGoal(name: goal.name, weight: goal.weight, reps: goal.reps, sets: goal.sets, date: goal.date)
                        }
                        
                        goal = Goal(name: "", weight: "", reps: "", sets: "", date: Date())
                        editingGoalId = nil
                        showingPopup = false
                    }) {
                        Text("Сохранить")
                            .frame(width: 100,height: 40)
                            .foregroundColor(.white)
                            .buttonStyle(.borderedProminent)
                            .background(.black)
                            .cornerRadius(20)
                    }
                    if editingGoalId != nil {
                        Button(action: {
                            if let id = editingGoalId {
                                viewModel.deleteGoal(id: id)
                            }
                            
                            goal = Goal(name: "", weight: "", reps: "", sets: "", date: Date())
                            editingGoalId = nil
                            showingPopup = false
                        }) {
                            Text("Удалить")
                                .frame(width: 100,height: 40)
                                .foregroundColor(.white)
                                .buttonStyle(.borderedProminent)
                                .background(.red)
                                .cornerRadius(20)
                        }
                    }
                }
                .padding()
            }
        }
        .environment(\.locale, Locale(identifier: "ru_RU"))
    }
}

#Preview {
    GoalsView(viewModel: GoalsViewModel())
}
