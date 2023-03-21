//
//  MundialSeriesModel.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 20/03/23.
//

import Foundation

struct MundialSeriesModel: Codable
{
    let cases: [String: Int]
    let deaths: [String: Int]
    let recovered: [String: Int]
}
