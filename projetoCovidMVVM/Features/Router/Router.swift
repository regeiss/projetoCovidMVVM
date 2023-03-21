//
//  Router.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/03/23.
//

//import Foundation
//import NavigationStack
//
//@available(iOS 16.0, *)
//final class MyRouter: ObservableObject
//{
//    let navStack: NavigationStackCompat
//    static let shared = MyRouter(navStack: ContentView.navigationStack)
//
//    var isEdit: Bool = false
//
//    private init(navStack: NavigationStackCompat)
//    {
//        self.navStack = navStack
//    }
//
//    func toMenu()
//    {
//        self.navStack.pop(to: .root)
//    }
//
//    func toArtigoPainelExtenso(artigo: ArtigoModelElement, relativeTime: String)
//    {
//        self.navStack.push(ArtigoPainelExtensoView(artigo: artigo, relativeTime: relativeTime))
//    }
//
////    func toPaisPainelExtenso(pais: PaisModelElement)
////    {
////        self.navStack.push(PaisPainelExtenso())
////    }
//
//    func toPainelArtigoCompacto(artigo: ArtigoModelElement)
//    {
//        self.navStack.push(ArtigoPainelCompactoView(artigo: artigo))
//    }
//
//
//}
