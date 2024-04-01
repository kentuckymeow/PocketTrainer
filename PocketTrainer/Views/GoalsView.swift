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
        formatter.dateStyle = .medium
        return formatter
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    editingGoalId = nil
                    showingPopup = true
                }) {
                    Text("Add")
                        .frame(width: 80,height: 40)
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
                        Text("\(goal.weight)kg")
                        Text("\(goal.reps) reps")
                        Text("\(goal.sets) sets")
                        Text(dateFormatter.string(from: goal.date))
                            .fontWeight(.bold)
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
        .sheet(isPresented: $showingPopup) {
            VStack {
                Text("Write your Goals")
                    .font(.title)
                    .padding()
                TextField("Name", text: $goal.name)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                TextField("Weight", text: $goal.weight)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                TextField("Reps", text: $goal.reps)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                TextField("Sets", text: $goal.sets)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                DatePicker("Date", selection: $goal.date, displayedComponents: .date)
                    .datePickerStyle(.automatic)
                    .padding()
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
                    Text("Save")
                        .frame(width: 80,height: 40)
                        .foregroundColor(.white)
                        .buttonStyle(.borderedProminent)
                        .background(.black)
                        .cornerRadius(20)
                }
                .padding()
            }
        }
    }
}

#Preview {
    GoalsView(viewModel: GoalsViewModel())
}
