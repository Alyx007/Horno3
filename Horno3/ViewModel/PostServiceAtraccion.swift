//
//  PostService.swift
//  Horno3
//
//  Created by Alumno on 04/05/25.
//


import Foundation

class PostService {
    private let baseURL = "http://10.22.24.25:3005/users"
    
    func fetchUsuarios() async throws -> [Usuario] {
        guard let url = URL(string: baseURL+"/") else {
            throw PostError.requestError(description: "Bad URL")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw PostError.requestError(description: "Bas response")
        }
        
        guard response.statusCode == 200 else {
            throw PostError.badStatusCode(code: response.statusCode)
        }
        
        do{
            let usuarios = try JSONDecoder().decode(RespAPI.self, from: data)
            
            return usuarios.users
            
        } catch {
            throw PostError.unknownError(error: error)
            
        }
        
    }
}
