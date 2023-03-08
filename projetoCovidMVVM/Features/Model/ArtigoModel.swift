//
//  ArtigoModel.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 07/03/23.
//

import Foundation

struct ArtigoModel: Codable
{
    let source: Source
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
}

struct Source: Codable
{
    let id: String
    let name: String
}
