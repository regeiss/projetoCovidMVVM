//
//  MundialPainelView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 13/03/23.
//

import SwiftUI

struct MundialPainelView: View
{
    var mundialData: MundialModel
    var updated: String
    
    var body: some View
    {
         VStack(alignment: .leading)
        {
             VStack(alignment: .leading)
             {
                 HStack(alignment: .top)
                 {
                     VStack(alignment: .leading)
                     {
                         
                         VStack(alignment: .leading, spacing: 2)
                         {
                             Text("Mundial")
                                 .font(.system(size: 20))
                                 .fontWeight(.regular)
                                 .padding(.bottom, 6)
                             
                             HStack
                             {
                                 Text("Daily Growth Rate")
                                     .font(.system(size: 14))
                                     .fontWeight(.light)
                                 Text(String(mundialData.activePerOneMillion))
                                     .font(.system(size: 14))
                                     .fontWeight(.regular)
                             }
                             
                             HStack
                             {
                                 Text("14 Days Growth Rate")
                                     .font(.system(size: 14))
                                     .fontWeight(.light)
                                 Text(String(mundialData.casesPerOneMillion))
                                     .font(.system(size: 14))
                                     .fontWeight(.regular)
                             }
                             
                             HStack
                             {
                                 Text("Fatality")
                                     .font(.system(size: 14))
                                     .fontWeight(.light)
                                 Text(String(mundialData.deaths))
                                     .font(.system(size: 14))
                                     .fontWeight(.regular)
                             }
                         }
                     }
                     
                     Spacer()
                     
                     VStack(alignment: .trailing)
                     {
                         Text("\(mundialData.cases)")
                             .font(.system(size: 28))
                             .fontWeight(.light)
                         Text("in total")
                             .font(.system(size: 12))
                             .fontWeight(.light)
                         Text("\(mundialData.casesPerOneMillion)")
                             .font(.system(size: 22))
                             .fontWeight(.light)
                         Text("new cases")
                             .font(.system(size: 12))
                             .fontWeight(.light)
                     }
                 }
                 .padding(.bottom, 3)
                 
                 HStack
                 {
                     VStack
                     {
                         HStack
                         {
                             Text("Cases")
                                 .font(.system(size: 12))
                                 .fontWeight(.light)
                                 .lineLimit(1)
                             Spacer()
                             Text("\(mundialData.cases)")
                                 .font(.system(size: 12))
                                 .fontWeight(.light)
                                 .lineLimit(1)
                         }
                         Rectangle()
                             .foregroundColor(Color("casesColor"))
                             .frame(height: 2)
                     }
                     VStack
                     {
                         HStack
                         {
                             Text("Deaths")
                                 .font(.system(size: 12))
                                 .fontWeight(.light)
                                 .lineLimit(1)
                             Spacer()
                             Text("\(mundialData.deaths)")
                                 .font(.system(size: 12))
                                 .fontWeight(.light)
                                 .lineLimit(1)
                         }
                         Rectangle()
                             .foregroundColor(Color("deathsColor"))
                             .frame(height: 2)
                     }
                     VStack
                     {
                         HStack
                         {
                             Text("Recovered")
                                 .font(.system(size: 12))
                                 .fontWeight(.light)
                                 .lineLimit(1)
                             Spacer()
                             
                                 Text("\(mundialData.recovered)")
                                     .font(.system(size: 12))
                                     .fontWeight(.light)
                                     .lineLimit(1)
 
                         }
                         Rectangle()
                             .foregroundColor(Color("recoveredColor"))
                             .frame(height: 2)
                     }
                 }
                 
             }
             .padding()
            Text(updated).font(.footnote)
                .padding()
         }
         .placeCardStyle()
        Spacer()
     }
 }
