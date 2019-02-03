enum GameDirection {
    case north, east, west, south
}

struct GameLocation {
    let x: Int
    let y: Int
    let allowedDirections: [GameDirection]
    var event: String?
}

struct GameRow {
    let locations: [GameLocation]
}

class GameModel {

    private var currentRowIndex = 2       // start at (x: 0, y: 0)
    private var currentLocationIndex = 2  // which translates to index 2 in our arrays
    
    private var gameGrid: [GameRow] = []
    
    private let minXYvalue = -2
    private let maxXYvalue = 2
    
    
    //Special locations for special events
    private var moreLife = (specialX: 1, specialY: -2)
    private var youAreDead = (specialX: -2, specialY: 1)
    private var madeItHome = (specialX: -1, specialY: 2)
    
    //to track the number of moves
    var counter = 0
    
    init() {
        self.gameGrid = createGameGrid()
    }
    
    func restart() {
        currentRowIndex = 2
        currentLocationIndex = 2
    }
    
    func move(direction: GameDirection) {
        switch direction {
        case .north: currentRowIndex += 1
        case .south: currentRowIndex -= 1
        case .east: currentLocationIndex += 1
        case .west: currentLocationIndex -= 1
        }
        
        //increament number of moves
        counter += 1
    }
    
    
    var currentLocation: GameLocation {
        /*
         TODO: Implement this method. It should return the *correct* GameLocation struct
         in the gameGrid for the player's current location.
         */
        
        //set the origin to (x = 0 and y = 0)
        let yCoordinate = currentRowIndex - 2
        let xCoordinate = currentLocationIndex - 2
        
    
        return GameLocation(x: xCoordinate, y: yCoordinate, allowedDirections: allowedDirectionsForCoordinate(x: xCoordinate, y: yCoordinate), event: eventForCoordinate(x: xCoordinate, y: yCoordinate))
    }
    
    // MARK: Helper methods for creating grid
    
    private func createGameGrid() -> [GameRow] {
        var gameGrid = [GameRow]()
        
        for yValue in minXYvalue...maxXYvalue {
            var locations = [GameLocation]()
            for xValue in minXYvalue...maxXYvalue {
                let directions = allowedDirectionsForCoordinate(x: xValue, y: yValue)
                let location = GameLocation(x: xValue, y: yValue, allowedDirections: directions, event: nil)
                locations.append(location)
            }
            let gameRow = GameRow(locations: locations)
            gameGrid.append(gameRow)
        }
        return gameGrid
    }
    
    private func eventForCoordinate(x: Int, y: Int) -> String? {
        /*
         TODO: Implement at least 2 special events for specific coordinates
         in this method.
         */
        let yCoordinate = currentRowIndex - 2
        let xCoordinate = currentLocationIndex - 2
        
        //var specialIndexX = 0
        //var specialIndexY = 0
        
        var specEvent:String? = nil
        
        if xCoordinate == moreLife.specialX && yCoordinate == moreLife.specialY {
            specEvent = "You gained 1 more life 🍔"
            
            
        } else if xCoordinate == youAreDead.specialX && yCoordinate == youAreDead.specialY {
            specEvent = "Dead buddy 🤯"
            
        } else if xCoordinate == madeItHome.specialX && yCoordinate == madeItHome.specialY{
            specEvent = "You made it buddy 🏡"
        }
        
        return specEvent
    }
    
    private func allowedDirectionsForCoordinate(x: Int, y: Int) -> [GameDirection] {
        var directions = [GameDirection]()
        switch y {
        case minXYvalue:    directions += [.north]
        case maxXYvalue:    directions += [.south]
        default:            directions += [.north, .south]
        }
        switch x {
        case minXYvalue:    directions += [.east]
        case maxXYvalue:    directions += [.west]
        default:            directions += [.east, .west]
        }
        return directions
    }
    
}

