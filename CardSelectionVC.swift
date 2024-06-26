//
//  CardSelectionVC.swift
//  CardWorkout
//
//  Created by Fen on 18/06/2024.
//

import UIKit

class CardSelectionVC: UIViewController {
//    création des differents elements de la view
    let cardImageView = UIImageView()
    let stopButton = CWButton(backgroundColor: .systemRed, title: "Stop!")
    let resetButton = CWButton(backgroundColor: .systemGreen, title: "Reset")
    let rulesButton = CWButton(backgroundColor: .systemBlue, title: "Rules")
    
    let cards : [UIImage] = CardDeck.allValues
    var timer : Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(showRandomCard), userInfo: nil, repeats: true)
    }
    
    @objc func stopTimer() {
        timer.invalidate()
    }
    
    @objc func resetTimer() {
        stopTimer()
        startTimer()
    }
    
    @objc func showRandomCard() {
        cardImageView.image = cards.randomElement()
    }
    func configureUI(){
        configureCardImageView()
        configureStopButton()
        configureResetButton()
        configureRulesButton()
    }
//    fonction pour configurer notre imageView
    func configureCardImageView(){
//        très important ! permet d'ajouter image view à la view
        view.addSubview(cardImageView)
//        demande d'utiliser autoconstrain
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        cardImageView.image = UIImage(named: "AS")
//        permet de donner les contraintes de la view
        NSLayoutConstraint.activate([
            cardImageView.widthAnchor.constraint(equalToConstant: 250),
            cardImageView.heightAnchor.constraint(equalToConstant: 350),
//            aligne la cardview au centre
            cardImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            aligne la cardiew au centre de Y et la remonte de 75
            cardImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -75)
        ])
    }
    func configureStopButton() {
        view.addSubview(stopButton)
        stopButton.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            stopButton.widthAnchor.constraint(equalToConstant: 260),
            stopButton.heightAnchor.constraint(equalToConstant: 50),
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            aligne le boutton de 30 en dessous du bas de la cardview
            stopButton.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 30)
        ])
    }
    
    func configureResetButton() {
        view.addSubview(resetButton)
        resetButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        NSLayoutConstraint.activate([
            resetButton.widthAnchor.constraint(equalToConstant: 115),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
//            aligne le debut du bouton reset avec le debut du boutton stop
            resetButton.leadingAnchor.constraint(equalTo: stopButton.leadingAnchor),
//            aligne le haut du boutton de 20 en dessous du bas du boutton stop
            resetButton.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: 20)
        ])
    }
    
    func configureRulesButton() {
        view.addSubview(rulesButton)
//        permet de donner une action au boutton ici il appelle la fonction presentRulesCV qui va créer une RulesVC
        rulesButton.addTarget(self, action: #selector(presentRulesVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            rulesButton.widthAnchor.constraint(equalToConstant: 115),
            rulesButton.heightAnchor.constraint(equalToConstant: 50),
//            aligne la fin du bouton rules avec la fin du boutton stop
            rulesButton.trailingAnchor.constraint(equalTo: stopButton.trailingAnchor),
//            aligne le haut du boutton de 20 en dessous du bas du boutton stop
            rulesButton.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func presentRulesVC() {
        present(RulesVC(), animated: true)
    }
}
