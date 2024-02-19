//
//  HeaderView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI

struct HeaderView: View {
    var title = "Title"
    var subtitle = "Subtitle"
    var desc = "Use this to..."
    init(_ title: String, subtitle: String, desc: String) {
        self.title = title
        self.subtitle = subtitle
        self.desc = desc
    }
    var body: some View {
        VStack(spacing: 15) {
            if !title.isEmpty {
                Text(title)
                    .font(.largeTitle)
            }
            Text(subtitle)
                .foregroundStyle(.gray)
            DescView(desc)
        }
    }}

struct DescView: View {
    var desc = "Use this to..."
    init(_ desc: String) {
        self.desc = desc
    }
    var body: some View {
        Text(desc)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundStyle(.white)
}}

