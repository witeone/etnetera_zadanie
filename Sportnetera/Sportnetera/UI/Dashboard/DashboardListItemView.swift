//
//  DashboardListItemView.swift
//  Sportnetera
//
//  Created by Marek Polak on 09/11/2024.
//

import SwiftUI

struct DashboardListItemView: View {
    var model: TrainingModel
    var body: some View {
        HStack {
            Circle()
                .frame(width: 10, height: 10)
                .foregroundStyle(model.isRemote ? .green : .yellow)

            VStack(alignment: .leading, spacing: 8) {
                Text(model.name)
                    .font(.headline)

                Text(model.location)
                    .font(.subheadline)

                Text(Date(timeIntervalSince1970: Double(model.date / 1000)).formatted())
                    .font(.caption)
            }

            Spacer()

            Text("\(model.length) min")
                .font(.title)
        }
    }
}

#Preview {
    DashboardListItemView(model: .init(id: "", name: "new", location: "home", length: 45, date: Date().millisecondsSince1970 * 1000, isRemote: true))
}
