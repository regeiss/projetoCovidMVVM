//
//  OnboardingView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 10/04/23.
//

import SwiftUI
import ConcentricOnboarding

struct OnboardingView: View
{
    @State private var currentIndex: Int = 0
    var body: some View
    {
        ConcentricOnboardingView(pageContents: OnboardingData.pages.map { (OnboardingPageView(page: $0), $0.color) })
            .nextIcon("chevron.forward")
            .animationDidEnd {
                print("Animation Did End")
            }
    }
}
