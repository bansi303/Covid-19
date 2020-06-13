//
//  CovidViewModel.swift
//  Covid-19
//
//  Created by bansi hirpara on 19/04/20.
//  Copyright © 2020 bansi hirpara. All rights reserved.
//

import UIKit
import CoreLocation

class CovidViewModel: NSObject {
    
    var currentLocation:((CLLocation)->())?
    let locationManager = LocationManager()
    var covidData:CovidData?
    var closetCoutryData: CovidCountryWiseData!
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func findClosetCoutryFromUserLocation(userLocation: CLLocation) -> CovidCountryWiseData{
        let closetCoutry = covidData?.areas.min(by: {
            CLLocation(latitude: $0.lat, longitude: $0.long).distance(from: userLocation) < CLLocation(latitude: $1.lat, longitude: $1.long).distance(from: userLocation)
        })
        return closetCoutry!
    }
}

//MARK: - Location Service Delegate

extension CovidViewModel: LocationServiceDelegate {
    func currentLocation(location: CLLocation) {
        if let currentLocation = self.currentLocation {
            self.closetCoutryData = self.findClosetCoutryFromUserLocation(userLocation: location)
            currentLocation(location)
        }
    }
}

//MARK: - Service call

extension CovidViewModel {
    func callFetchCovidDataAPI(onSuccess: @escaping (()->()), onFailure: @escaping ((String)->())){
        NetworkManager.sharedInstance.fetchCovidData(urlEndPoint: "", params: nil, onSuccess: { (responseData) in
            if let covidData = try? JSONDecoder().decode(CovidData.self, from: responseData) {
                self.covidData = covidData
                onSuccess()
            }
            else {
                print("Error in decode data")
                onFailure("Error in decode data")
            }
        }) { (errorString) in
            onFailure(errorString)
        }
    }
}
