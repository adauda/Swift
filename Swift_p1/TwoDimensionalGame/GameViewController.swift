import UIKit

class GameViewController: UIViewController {
    
    let gameModel = GameModel()
    
    // IBOutlets
    @IBOutlet weak var northButton: UIButton!
    @IBOutlet weak var eastButton: UIButton!
    @IBOutlet weak var southButton: UIButton!
    @IBOutlet weak var westButton: UIButton!
    @IBOutlet weak var specEventLabel: UILabel!
    @IBOutlet weak var moveCounterLabel: UILabel!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var eventLogLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentLocation = gameModel.currentLocation
        currentLocationLabel.text = "(x:\(currentLocation.x),y:\(currentLocation.y))"
        specEventLabel.isHidden = true
        
    }
    
    
    //  Connect IBActions
    @IBAction func northButtonPushed(_ sender: UIButton) {
        gameModel.move(direction: .north)
        updateLabelsAndButtons(direction: "Moved North")
        
    }
    
    @IBAction func eastButtonPushed(_ sender: UIButton) {
        gameModel.move(direction: .east)
        updateLabelsAndButtons(direction: "Moved East")
    }
    
    @IBAction func westButtonPushed(_ sender: UIButton) {
        gameModel.move(direction: .west)
        updateLabelsAndButtons(direction: "Moved West")
    }
    
    @IBAction func southButtonPushed(_ sender: UIButton) {
        gameModel.move(direction: .south)
        updateLabelsAndButtons(direction: "Moved South")
    }
    
    @IBAction func resetButtonPushed(_ sender: UIButton) {
        gameModel.restart()
        updateLabelsAndButtons()
        specEventLabel.isHidden = true
        moveCounterLabel.text = " "
    }
    
    
    func updateLabelsAndButtons (direction:String? = nil){
        updateButtons()
        updateEventLogLabel(direction: direction)
        updateCurrentLocationLabel()
        
        updateMoveCounter()
        
        if let specialEvent = gameModel.currentLocation.event { updateSpecialEventLabel(specialEvent: specialEvent) }
    }
    
    
    func updateButtons () {
        
        if !gameModel.currentLocation.allowedDirections.contains(.north) { northButton.isHidden = true }
        else { northButton.isHidden = false }
        
        if !gameModel.currentLocation.allowedDirections.contains(.south) { southButton.isHidden = true }
        else {  southButton.isHidden = false }
        
        if !gameModel.currentLocation.allowedDirections.contains(.east) { eastButton.isHidden = true }
        else {  eastButton.isHidden = false }
        
        if !gameModel.currentLocation.allowedDirections.contains(.west) { westButton.isHidden = true }
        else {  westButton.isHidden = false }
    }
    
    
    func updateEventLogLabel (direction: String? = nil) {
        if let movedDirection = direction {
            eventLogLabel.text = "\(movedDirection)"
        }
        else {
            eventLogLabel.text = " "
        }
    }
    
    
    func updateCurrentLocationLabel () {
        currentLocationLabel.text = "(x:\(gameModel.currentLocation.x),y:\(gameModel.currentLocation.y))"
    }
    
    
    func updateMoveCounter() {
        let count = gameModel.counter
        if count % 5 == 0{
            moveCounterLabel.text = "You have moved \(gameModel.counter) steps, BONUS POINTS"
        }
    }
 
    
    func updateSpecialEventLabel (specialEvent: String) {
        specEventLabel.isHidden = false
        specEventLabel.text = "\(specialEvent) Game Restarted!!!"
        moveCounterLabel.text = ""
        gameModel.restart()
        updateLabelsAndButtons()
    }
}








