//
//  PreferencesView.swift
//  Horno3
//
//  Created by Aleksandra on 28/02/25.
//

import SwiftUI

struct PreferencesView: View {
    
    enum Age: String, CaseIterable, Identifiable {
        case kid, youngAdult, adult, viejo
        var id: Self { self }
    }
    
    enum Likes: String, CaseIterable, Identifiable {
        case history, engineering, nature, experiments, surprise
        var id: Self { self }
    }
    
    enum AccesibilityMode: String, CaseIterable, Identifiable {
        case full, eyes, ears, movement
        var id: Self { self }
    }
    
    @State private var selectedAge: Age = .kid
    
    @State private var selectedLikes: Likes = .history
    
    @State private var selectedAccesibilityMode: AccesibilityMode = .full
    
    @State private var UserName : String = ""
    
    var body: some View {
        
        
        
        HStack {
            TextField("Ingresa tu nombre: ", text: $UserName)
                .padding()
            Text(UserName)
                .font(.headline)
        }
        
        
        

        VStack {
            List {
                Picker(selection: $selectedAge) {
                    Text("Kid").tag(Age.kid)
                    Text("Young Adult / Student").tag(Age.youngAdult)
                    Text("Adult").tag(Age.adult)
                    Text("Grand").tag(Age.viejo)
                } label: {
                    Text("Age")
                    Text("Choose your age group")
                }
                
                Picker(selection: $selectedLikes) {
                    Text("History").tag(Likes.history)
                    Text("Engineering").tag(Likes.engineering)
                    Text("Nature").tag(Likes.nature)
                    Text("Experiments").tag(Likes.experiments)
                    Text("I don´t have any preference").tag(Likes.surprise)
                } label: {
                    Text("What do you like to see")
                    Text("Choose your interest")
                }
                
                Picker(selection: $selectedAccesibilityMode) {
                    Text("I don't need special attention").tag(AccesibilityMode.full)
                    Text("I cannot see ").tag(AccesibilityMode.eyes)
                    Text("Adult").tag(Age.adult)
                    Text("Grand").tag(Age.viejo)
                } label: {
                    Text("Any preferences?")
                    Text("Choose your age group")
                }
                
                Picker(selection: $selectedAge) {
                    Text("Kid").tag(Age.kid)
                    Text("Young Adult / Student").tag(Age.youngAdult)
                    Text("Adult").tag(Age.adult)
                    Text("Grand").tag(Age.viejo)
                } label: {
                    Text("IDK ")
                    Text("Choose your age group")
                }
                
                Picker(selection: $selectedAge) {
                    Text("Kid").tag(Age.kid)
                    Text("Young Adult / Student").tag(Age.youngAdult)
                    Text("Adult").tag(Age.adult)
                    Text("Grand").tag(Age.viejo)
                } label: {
                    Text("Que mas???")
                    Text("Choose your age group")
                }
            }
            
            
        }
    }
}

#Preview {
    PreferencesView()
}
