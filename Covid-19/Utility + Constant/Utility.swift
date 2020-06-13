//
//  Utility.swift
//  Weather
//
//  Created by Student on 2020-04-05.
//  Copyright © 2020 Student. All rights reserved.
//

import UIKit

class Utility{
    static let sharedInstance = Utility()
    
    func readDataFromJSON(fromm filename: String) -> Data?{
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  return data
              } catch {
                   // handle error
              }
        }
        return nil
    }
}
