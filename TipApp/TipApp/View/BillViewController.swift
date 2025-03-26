//
//  ViewController.swift
//  TipApp
//
//  Created by Jeanette on 1/25/25.
//  

import UIKit

class BillViewController: UIViewController, UITextFieldDelegate {
    
    private var billViewModel = BillViewModel()
    private var currentButton: UIButton = UIButton()
    private var buttonArray: [UIButton] = []
    private var totalPeopleLabel = LabelFactory.createTextLabel(text: "2")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        bindViewModel()
    }
    
    private func setupView() {
        enterBillTotalTextField.delegate = self
        view.layoutMargins = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        let buttonOne = ButtonFactory.createButton(title: "0.0")
        let buttonTwo = ButtonFactory.createButton(title: "10.0")
        let buttonThree = ButtonFactory.createButton(title: "20.0")
        
        buttonArray.append(buttonOne)
        buttonArray.append(buttonTwo)
        buttonArray.append(buttonThree)
        
        currentButton = buttonOne
        
        let calculateUIButton = ButtonFactory.createButton(title: "Calculate")
        calculateUIButton.backgroundColor = Constants.calculateButtonColor
        calculateUIButton.setTitleColor(.black, for: .normal)
        calculateUIButton.addTarget(self, action: #selector(calculatePressed), for: .touchUpInside)
        
        
        let enterBillTotalLabel = LabelFactory.createTextLabel(text: "Enter bill total")
        enterBillTotalLabel.textAlignment = .left
        let chooseSplitLabel = LabelFactory.createTextLabel(text: "Choose Split")
        chooseSplitLabel.textAlignment = .left
        let selectTipLabel = LabelFactory.createTextLabel(text: "Select tip")
        selectTipLabel.textAlignment = .left
    
//        view.backgroundColor = .white
        let gradientLayer = Utility.createGradientBG(view: view)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        
        view.addSubview(billStackView)
        view.addSubview(tipControllerSubview)
        view.addSubview(calculateUIButton)
        
        tipControllerSubview.addSubview(selectTipStackView)
        selectTipStackView.addArrangedSubview(selectTipLabel)
        
        //enter bill total
        billStackView.addArrangedSubview(enterBillTotalLabel)
        billStackView.addArrangedSubview(enterBillTotalTextField)
        
        //select tip percentage
        selectTipStackView.addArrangedSubview(tipPercentageButtonStackView)
        tipPercentageButtonStackView.addArrangedSubview(buttonOne)
        tipPercentageButtonStackView.addArrangedSubview(buttonTwo)
        tipPercentageButtonStackView.addArrangedSubview(buttonThree)
        selectTipStackView.addArrangedSubview(chooseSplitLabel)
        
        //choose split
        selectTipStackView.addArrangedSubview(chooseSplitStackView)
        chooseSplitStackView.addArrangedSubview(totalPeopleLabel)
        chooseSplitStackView.addArrangedSubview(stepper)
        
        billStackView.translatesAutoresizingMaskIntoConstraints = false
        tipControllerSubview.translatesAutoresizingMaskIntoConstraints = false
        selectTipStackView.translatesAutoresizingMaskIntoConstraints = false
        tipPercentageButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        chooseSplitStackView.translatesAutoresizingMaskIntoConstraints = false
        calculateUIButton.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tipControllerSubview.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tipControllerSubview.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tipControllerSubview.topAnchor.constraint(equalTo: billStackView.bottomAnchor),
            tipControllerSubview.heightAnchor.constraint(equalTo: view.heightAnchor),
            tipControllerSubview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            tipPercentageButtonStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tipPercentageButtonStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            chooseSplitStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            chooseSplitStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
           
        ])

        NSLayoutConstraint.activate([
            billStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            billStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            billStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            billStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            billStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            enterBillTotalTextField.centerXAnchor.constraint(equalTo: billStackView.centerXAnchor),
            enterBillTotalLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            enterBillTotalLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            calculateUIButton.topAnchor.constraint(equalTo: tipControllerSubview.bottomAnchor),
            calculateUIButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            calculateUIButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            calculateUIButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calculateUIButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
            
        ])
        
        NSLayoutConstraint.activate([
            selectTipStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            selectTipStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            selectTipStackView.topAnchor.constraint(equalTo: enterBillTotalTextField.bottomAnchor, constant: 30),
        ])
        
        
        setupActions()
    }
    /** Enter Bill View
     View
     - Subview
            - Select Tip Stack View x
                - Select Tip Label: UILabel x
                - Tip Percentage Stack View x
                    - 0%, 10%, 20% Button: UIButton x 3 x
                - Choose Split Label: UILabel x
                - Stack View x
                    - Total People Label: UILabel x
                    - Stepper: UIStepper x
     - Bill Stack View
            - Enter Bill Total Label: UILabel x
            - Enter Total Text Field: UITextFieldx
     - Calculate: UIButton
     
     */
    
    private func setupActions() {
        buttonArray.forEach { button in
            button.addTarget(self, action: #selector(tipSelected(_:)), for: .touchUpInside)
        }
        
        stepper.addTarget(self, action: #selector(updatePartyCount(_:)), for: .valueChanged)
    }
    
    private func bindViewModel() {
        billViewModel.onPartyCountUpdated = { [weak self] updatedValue in
            self?.totalPeopleLabel.text = String(updatedValue)
            
        }
    }
    
    @objc private func calculatePressed() {
        print("pressed")
        //create instance of view controller
        let resultVC = ResultViewController()
        
        //assign view controller label values to values from view model
        resultVC.totalPerPersonValue = billViewModel.totalPerPerson
        resultVC.splitBetweenPeopleText = billViewModel.resultSummary
  
        //present view controller
        if #available(iOS 15.0, *) {
            if let sheet = resultVC.sheetPresentationController {
                if #available(iOS 16.0, *) {
                    sheet.detents = [
                        .custom { context in
                            return context.maximumDetentValue
                        }
                    ]
                    sheet.prefersGrabberVisible = true
                } else {
                    // Fallback on earlier versions
                    print("os is too old")
                }
            }
        } else {
            // Fallback on earlier versions
            print("os is too old")
        }
        present(resultVC, animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if validateAmount(newText) {
            billViewModel.billFieldTotal = newText
            print(billViewModel.billFieldTotal)
            return true
        }
        else {
            return false
        }
        
    }

    private func validateAmount(_ text: String) -> Bool {
        let regex = "^(\\d*\\.?\\d{0,2})$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return predicate.evaluate(with: text)
    }
    
//    @objc private func updateBillTotal(_ sender: UITextField) {
//        guard let billTotalText = sender.text else {return}
//        billViewModel.billFieldTotal = billTotalText
//        print(billViewModel.billFieldTotal)
//    }
    
    @objc private func updatePartyCount(_ sender: UIStepper) {
        
//        guard let sender.value else {return}
        billViewModel.partyCount = Int(sender.value)
        
        print(billViewModel.partyCount)
    }
    
    @objc private func tipSelected(_ sender: UIButton) {
//        billViewModel.tipPercentage = sender.titleLabel?.text
        guard let label = sender.titleLabel else {return}
        guard let tipPercentageText = label.text else {return}
        guard let tipPercentage = Float(tipPercentageText) else {return}
        
        billViewModel.tipPercentage = tipPercentage
        print(billViewModel.tipPercentage)
        updateUIForSelectedButton(sender)
        
        
    }

    private func updateUIForSelectedButton(_ sender: UIButton) {
        currentButton.backgroundColor = .clear
        currentButton.setTitleColor(Constants.tipColor, for: .normal)
        
        for button in buttonArray where button == sender {
            button.backgroundColor = Constants.tipColor
            button.setTitleColor(.white, for: .normal)
            currentButton = button
        }
    }

    private let tipControllerSubview: UIView = {
        let tipControllerSubview = UIView()
//        tipControllerSubview.backgroundColor = Constants.chooseSplitColor
        
        return tipControllerSubview
    }()

    private let selectTipStackView: UIStackView = {
        let selectTipStackView = UIStackView()
        selectTipStackView.axis = .vertical
//        selectTipStackView.backgroundColor = Constants.selectTipTotalColor
        
        selectTipStackView.alignment = .fill
        selectTipStackView.distribution = .equalSpacing
        selectTipStackView.spacing = 25
        
        return selectTipStackView
    }()
    
    private let tipPercentageButtonStackView: UIStackView = {
        let tipPercentageButtonStackView = UIStackView()
        tipPercentageButtonStackView.axis = .horizontal
        tipPercentageButtonStackView.alignment = .center
        tipPercentageButtonStackView.spacing = 15
        tipPercentageButtonStackView.distribution = .fillEqually
        
        
        return tipPercentageButtonStackView
    }()
    
   
    
    private let chooseSplitStackView: UIStackView = {
        let chooseSplitStackView = UIStackView()
        chooseSplitStackView.axis = .horizontal
        chooseSplitStackView.backgroundColor = Constants.topGradientColor
       
        chooseSplitStackView.alignment = .center
        chooseSplitStackView.distribution = .fillEqually
        chooseSplitStackView.layer.cornerRadius = 15
        chooseSplitStackView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        return chooseSplitStackView
    }()
    
    private let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.value = 2
        stepper.stepValue = 1
        stepper.minimumValue = 1
        stepper.maximumValue = 30
        
        return stepper
    }()
    
    private let billStackView: UIStackView = {
        let billStackView = UIStackView()
        billStackView.axis = .vertical
//        billStackView.backgroundColor = Constants.enterBillTotalColor
        
        billStackView.alignment = .leading
        billStackView.distribution = .fillProportionally
        billStackView.spacing = 0
        
        return billStackView
    }()
    
    private let enterBillTotalTextField: NonPastingTextField = {
        let enterBillTotalTextField = NonPastingTextField()
        enterBillTotalTextField.placeholder = "e.g 123.56"
        enterBillTotalTextField.backgroundColor = Constants.textFieldColor
        enterBillTotalTextField.textAlignment = .center
        enterBillTotalTextField.keyboardType = .decimalPad
        enterBillTotalTextField.tintColor = Constants.bottomGradientColor
        
        
        return enterBillTotalTextField
    }()
}
