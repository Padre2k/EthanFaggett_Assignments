import Foundation

class AppData {
    
    public static let shared = AppData()
    
    private var dict: [String: Any] = [:]
        
    private init(){ }

    public func set(value: Any, key: String) {
        dict[key] = value
    }

    public func object(key: String) -> Any? {
        dict[key]
    }

    public func reset(){
        dict.removeAll()
    }
}
