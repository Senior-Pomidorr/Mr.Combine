//
//  Zip.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/12/24.
//

import Foundation
import Combine
import SwiftUI

//«Using the zip operator you can connect two pipelines and then use a closure to process the data from each publisher in some way. There is also a zip3 and zip4 to connect even more pipelines together. You will still have just one pipeline after connecting all the pipelines that send down the data to your subscriber.»

final class Zip: ObservableObject {
    @Published var dataToVIew: [ArtData] = .init()
    let artist = ["Picasso", "Michelangelo", "van Gogh", "da Vinci", "Monet"]
    let colors = [Color.red, Color.orange, Color.blue, Color.purple, Color.green]
    
    func fetch() {
        _ = artist.publisher
            .zip(colors.publisher) { (artist, color) in
                return ArtData(artist: artist, color: color)
            }
            .sink(receiveValue: { [unowned self] value in
                dataToVIew.append(value)
            })
    }
}
