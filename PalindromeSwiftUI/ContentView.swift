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
    
    init() {
        let coloredNavAppearance = UINavigationBarAppearance()
        
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = .systemBlue
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }
    var body: some View {
        ZStack {
            NavigationView() {
                VStack {
                    
                    Spacer()
                    
                    TextField("Type text here..", text: $word)
                        .padding()
                        .border(Color.blue, width: 1)
                    
                    Spacer()
                    
                    PalindromeButton(title: "Check",
                                     action: {
                                        let wordToCheck: String? = word.isEmpty ? nil : word.lowercased()
                                        if let _ = wordToCheck {
                                            result = true
                                        } else {
                                            result = false
                                        }
                                        showsResult.toggle()
                                        word.removeAll()
                                     },
                                     backgroundColor: Color(.systemBlue))
                        .disabled(showsResult)
                    
                    Spacer()
                    Spacer()
                }
                .padding()
                .navigationTitle(Text("Palindrome SwiftUI"))
                .navigationBarTitleDisplayMode(.inline)
            }
            .blur(radius: showsResult ? 10 : 0)
            .opacity(showsResult ? 0.5 : 1)
            
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
    var backgroundColor: Color
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text("\(title)")
                .foregroundColor(.white)
        })
        .frame(width: 280, height: 50, alignment: .center)
        .background(backgroundColor)
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
                .multilineTextAlignment(.center)
                .foregroundColor(result ? Color(.systemGreen) : Color(.systemRed))
                .font(.title)
                
            Text("\(result ? "This text is indeed a palindrome." : "It seems this text isn't a palindrome.")")
                .multilineTextAlignment(.center)
                .foregroundColor(result ? Color(.systemGreen) : Color(.systemRed))
            Spacer()
            PalindromeButton(title: result ? "OK" : "Try again",
                             action: {
                                visible.toggle()
                             },
                             backgroundColor: result ? Color(.systemGreen) : Color(.systemRed))
            Spacer()
        }
        .padding()
    }
}
