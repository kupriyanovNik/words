//
//  NetworkManager.swift
//  words
//
//  Created by Никита Куприянов on 29.03.2023.
//

import Foundation
import SwiftUI

class NetworkManager: ObservableObject {
    @Published var facts: [Message] = [.init(message: "let's get started", from: .api)]
    func fetch() {
        let url = "https://catfact.ninja/fact"
        var request = URLRequest(url: URL(string: url)!, timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error {
                    print(error.localizedDescription)
                }
                let adata = try? JSONDecoder().decode(Fact.self, from: data!)
                withAnimation {
                    self?.facts.append(.init(message: adata?.fact ?? "error", from: .api))
                }
            }
        }
        task.resume()
    }
    
}

enum Who {
    case me, api
}

struct Message: Identifiable {
    let id = UUID()
    let message: String
    let from: Who
}
