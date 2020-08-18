//
//  ContentView.swift
//  SwiftUIWidgets
//
//  Created by Balaji Sundaram on 18/08/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("coffeeLarg").resizable().edgesIgnoringSafeArea(.all)
            VStack{
                Text("Welcome to the Coffee  Application").font(.title2).bold().foregroundColor(.white).padding(EdgeInsets.init(top: 0, leading: 0, bottom: 350, trailing: 0))              // Spacer()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    
    }
}
