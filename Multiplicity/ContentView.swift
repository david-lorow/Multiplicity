//
//  ContentView.swift
//  Multiplicity
//
//  Created by David Lorow on 10/18/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.colorScheme) var backColor
    var backgroundColor: Color {
        backColor == .dark ? Color.black : Color.white
    }
    @State private var themeColor = Color.neonRed
    
    @State private var practiceStarted = false
    @State private var selectedTable = "One"
    @State private var selectedAmount = 5
    
    var body: some View {
        TabView {
            NavigationStack {
                StartScreen()
                    .navigationTitle("Home")
                    }
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
            
            NavigationStack {
                if practiceStarted {
                    PracticePage(table: selectedTable, questionAmount: selectedAmount) {
                        practiceStarted = false
                    }
                } else {
                    PracticeScreen { table, amount in
                        selectedTable = table
                        selectedAmount = amount
                        practiceStarted = true
                    }
                    .navigationTitle("Practice")
                }
            }
            .tabItem {
                Image(systemName: "dumbbell.fill")
                Text("Practice")
            }
                
            NavigationStack {
                ReferenceCards()
                .navigationTitle("Reference Cards")
            }
                    .tabItem {
                        Image(systemName: "book.pages.fill")
                        Text("Reference Cards")
                    }
            }
        .tint(themeColor)
        .background(backgroundColor)
    }
}

#Preview {
    ContentView()
}
