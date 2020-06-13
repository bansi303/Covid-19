//
//  Covid.swift
//  Covid-19
//
//  Created by bansi hirpara on 19/04/20.
//  Copyright © 2020 bansi hirpara. All rights reserved.
//

struct CovidData: Codable {
    let totalConfirmed: Int
    let totalDeaths: Int
    let totalRecovered: Int
    let totalRecoveredDelta: Int
    let totalDeathsDelta: Int
    let totalConfirmedDelta: Int
    let areas: [CovidCountryWiseData]
}

struct CovidCountryWiseData: Codable {
    let displayName: String
    let totalConfirmed: Int?
    let totalDeaths: Int?
    let totalRecovered: Int?
    let totalRecoveredDelta: Int?
    let totalDeathsDelta: Int?
    let totalConfirmedDelta: Int?
    let lat: Double
    let long: Double
}

struct InstructionsAndQuestionData: Codable {
    let title: String
    let desc: String
    let image: String
}
