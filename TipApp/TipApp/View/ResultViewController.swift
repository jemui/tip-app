//
//  ResultViewController.swift
//  TipApp
//
//  Created by Jeanette on 1/25/25.
//  

import UIKit

class ResultViewController: UIViewController {
    
    private let totalPerPersonLabel = LabelFactory.createTextLabel(text: "Total per Person")
    private let totalPerPersonValueLabel = LabelFactory.createTextLabel(text: "")
    
    private let recalculateButton = ButtonFactory.createButton(title: "Recalculate")
    private let splitBetweenPeopleLabel = LabelFactory.createTextLabel(text: "")
    
    var totalPerPersonValue: Float = 0.0
    var splitBetweenPeopleText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        updateUI()
    }
    
    private func setupView() {

        view.backgroundColor = .white
        
        totalPerPersonLabel.text = String(totalPerPersonValue)
        splitBetweenPeopleLabel.text = splitBetweenPeopleText
        
        totalPerPersonLabel.textColor = .black
        splitBetweenPeopleLabel.textColor = .black
        
        totalPerPersonView.addSubview(totalPerPersonLabel)
        totalPerPersonView.addSubview(totalPerPersonValueLabel)
        view.addSubview(totalPerPersonView)
      
        view.addSubview(splitBetweenPeopleLabel)
        view.addSubview(recalculateButton)

        
        recalculateButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        recalculateButton.backgroundColor = .green
        recalculateButton.setTitleColor(.white, for: .normal)
        
        totalPerPersonLabel.translatesAutoresizingMaskIntoConstraints = false
        splitBetweenPeopleLabel.translatesAutoresizingMaskIntoConstraints = false
        recalculateButton.translatesAutoresizingMaskIntoConstraints = false
        totalPerPersonView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        totalPerPersonLabel.text = "Total per person"
        totalPerPersonValueLabel.text = "4.00"
        NSLayoutConstraint.activate([
            recalculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recalculateButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            totalPerPersonLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
            totalPerPersonValueLabel.topAnchor.constraint(equalTo: totalPerPersonLabel.bottomAnchor),
            splitBetweenPeopleLabel.topAnchor.constraint(equalTo: totalPerPersonValueLabel.bottomAnchor)
            
        ])
    }
    
    private func updateUI() {
        totalPerPersonLabel.text = "Total per person: \(totalPerPersonValue.asCurrency())"
        splitBetweenPeopleLabel.text = splitBetweenPeopleText
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    private let totalPerPersonView: UIView = {
        let totalPerPersonView = UIView()
        totalPerPersonView.backgroundColor = .darkGray
        
        return totalPerPersonView
    }()
    
    
    
    /** Result View
     View
     - Subview x
            - Total per Person Label: UILabel x
            - Total per person Value Label: UILabel x
     - Recalculate Button: UIButton x
     - Split between 2 People Label: UILabel x
     
     */
}
