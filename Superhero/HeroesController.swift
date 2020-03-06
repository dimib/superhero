//
//  HeroesController.swift
//  Superhero
//
//  Created by Dimitrios Brukakis on 05.03.20.
//  Copyright © 2020 Dimitri Brukakis. All rights reserved.
//

import Foundation
import Combine


class HeroesController: ObservableObject {
    
    @Published var heroes: [SuperHero] = []
    
    var subscriptions: Set<AnyCancellable> = []
    
    init() {
        let api = "https://superheroapi.com/api/10212964155778411/search/spider"
        
        URLSession.shared.dataTaskPublisher(for: URL(string: api)!).tryMap { (data: Data, response: URLResponse) in
            if let http = response as? HTTPURLResponse {
                precondition(http.statusCode == 200)
            }
            return data
            
        }.decode(type: SearchResult.self, decoder: JSONDecoder()).map(\.results).catch { _ in
            Just([])
        }.receive(on: DispatchQueue.main).assign(to: \.heroes, on: self).store(in: &subscriptions)
    }
    
}
