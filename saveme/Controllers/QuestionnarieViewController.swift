//
//  QuestionnarieViewController.swift
//  eletmodvaltok
//
//  Created by Gábor Eszenyi on 2017. 05. 11..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import UIKit

class QuestionnarieViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var pageIndicator: PageIndicatorView!
    static let answerGroups: Array<Array<Answer>> = [[Answer("Igen",1), Answer("Nem",0)],
                                                     [Answer("egyáltalán nem jellemző",4), Answer("alig jellemző",3), Answer("jellemző",2), Answer("teljesen jellemző",1)],
                                                     [Answer("egyáltalán nem jellemző",1), Answer("alig jellemző",2), Answer("jellemző",3), Answer("teljesen jellemző",4)]]
    
    
    var questions: [Question] = [Question(question: "Szokott ön diétázni vagy fogyókúrázni?",                                                       answers: answerGroups[0], program:"eat"),
                                 Question(question: "Okoz-e gondot önnek, hogy hogyan állítsa össze táplálkozását optimálisan?",                    answers: answerGroups[0], program:"eat"),
                                 Question(question: "Érdekli önt, hogy miből készülnek az élelmiszerek valójában?",                                 answers: answerGroups[0], program:"eat"),
                                 Question(question: "Szokott ön figyelmet fordítani a cukorfogyasztásra?",                                          answers: answerGroups[0], program:"eat"),
                                 Question(question: "Ön készíti el az ételeket, amelyeket fogyasz, és szokott-e főzni magának vagy a családjának?", answers: answerGroups[2], program:"move"),
                                 Question(question: "Gyalog és/vagy kerékpárral mközlekedem",                                                       answers: answerGroups[2], program:"move"),
                                 Question(question: "Közösségi közlekedést használok",                                                              answers: answerGroups[1], program:"move"),
                                 Question(question: "Személygépkocsival és/vagy motorkerékpárral közlekedem",                                       answers: answerGroups[1], program:"move"),
                                 Question(question: "Naponta legalább 30 percet tempósan gyaloglok",                                                answers: answerGroups[2], program:"move"),
                                 Question(question: "Lépcsőt használok lift helyett",                                                               answers: answerGroups[2], program:"move"),
                                 Question(question: "Rendszeresen mozog vagy sportol-e közepes vagy magas intenzitással legalább 45 percig?",       answers: answerGroups[2], program:"move")]

    
    var intensities: [Intensity] = [Intensity("IntensityInactive",Int.min,12,"inaktív","inaktiv"),
                                    Intensity("IntensityNormal",13,17,"közepesen aktív","kozepesen-aktiv"),
                                    Intensity("IntensityActive",18,Int.max,"kifejezetten aktív","kifejezetten-aktiv")]
    

    
    var currentPage: Int = 0 {
        didSet {
            self.questionLabel?.text = questions[currentPage].question!
            pageIndicator.selectedPage = currentPage
        }
    }
    
    var score: [String: Int] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        pageIndicator.pageCount = questions.count
        self.currentPage = 0
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(QuestionnarieViewController.answerSelected(_:)), name: Constants.Notifications.AnswerSelectedNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func answerSelected(_ notification: Notification) {
        let data: Dictionary<String, Any> = notification.object as! Dictionary
        let q: Question = data["question"] as! Question
        let ai: Int = data["selectedIndex"] as! Int
        print("answer selected: \(ai) \(q.answers[ai].value!)")
        self.score[q.program] = (self.score[q.program] ?? 0) + q.answers[ai].value
        
        let page = self.questions.index(of: q)
        let nextPage = self.questions.atIndex(index: page! + 1)
        if nextPage != nil {
            // TODO: lapozz
            self.collectionView.scrollToItem(at: IndexPath(row: page! + 1, section: 0), at: .left, animated: true)
        } else {
            print("exit")
            self.performSegue(withIdentifier: "ShowRecommendations", sender: self)
        }

    }
    
    
    func getIntensityForScore(_ value: Int) -> Intensity? {
        for i in self.intensities {
            if i.min <= value && i.max > value {
                return i
            }
        }
        return nil
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowRecommendations" {
            let recommendations = segue.destination as! RecommendationsWrapperViewController
            recommendations.isEditable = true
            let intensity = self.getIntensityForScore(self.score["move"]!)
            if intensity != nil {
                intensity?.value = self.score["move"]!
                recommendations.intensity = intensity
            } else {
                recommendations.intensity = self.intensities.first
            }
            
        }
    }
    

}

extension QuestionnarieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: questions[indexPath.row].answers.count == 2 ? "Cell" : "Cell2", for: indexPath) as! AnswersCell
        cell.question = questions[indexPath.row]
        return cell
    }
}

extension QuestionnarieViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let total = scrollView.contentSize.width - scrollView.bounds.width
        let offset = scrollView.contentOffset.x
        let percent = Double(offset / total)
        
        let progress = percent * Double(questions.count - 1)
        self.currentPage = Int(progress)
    }
}

extension QuestionnarieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }
}
