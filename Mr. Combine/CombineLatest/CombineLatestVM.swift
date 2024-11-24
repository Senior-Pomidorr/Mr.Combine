//
//  CombineLatest.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/11/24.
//

import Foundation
import Combine
import SwiftUI


struct ArtData: Identifiable {
    let id = UUID()
    let artist: String
    let color: Color
    let numbers: Int
}

//«Using the combineLastest operator you can connect two or more pipelines and then use a closure to process the latest data received from each publisher in some way. There is also a combineLatest to connect 3 or even 4 pipelines together. You will still have just one pipeline after connecting all of the publishers.

final class CombineLatestVM: ObservableObject {
    @Published var artData = ArtData(artist: "", color: .clear, numbers: 0)
    private var cancellable: AnyCancellable?
    
    func fetch() {
        let artist = ["Picasso", "Michelangelo", "van Gogh", "da Vinci", "Monet"].randomElement().publisher
        let colors = [Color.red, Color.orange, Color.blue, Color.purple, Color.green].publisher
        let numbers = [1, 2, 3].publisher
        
        cancellable = artist
            .combineLatest(colors, numbers) { (artist, color, numbers) in
                return ArtData(artist: artist, color: color, numbers: numbers)
            }
            .sink(receiveValue: { [unowned self] value in
                self.artData = value
            })
        print(artData)
    }
    
    deinit {
        cancellable?.cancel()
    }
}
