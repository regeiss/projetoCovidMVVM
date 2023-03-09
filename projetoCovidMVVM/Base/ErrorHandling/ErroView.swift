//
//  ErroView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 08/03/23.
//

import SwiftUI

struct ErroView: View
{
    var erro: Error
    
    var body: some View
    {
        ZStack{
            Image("aviso").resizable().frame(width: 15,height: 15)
            Text(erro.localizedDescription)
        }
    }
}

