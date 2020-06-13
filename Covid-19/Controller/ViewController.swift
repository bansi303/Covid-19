//
//  ViewController.swift
//  Covid-19
//
//  Created by bansi hirpara on 16/04/20.
//  Copyright © 2020 bansi hirpara. All rights reserved.
//

import UIKit
import SwiftGifOrigin
import Charts

class ViewController: UIViewController {
    
    @IBOutlet weak var lblGlobalConfirmedCase: UILabel!
    @IBOutlet weak var lblGlobalRecoveredCase: UILabel!
    @IBOutlet weak var lblGlobalDeath: UILabel!
    @IBOutlet weak var lblGlobalRecoveredCaseRate: UILabel!
    @IBOutlet weak var lblGlobalDeathRate: UILabel!
    @IBOutlet weak var lblNearestCoutry: UILabel!
    @IBOutlet weak var lblNearestCoutryConfirmedCase: UILabel!
    @IBOutlet weak var lblNearestCoutryRecoveredCase: UILabel!
    @IBOutlet weak var lblNearestCoutryDeath: UILabel!
    @IBOutlet weak var imgViewLogoAnimation: UIImageView!
    @IBOutlet weak var viewBarChart: HorizontalBarChartView!
    
    let covidViewModel: CovidViewModel = {
        return CovidViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.async {
            self.imgViewLogoAnimation.loadGif(name: "logo")            
        }
        
        self.covidViewModel.callFetchCovidDataAPI(onSuccess: {
            self.configureBarChart()
            self.lblGlobalConfirmedCase.text = "\(self.covidViewModel.covidData!.totalConfirmed.withCommas())"
            self.lblGlobalRecoveredCase.text = "\(self.covidViewModel.covidData!.totalRecovered.withCommas())"
            self.lblGlobalDeath.text = "\(self.covidViewModel.covidData!.totalDeaths.withCommas())"
            self.lblGlobalRecoveredCaseRate.text = String.init(format: "%.2f %%", (Double(self.covidViewModel.covidData!.totalRecovered) / Double(self.covidViewModel.covidData!.totalConfirmed)) * 100)
            
            self.lblGlobalDeathRate.text = String.init(format: "%.2f %%", (Double(self.covidViewModel.covidData!.totalDeaths) / Double(self.covidViewModel.covidData!.totalConfirmed)) * 100)
            
            self.covidViewModel.currentLocation = {(currentLocation) in
                self.lblNearestCoutry.text = "\(self.covidViewModel.closetCoutryData.displayName)"
                self.lblNearestCoutryConfirmedCase.text = "\(self.covidViewModel.closetCoutryData.totalConfirmed!.withCommas())"
                self.lblNearestCoutryRecoveredCase.text = "\(self.covidViewModel.closetCoutryData.totalRecovered!.withCommas())"
                self.lblNearestCoutryDeath.text = "\(self.covidViewModel.closetCoutryData.totalDeaths!.withCommas())"
            }
            self.covidViewModel.locationManager.startUpdatingLocation()
        }) { (errorString) in
            
        }
    }
    
    @IBAction func onShowMapBtnClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showMap", sender: nil)
    }
    
    func configureBarChart(){
        
        let confirmedBar = BarChartDataEntry(x: 1, y: Double(covidViewModel.covidData!.totalConfirmed))
        let recoveredBar = BarChartDataEntry(x: 2, y: Double(covidViewModel.covidData!.totalRecovered))
        let deathBar = BarChartDataEntry(x: 3, y: Double(covidViewModel.covidData!.totalDeaths))
        
        let confirmedBarChartsDataSet = BarChartDataSet.init(entries: [confirmedBar], label: "Confirmed")
        confirmedBarChartsDataSet.colors = [.blue]
        confirmedBarChartsDataSet.drawValuesEnabled = true
        
        let recoveredBarChartsDataSet = BarChartDataSet.init(entries: [recoveredBar], label: "Recovered")
        recoveredBarChartsDataSet.colors = [.green]
        
        let deathsBarChartsDataSet = BarChartDataSet.init(entries: [deathBar], label: "Death")
        deathsBarChartsDataSet.colors = [.red]
        
        let xaxis = viewBarChart.xAxis
        xaxis.drawGridLinesEnabled = false
        xaxis.drawAxisLineEnabled = false
        xaxis.drawLabelsEnabled = false
        viewBarChart.setExtraOffsets(left: 0, top: 0, right: -20, bottom: 0)
        
        viewBarChart.leftAxis.drawLabelsEnabled = false
        viewBarChart.leftAxis.drawGridLinesEnabled = false
        viewBarChart.leftAxis.drawAxisLineEnabled = false
        
        viewBarChart.rightAxis.drawGridLinesEnabled = false
        viewBarChart.rightAxis.valueFormatter = LargeValueFormatter()
        viewBarChart.rightAxis.labelPosition = .outsideChart
        
        let limitLine = ChartLimitLine(limit: 0, label: "")
        limitLine.lineColor = UIColor.gray
        limitLine.lineWidth = 0.5
        
        viewBarChart.rightAxis.addLimitLine(limitLine)
        viewBarChart.backgroundColor = UIColor.white
        viewBarChart.data = BarChartData(dataSets: [confirmedBarChartsDataSet, recoveredBarChartsDataSet, deathsBarChartsDataSet])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier?.elementsEqual("showMap"))!{
            let destination = segue.destination as! MapViewController
            destination.covidData = covidViewModel.covidData
            destination.closetCoutryData = covidViewModel.closetCoutryData
        }
    }
    
}

