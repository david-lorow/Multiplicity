//
//  StartScreen.swift
//  Multiplicity
//
//  Created by David Lorow on 10/18/24.
//

import SwiftUI


struct StartScreen: View {
    
    var backgroundColor: Color = .black
    
    var body: some View {
        VStack {
            Spacer()
            Rectangle()
                .fill(Color.neonRed)
                .frame(width: 300, height: 50)
                .overlay(
                    Text("Welcome!")
                        .foregroundStyle(.white)
                        .font(.custom("Avenir", size: 50))
                )
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
            HStack {
                Rectangle()
                    .fill(Color.neonOrange)
                    .frame(width: 150, height: 400)
                    .overlay(
                        VStack {
                            Spacer()
                            Image(systemName: "dumbbell.fill")
                                .font(.system(size: 100))
                            Text("Practice your multiplicaiton skills with a customized exercise")
                                .foregroundStyle(.black)
                                .font(.custom("Avenir", size: 20))
                            Spacer()
                        }
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                
                Rectangle()
                    .fill(Color.neonBlue)
                    .frame(width: 150, height: 400)
                    .overlay(
                        VStack {
                            Spacer()
                            Image(systemName: "book.pages.fill")
                                .font(.system(size: 100))
                            HStack {
                                Spacer()
                                Text("Review your multiplication tables to help you prepare beforehand")
                                    .foregroundStyle(.black)
                                    .font(.custom("Avenir", size: 20))
                                Spacer()
                            }
                            Spacer()
                            Spacer()
                        }
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
            }
            Spacer()
            Spacer()
        }
    }
}

#Preview {
    StartScreen()
}

