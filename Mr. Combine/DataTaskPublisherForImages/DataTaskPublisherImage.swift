//
//  DataTaskPublisherImage.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 13.11.2024.
//

import SwiftUI

struct DataTaskPublisherImage: View {
    @StateObject private var vm = DataTaskPublisherForImagesVM()
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("DataTaskPublisher",
                       subtitle: "For Images",
                       desc: "You can use the dataTaskPublisher operator to download images with a URL.")
            vm.image?
                .resizable()
                .scaledToFit()
            Spacer()
        }
        .font(.title)
        .onAppear {
            vm.fetch()
        }
        .alert(item: $vm.error) { errorForAlert in
            Alert(title: Text(errorForAlert.title),
                  message: Text(errorForAlert.message))
        }
    }
}
    
    #Preview {
        DataTaskPublisherImage()
    }
