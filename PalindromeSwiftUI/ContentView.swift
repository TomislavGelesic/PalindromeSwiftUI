//
//  ContentView.swift
//  PalindromeSwiftUI
//
//  Created by Tomislav Gelesic on 18.07.2021..
//

import SwiftUI

struct ContentView: View {
    
    @State private var word: String = ""
    @State private var showsResult: Bool = false
    @State private var result: Bool = false
    
    var body: some View {
        ZStack {
            NavigationView() {
                VStack {
                    Spacer()
                    TextField("Type text here..", text: $word)
                        .padding()
                        .border(Color.blue, width: 1)
                    Spacer()
                    PalindromeButton(title: "Check", action: {
                        if word.elementsEqual(word.reversed()) && !word.isEmpty {
                            result = true
                        } else {
                            result = false
                        }
                        showsResult.toggle()
                    })
                    Spacer()
                    Spacer()
                }
                .padding()
                .navigationTitle(Text("Palindrome SwiftUI"))
                .navigationBarTitleDisplayMode(.inline)
            }
            .blur(radius: showsResult ? 10 : 0)
            if showsResult {
                VStack {
                    ResultsView(result: result, visible: $showsResult)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PalindromeButton: View {
    var title: String
    var action: ()->()
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text("\(title)")
                .foregroundColor(.blue)
        })
        .frame(width: 280, height: 50, alignment: .center)
        .background(Color(red: 135/255, green: 200/255, blue: 250/255))
        .cornerRadius(10)
    }
}

struct ResultsView: View {
    
    @State var result: Bool
    @Binding var visible: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(result ? "Congratulations!" : "Ooops!")")
                .foregroundColor(result ? .green : .orange)
            Spacer()
            Text("\(result ? "This text is indeed a palindrome." : "It seems this text isn't a palindrome.\n Try another!")")
                .foregroundColor(result ? .green : .orange)
            Spacer()
            PalindromeButton(title: "OK", action: {
                visible.toggle()
            })
            Spacer()
        }
        .padding()
    }
}
