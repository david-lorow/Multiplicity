//
//  ReferenceCards.swift
//  Multiplicity
//
//  Created by David Lorow on 10/18/24.
//

import SwiftUI



struct ReferenceCards: View {
    
    @State private var topColor = Color.lightRed
    @State private var bottomColor = Color.extraLightRed
    @State private var numTable = "One"
    @State private var product1 = 1
    @State private var showingMenu = false
    
    let product2 = 12
    
    var body: some View {
        NavigationStack {
                VStack(spacing: -10) {
                    Spacer()
                    ZStack{
                        Rectangle()
                            .fill(topColor)
                            .frame(width: .infinity, height: 100)
                        
                        Text(numTable)
                            .font(.custom("Avenir", size: 80))
                            .foregroundColor(.white)
                    }
                    ZStack {
                        Rectangle()
                            .fill(bottomColor)
                            .frame(width: .infinity, height: 500)
                        VStack {
                            ForEach(product1...product1, id: \.self) { product1 in
                                ForEach(1...product2, id: \.self) { product2 in
                                    Text("\(product1) x \(product2) = \(product1 * product2)")
                                }
                            }
                            .font(.custom("Avenir", size: 30))
                            .foregroundColor(.black)
                        }
                    }
                    Spacer()
                    Spacer()
                }
        }
        .toolbar {
            Menu {
                ForEach(1...product2, id: \.self) { num in
                    Button("\(num)") {
                        chooseNum(num)
                    }
                }
                
            }label: {
                Image(systemName: "ellipsis.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
    }
    
    let numTableDict = [
        1: "One",
        2: "Two",
        3: "Three",
        4: "Four",
        5: "Five",
        6: "Six",
        7: "Seven",
        8: "Eight",
        9: "Nine",
        10: "Ten",
        11: "Eleven",
        12: "Twelve"
    ]

    func chooseNum(_ num: Int) {
        
        product1 = num
        
        switch num {
        case 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12:
            numTable = numTableDict[num] ?? "Unknown"
        default:
            numTable = "Unknown"
        }
        
        switch numTable {
        case "One", "Five", "Nine":
            topColor = Color.lightRed
            bottomColor = Color.extraLightRed
        case "Two", "Six", "Ten":
            topColor = Color.lightOrange
            bottomColor = Color.extraLightOrange
        case "Three", "Seven", "Eleven":
            topColor = Color.lightBlue
            bottomColor = Color.extraLightBlue
        case "Four", "Eight", "Twelve":
            topColor = Color.lightPurple
            bottomColor = Color.extraLightPurple
        default:
            topColor = Color.lightRed
            bottomColor = Color.extraLightRed
        }
    }
}

#Preview {
    ReferenceCards()
}
