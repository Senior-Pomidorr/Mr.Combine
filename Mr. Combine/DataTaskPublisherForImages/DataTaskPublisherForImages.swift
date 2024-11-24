//
//  DataTaskPublisherForImages.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 13.11.2024.
//

import Combine
import SwiftUICore
import UIKit

class DataTaskPublisherForImagesVM: ObservableObject {
    
    @Published var image: Image?
    @Published var error: ErrorForAlerts?
    var cancellabeles: Set<AnyCancellable> = []
    
    func fetch() {
        let url = URL(string: "https://static.rozetked.me/imager/main/uploads/iQ/iQXi89VFBRv2.webp?3")!
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .tryMap { data in
                guard let image = UIImage(data: data) else {
                    throw ErrorForAlerts(message: "Error for download image")
                }
                return Image(uiImage: image)
            }
            /*.replaceError(with: Image("blank.image")) If an error comes down the pipeline the
        replaceError operator will receive it
        and republish the blank image instead.*/
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    if error is ErrorForAlerts {
                        self.error = error as? ErrorForAlerts
                    } else {
                        self.error = ErrorForAlerts(message: "Details \(error.localizedDescription)")
                    }
                }
            } receiveValue: { [unowned self] value in
                self.image = value
            }
            .store(in: &cancellabeles)
    }
    
    deinit {
        print("Unloaded DataTask_ViewModel")
    }
}
