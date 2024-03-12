//
//  ZipView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/12/24.
//

import SwiftUI

struct ZipView: View {
    @StateObject private var vm = Zip()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("Zip",
                           subtitle: "Introduction",
                           desc: "You can combine multiple pipelines and pair up the values from each one and do something with them using the zip operator.")
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 200))]) {
                    ForEach(vm.dataToVIew) { arts in
                        VStack {
                            Image(arts.artist)
                                .resizable()
                                .scaledToFit()
                            Text(arts.artist)
                                .font(.body)
                        }
                        .padding(4)
                        .background(arts.color.opacity(0.5))
                        .frame(height: 150)
                    }
                }
                .padding(.horizontal)
                Spacer(minLength: 0)
            }
            .font(.title)
            .onAppear() {
                vm.fetch()
            }
        }
    }
}

#Preview {
    ZipView()
}
