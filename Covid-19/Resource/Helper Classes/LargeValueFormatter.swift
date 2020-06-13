//

//  ChartsDemo-OSX
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  Copyright © 2017 thierry Hentic.
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/ios-charts
//  https://en.wikipedia.org/wiki/Metric_prefix

import Foundation
import Charts

open class LargeValueFormatter: NSObject, IValueFormatter, IAxisValueFormatter
{

    public override init()
    {
    }

    fileprivate func format(value: Double) -> String
    {
        let number = round(value)
        let thousand = number / 1000
        let million = number / 1000000
        let billion = number / 1000000000

        if billion >= 1.0 {
            return "\(round(billion*10)/10)B"
        } else if million >= 1.0 {
            return "\(round(million*10)/10)M"
        } else if thousand >= 1.0 {
            return ("\(round(thousand*10/10))K")
        } else {
            return "\(Int(number))"
        }
    }
    
    open func stringForValue( _ value: Double, axis: AxisBase?) -> String
    {
        return format(value: value)
    }
    
    open func stringForValue(
        _ value: Double,
        entry: ChartDataEntry,
        dataSetIndex: Int,
        viewPortHandler: ViewPortHandler?) -> String
    {
        return format(value: value)
    }
}

