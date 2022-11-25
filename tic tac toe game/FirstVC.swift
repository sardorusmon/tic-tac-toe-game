
import UIKit

class FirstVC: UIViewController {
    
    var isXplay: Bool = true
    
    var xWin: Bool = false
    var oWin: Bool = false

    var xCase: [Int] = []
    var oCase: [Int] = []

    var xWinCount = 0
    var oWinCount = 0

    var winnerCase: [[Int]] = [
        [0,1,2],[3,4,5],[6,7,8],
        [0,3,6],[1,4,7],[2,5,8],
        [0,4,8],[2,4,6] ]
    
    @IBOutlet var btnCollect: [UIButton]!
    @IBOutlet weak var playerLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerLbl.text = "X Player"
    }
    
    @IBAction func restartTapped(_ sender: Any) {
        
        isXplay = true
        
        xWin = false
        oWin = false

        xCase = []
        oCase = []

        xWinCount = 0
        oWinCount = 0
        
        playerLbl.text = "X player"
        
        enbleBtn(isEnable: true, title: "")
    }
    
    @IBAction func btnTapped(_ sender: UIButton) {
        
        if sender.currentTitle == nil {
            if isXplay {
            xCase.append(sender.tag)
            playerLbl.text = "O Player"
            sender.setTitle("X", for: .normal)
            isXplay = false
                
            } else {
                oCase.append(sender.tag)
                playerLbl.text = "X Player"
                sender.setTitle("O", for: .normal)
                isXplay = true
            }
            
            for btn in btnCollect{
                btn.isEnabled = btn.currentTitle == nil
            }
            
            if oCase.count >= 3 || xCase.count >= 3{
                
                for winCase in winnerCase {
                    
                    xWinCount = 0
                    oWinCount = 0
                    
                    for win in winCase {
                        if xCase.contains(win){
                            xWin = true
                            xWinCount += 1
                        }
                        else {
                            xWin = false
                        }
                        if oCase.contains(win){
                            oWin = true
                            oWinCount += 1
                        }
                        else {
                            oWin = false
                        }

                    }

                    
                    if xWin && xWinCount>=3{
                        playerLbl.text = "X player Win !!!"
                        setAnimation(winCase: winCase)
                        enbleBtn(isEnable: false)
                        break
                    } else if oWin && oWinCount>=3{
                        playerLbl.text = "O player win !!!"
                        setAnimation(winCase: winCase)
                        enbleBtn(isEnable: false)
                        break
                    } else {
                        
                       if  (xCase.count + oCase.count) == 9 {
                           if xWin && xWinCount>=3{
                               playerLbl.text = "X player Win !!!"
                               setAnimation(winCase: winCase)
                               enbleBtn(isEnable: false)
                               break
                           } else if oWin && oWinCount>=3{
                               playerLbl.text = "O player win !!!"
                               setAnimation(winCase: winCase)
                               enbleBtn(isEnable: false)
                               break
                           } else {
                               playerLbl.text = "Hech kim yutmadi !!!"
                               enbleBtn(isEnable: false)
                           }
                        }
                    }
                    
                    

                }
            }
           
    }
}
    
    func setAnimation(winCase : [Int]) {
        for btn in btnCollect.enumerated(){
            
            if winCase.contains(btn.offset) {
                
                UIView.animate(withDuration: 0.6,delay: 0) {
                    
                    btn.element.transform = CGAffineTransform(scaleX: 3, y: 3)
                    btn.element.setTitleColor(.green, for: .normal)
                        }
                
                completion: {
                    
                    _ in
                    UIView.animate(withDuration: 0.4, delay: 0) {
                        btn.element.transform = .identity
                        
                    }
                    
                    completion : {_ in
                        btn.element.setTitleColor(.black, for: .normal)
                    }
                }
            }
        }
    }
    
    func enbleBtn(isEnable: Bool, title : String? = nil){
        for btn in btnCollect {
            btn.isEnabled = isEnable
            if title != nil {
                btn.setTitle(nil, for: .normal)
            }
            
        }
    }
    
}
