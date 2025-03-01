//
//  PreferencesView.swift
//  Horno3
//
//  Created by Alumno on 28/02/25.
//

import SwiftUI

struct PreferencesView: View {
    
    enum Age: String, CaseIterable, Identifiable {
        case kid, youngAdult, adult, viejo
        var id: Self { self }
    }
    @State private var selectedAge: Age = .kid
    
    @State private var UserName : String = ""
    
    var body: some View {
        
        TextField("Ingresa tu nombre: ", text: $UserName)
            .padding()
        
        Text(UserName)
            .font(.headline)
            .padding()

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
                
                Picker(selection: $selectedAge) {
                    Text("Kid").tag(Age.kid)
                    Text("Young Adult / Student").tag(Age.youngAdult)
                    Text("Adult").tag(Age.adult)
                    Text("Grand").tag(Age.viejo)
                } label: {
                    Text("What do you like to see")
                    Text("Choose your age group")
                }
                
                Picker(selection: $selectedAge) {
                    Text("Kid").tag(Age.kid)
                    Text("Young Adult / Student").tag(Age.youngAdult)
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
