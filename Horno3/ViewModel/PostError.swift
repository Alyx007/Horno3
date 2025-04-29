//
//  PostError.swift
//  Horno3
//
//  Created and modified by Aleksandra on 28/04/25.
//  Autores: Leonardo Gonzalez y Rafael Rivas

import Foundation

enum PostError: Error {
    case invalidData
    case requestError(description: String)
    case badStatusCode(code:Int)
    case failedParsing
    case unknownError(error: Error)
    
    case invalidURL
    case unauthorized
    case rateLimited
    case networkUnavailable
    case supabaseError(message: Error)
    case emptyResponse
    case invalidCredentials
    case sessionExpired
    
    
    var customDescription: String {
        switch self {
        case .invalidData:
            return "Datos invalidos"
        case .requestError(let description):
            return "Request fallida \(description)"
        case .badStatusCode(let code):
            return "Request fallida con status \(code)"
        case .failedParsing:
            return "Error al parseo del JSON"
        case .unknownError(let error):
            return "Error desconocido \(error.localizedDescription)"
            
        case .invalidURL:
            return "URL inválida"
        case .unauthorized:
            return "No autorizado - por favor inicie sesión nuevamente"
        case .rateLimited:
            return "Demasiadas solicitudes - intente nuevamente más tarde"
        case .networkUnavailable:
            return "Red no disponible - verifique su conexión a internet"
        case .supabaseError(let message):
            return "Error de Supabase: \(message.localizedDescription)"
        case .emptyResponse:
            return "Respuesta vacía del servidor"
        case .invalidCredentials:
            return "Credenciales inválidas"
        case .sessionExpired:
            return "Sesión expirada"
        }
    }
}
