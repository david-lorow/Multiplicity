//
//  PracticeScreen.swift
//  Multiplicity
//
//  Created by David Lorow on 10/18/24.
//

import SwiftUI

struct PracticeScreen: View {
    
    let headingColor1: Color! = [Color.red, Color.orange, Color.blue, Color.purple].shuffled().randomElement()
    let headingColor2: Color! = [Color.red, Color.orange, Color.blue, Color.purple].shuffled().randomElement()
    let questions = [5, 10, 15, 20]
    let tables = ["Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "All"]
    @State private var table = "One"
    @State private var questionAmount = 5
    var selectedSettings: (String, Int) -> Void
    
    var body: some View {
        VStack {
            Spacer()
            Rectangle()
            .fill(headingColor2)
            .frame(width: 300, height: 50)
            .overlay(
                Text("Choose which table to practice")
                    .foregroundStyle(.white)
                    .font(.custom("Avenir", size: 20))
                )
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
            Picker("Tables:", selection: $table) {
                ForEach(tables, id: \.self) {
                    Text("\($0)")
                }
            }
            .pickerStyle(WheelPickerStyle())

            Spacer()
            Spacer()
            
            Rectangle()
            .fill(headingColor1)
            .frame(width: 300, height: 50)
            .overlay(
                Text("Choose the number of questions")
                    .foregroundStyle(.white)
                    .font(.custom("Avenir", size: 20))
                )
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            HStack {
                Button(action: {
                    questionAmount = 5
                    selectedSettings(table, questionAmount)
                }) {
                    Rectangle()
                        .fill(Color.neonRed)
                        .frame(width: 150, height: 150)
                        .overlay(
                            Text("5")
                                .foregroundStyle(.white)
                                .font(.custom("Bebas Neue", size: 130))
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                }
                Button(action: {
                    questionAmount = 10
                    selectedSettings(table, questionAmount)
                }) {
                    Rectangle()
                        .fill(Color.neonOrange)
                        .frame(width: 150, height: 150)
                        .overlay(
                            Text("10")
                                .foregroundStyle(.white)
                                .font(.custom("Bebas Neue", size: 130))
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                }
            }
            HStack {
                Button(action: {
                    questionAmount = 15
                    selectedSettings(table, questionAmount)
                }) {
                    Rectangle()
                        .fill(Color.neonBlue)
                        .frame(width: 150, height: 150)
                        .overlay(
                            Text("15")
                                .foregroundStyle(.white)
                                .font(.custom("Bebas Neue", size: 130))
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                }
                Button(action: {
                    questionAmount = 20
                    selectedSettings(table, questionAmount)
                }) {
                    Rectangle()
                        .fill(Color.neonPurple)
                        .frame(width: 150, height: 150)
                        .overlay(
                            Text("20")
                                .foregroundStyle(.white)
                                .font(.custom("Bebas Neue", size: 130))
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                }
            }
            Spacer()
        }
    }
}

struct PracticePage: View {
    
    var table: String
    var questionAmount: Int
    let questionColor: Color! = [Color.red, Color.orange, Color.blue, Color.purple].shuffled().randomElement()
    let numList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    @State private var product2Op: Int?
    @State private var product2: Int = 2
    @State private var product1 = 2
    @State private var all = false
    
    @FocusState private var answerIsFocused: Bool
    @State private var answer = 0
    @State private var result = ""
    @State private var finalResult = ""
    @State private var score = 0
    @State private var questions = 0
    @State private var showingResult = false
    @State private var showingFinalResult = false
    
    @State private var showExitAlert = false
    var onExitPractice: () -> Void
    
    @State private var animationAmount: Double = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Rectangle()
                    .fill(questionColor)
                .frame(width: 330, height: 90)
                .overlay(
                    Text("\(product1) x \(product2) = ?")
                        .foregroundStyle(.white)
                        .font(.custom("Avenir", size: 60))
                    )
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                HStack {
                    Spacer()
                    TextField("Answer", value: $answer, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($answerIsFocused)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(.green)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .font(.system(size: 30))
                        .frame(maxWidth: 100)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                Spacer()
                Button("🧐") {
                    withAnimation(.spring(duration: 1, bounce: 0.5)) {
                          animationAmount += 360
                       }
                    }
                .font(.system(size: 100))
                .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 1))
                Spacer()
            }
            .onAppear {
                multiTable(table)
                product2Op = numList.randomElement()
                product2 = product2Op ?? 2
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showExitAlert = true
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 40))
                            .tint(.neonRed)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        checkAnswer(answer)
                        theEnd(questions)
                    }) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 40))
                            .tint(.neonGreen)
                    }
                }
            }
            .alert("Are you sure you want to exit practice?", isPresented: $showExitAlert) {
                Button("Yes", role: .destructive) {
                    onExitPractice()
                }
                Button("No", role: .cancel) {  }
            }
            .alert(result, isPresented: $showingResult) {
                Button("Continue", action: askQuestion)
            }
            .alert(finalResult, isPresented: $showingFinalResult) {
                Button("Restart", role: .destructive) {
                    reset()
                    onExitPractice()
                }
            }
        }
    }
    
    let productDictionary: [String: Int] = [
        "Two": 2,
        "Three": 3,
        "Four": 4,
        "Five": 5,
        "Six": 6,
        "Seven": 7,
        "Eight": 8,
        "Nine": 9,
        "Ten": 10,
        "Eleven": 11,
        "Twelve": 12
    ]
    
    func multiTable(_ table: String) {
        switch table {
        case "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve":
            product1 = productDictionary[table] ?? 2
        case "All":
            product1 = numList.shuffled().randomElement() ?? 2
            all = true
        default:
            product1 = 2
        }
    }
    
    func checkAnswer(_ answer: Int) {
        if answer != 0 {
            if answer != (product1 * product2) {
                result = "Hmmm, the answer is actually \(product1 * product2)"
            } else {
                result = "That's correct, great job!"
                score += 1
            }
            questions += 1
            showingResult = true
        }
    }
    
    func theEnd(_ question: Int) {
        if question == questionAmount {
            finalResult = "You got \(score) Meow-meows out of \(questionAmount)! 😺"
            showingFinalResult = true
        }
    }
    
    func askQuestion() {
        product2Op = numList.shuffled().randomElement()
        product2 = (product2Op ?? 2)
        if all {
            product1 = numList.shuffled().randomElement() ?? 2
        }
    }
    
    func reset() {
        score = 0
        questions = 0
        all = false
    }
    
}

#Preview {
    PracticePage(table: "Two", questionAmount: 5) {  }
}
