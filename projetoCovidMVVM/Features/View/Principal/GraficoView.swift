//
//  GraficoView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 26/02/23.
//

import SwiftUI

struct GraficoView: View {
    var body: some View {
    {
        VStack
        {
            HeaderView(nomeView: "Gráficos", nomeMenu: "Menu")

            List
            {
                Chart
                {
                    BarMark(
                        x: .value("Mount", "jan/22"),
                        y: .value("Value", 5)
                    )
                    BarMark(
                        x: .value("Mount", "fev/22"),
                        y: .value("Value", 4)
                    )
                    BarMark(
                        x: .value("Mount", "mar/22"),
                        y: .value("Value", 7)
                    )
                }
                .frame(height: 250)
            }
        }
    }
}
