//
//  ReceiveOnVM.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/9/24.
//

import Foundation
import Combine
import SwiftUI

struct ErrorForAlert: Error, Identifiable {
    var id = UUID()
    var description = ""
}

final class ReceiveOnVM: ObservableObject {
    @Published var imageView = Image("blank.image")
    @Published var errorForAlert: ErrorForAlert?
    var cancellabeles: Set<AnyCancellable> = .init()
    
    func fetch() {
        let url = URL(string: "https://http.cat/401")!
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .tryMap { data in
                guard let image = UIImage(data: data) else {
                    throw ErrorForAlert()
                }
                return Image(uiImage: image)
            }
            .receive(on: RunLoop.main)
            .sink { [unowned self] completion in
                if case .failure(let error) = completion {
                    if error is ErrorForAlert {
                        errorForAlert = error as? ErrorForAlert
                    } else {
                        errorForAlert = ErrorForAlert(description: "Details: \(error.localizedDescription)")
                    }
                }
            } receiveValue: { [unowned self] image in
                imageView = image
            }
            .store(in: &cancellabeles)
    }
}
