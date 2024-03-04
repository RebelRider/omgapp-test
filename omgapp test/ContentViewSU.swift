//
//  ContentViewSU.swift
//  omgapp test
//
//  Created by Kirill Smirnov on 04.03.2024.
//

import SwiftUI

struct ContentView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        List(0..<Int.random(in: 101...200), id: \.self) { _ in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<Int.random(in: 11...20), id: \.self) { _ in
                        SquareView()
                    }
                }
            }
        }
    }
}

struct SquareView: View {
    @State private var randomNumber = Int.random(in: 1...100)
    @State private var isPressed = false

    var body: some View {
        Text("\(randomNumber)")
            .frame(width: 50, height: 50)
            .background(Color.blue)
            .cornerRadius(11)
            .overlay(RoundedRectangle(cornerRadius: 11).stroke(Color.black, lineWidth: 1))
            .scaleEffect(isPressed ? 0.8 : 1.0)
            .animation(.easeInOut, value: isPressed)
            .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { pressing in
                isPressed = pressing
            }, perform: {})
            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                randomNumber = Int.random(in: 1...100)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
