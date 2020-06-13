//
//  AvoidInfectionViewController.swift
//  Covid-19
//
//  Created by Student on 2020-04-21.
//  Copyright © 2020 bansi hirpara. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class AvoidInfectionViewController: UIViewController {
    
    @IBOutlet weak var collectionViewAvoidInfectionSteps: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    var arrJsonDataOfInstructionsToAvoidInfection = [InstructionsAndQuestionData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let jsonData = (Utility.sharedInstance.readDataFromJSON(fromm: "InstructionsToAvoidInfection")){
            if let instructionsData = try? JSONDecoder().decode([InstructionsAndQuestionData].self, from: jsonData) {
                self.arrJsonDataOfInstructionsToAvoidInfection = instructionsData
            }
            else {
                print("Error in decode data")
            }
        }
        pageControl.numberOfPages = arrJsonDataOfInstructionsToAvoidInfection.count
        pageControl.currentPage = 0
        pageControl.hidesForSinglePage = true
    }
    
    @IBAction func onNextBtnClicked(_ sender: UIButton) {
        btnPrevious.isEnabled = true
        
        if (pageControl.currentPage + 1) <= arrJsonDataOfInstructionsToAvoidInfection.count{
            pageControl.currentPage = pageControl.currentPage + 1
            collectionViewAvoidInfectionSteps.scrollToItem(at: IndexPath(row: pageControl.currentPage, section: 0), at: UICollectionView.ScrollPosition.right, animated: true)
            
            ChangeBtnsState()
        }
    }
    
    @IBAction func onPreviousBtnClicked(_ sender: UIButton) {
        btnNext.isEnabled = true
        
        if (pageControl.currentPage - 1) >= 0{
            pageControl.currentPage = pageControl.currentPage - 1
            collectionViewAvoidInfectionSteps.scrollToItem(at: IndexPath(row: pageControl.currentPage, section: 0), at: UICollectionView.ScrollPosition.right, animated: true)
            
            ChangeBtnsState()
        }
    }
    
    @IBAction func onBackBtnClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func ChangeBtnsState(){
        btnNext.isEnabled = true
        btnPrevious.isEnabled = true
        
        if pageControl.currentPage == arrJsonDataOfInstructionsToAvoidInfection.count - 1{
            btnNext.isEnabled = false
        }
        else if pageControl.currentPage == 0{
            btnPrevious.isEnabled = false
        }
    }
}

class AvoidInfectionStepsCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var lblInstructionTitle: UILabel!
    @IBOutlet weak var lblInstructionDescription: UILabel!
    @IBOutlet weak var imgViewInstruction: UIImageView!
    
    func configureCell(cellData: InstructionsAndQuestionData){
        self.lblInstructionTitle.text = cellData.title
        self.lblInstructionDescription.text = cellData.desc
        self.imgViewInstruction.image = UIImage(named: cellData.image)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        return layoutAttributes
    }
}

extension AvoidInfectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrJsonDataOfInstructionsToAvoidInfection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvoidInfectionStepsCollectionViewCell", for: indexPath) as! AvoidInfectionStepsCollectionViewCell
        cell.configureCell(cellData: arrJsonDataOfInstructionsToAvoidInfection[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 10, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}

extension AvoidInfectionViewController: UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(collectionViewAvoidInfectionSteps.contentOffset.x) / Int(collectionViewAvoidInfectionSteps.frame.width)
        ChangeBtnsState()
    }
}
