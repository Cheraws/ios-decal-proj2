//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit


class GameViewController: UIViewController {
    var word = String()
    var finalWord = String()
    var hangWord = String()
    var incorrectGuesses = String()
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var incorrectGuessLabel: UILabel!
    @IBOutlet weak var guessBox: UITextField!
    
    @IBOutlet weak var hangedMan: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //starts up the function.
    func initialize(){
        self.incorrectGuessLabel.text = ""
        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()!
        let image = UIImage(named:"hangman1.gif")
        hangedMan.image = image
        print ("?")
        self.word = ""
        var hangmanWord = ""
        for i in phrase.characters {
            if i == " " {
                self.word = self.word + " " + " "
                hangmanWord = hangmanWord + " " + " "
            } else {
                hangmanWord = hangmanWord + "_" + " "
                self.word = self.word + String(i) + " "
            }
        }
        self.finalWord = phrase
        self.hangWord = hangmanWord
        print(self.word)
        print(hangmanWord)
        wordLabel.text = hangmanWord
        guessLabel.text = "0"
        self.guessBox.text = "a"
    }

    
    @IBAction func guessAction(_ button:UIButton) {
        var guess = self.guessBox.text!
        let letters = NSCharacterSet.letters
        
        print(letters)
        if guess.characters.count != 1{
            return
        }
        else{
            let range = guess.rangeOfCharacter(from: letters)
            if (range != nil){
                guess = guess.uppercased()
            }
            else{
                return
            }
        }
        var aWord = self.word
        var hangWord = self.wordLabel.text!
        let length = self.wordLabel.text!.characters.count
        print (length)
        var correct = false
        var newWord = ""
        for (i,j) in zip(aWord.characters, hangWord.characters){
            if(String(i) == guess){
                newWord += String(i)
                correct = true
                
            }
            else{
                newWord += String(j)
            }
        }
        if(correct == false){
            if self.incorrectGuessLabel.text!.range(of: guess) != nil{
                return
            }
            if Int(guessLabel.text!) == 5{
                let alert = UIAlertController(title: "You Lost!", message: "RIP", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default,
                                              handler: {action in self.initialize()}))
                self.present(alert, animated: true, completion: nil)
            }
            self.incorrectGuessLabel.text = self.incorrectGuessLabel.text! + guess
            guessLabel.text = String(Int(guessLabel.text!)! + 1)
            let value = "hangman" + String(Int(guessLabel.text!)! + 1) + ".gif"
            let image = UIImage(named: value)
            hangedMan.image = image
            return
        }
        if(newWord == aWord){
            print ("DONE!")
            let alert = UIAlertController(title: "You Won!", message: "Yay!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default,
                                          handler: {action in self.initialize()}))
            self.present(alert, animated: true, completion: nil)

        }
        wordLabel.text = newWord
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
