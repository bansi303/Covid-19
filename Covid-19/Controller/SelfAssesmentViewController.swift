//
//  SelfAssesmentViewController.swift
//  Covid-19
//
//  Created by Student on 2020-04-21.
//  Copyright © 2020 bansi hirpara. All rights reserved.
//

import UIKit

class SelfAssesmentViewController: UIViewController {
    
    var questionCounter = 0
    var arrJsonDataOfSelfAssesment = [InstructionsAndQuestionData]()
    
    @IBOutlet weak var collectionViewSelfAssesmentQuestions: UICollectionView!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let jsonData = (Utility.sharedInstance.readDataFromJSON(fromm: "SelfAssesmentQuestions")){
            if let instructionsData = try? JSONDecoder().decode([InstructionsAndQuestionData].self, from: jsonData) {
                self.arrJsonDataOfSelfAssesment = instructionsData
            }
            else {
                print("Error in decode data")
            }
        }
        
    }
    
    @IBAction func onNoBtnClicked(_ sender: UIButton) {
        if (questionCounter + 1) < arrJsonDataOfSelfAssesment.count{
            questionCounter = questionCounter + 1
            collectionViewSelfAssesmentQuestions.scrollToItem(at: IndexPath(row: questionCounter, section: 0), at: UICollectionView.ScrollPosition.right, animated: true)
        }
        else{
            self.showAlert(alertTitle: "Stay home!! Stay safe!!", alertMessage: "You do not need to contact a doctor for an assessment.", okBtnTitle: "Ok") {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func onYesBtnClicked(_ sender: UIButton) {
        if questionCounter == 0 {
            self.showAlert(alertTitle: "Emergency", alertMessage: "Go directly to your nearest emergency department.", okBtnTitle: "Ok") {
                self.navigationController?.popViewController(animated: true)
            }
        }
        else if questionCounter == 1{
            self.showAlert(alertTitle: "Emergency", alertMessage: "Go directly to your nearest emergency department.", okBtnTitle: "Ok") {
                self.navigationController?.popViewController(animated: true)
            }
        }
        else{
            self.showAlert(alertTitle: "Alert", alertMessage: "You must immediately self-isolate. You may need to be tested for COVID-19.", okBtnTitle: "Ok") {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func onBackBtnClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

class SelfAssesmentQuestionsCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblQuestionDescription: UILabel!
    
    func configureCell(cellData: InstructionsAndQuestionData){
        self.lblQuestion.text = cellData.title
        self.lblQuestionDescription.text = cellData.desc
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        return layoutAttributes
    }
}

extension SelfAssesmentViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrJsonDataOfSelfAssesment.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelfAssesmentQuestionsCollectionViewCell", for: indexPath) as! SelfAssesmentQuestionsCollectionViewCell
        cell.configureCell(cellData: arrJsonDataOfSelfAssesment[indexPath.row])
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


