import Foundation

public enum TestError: Swift.Error {
    case test
}


#if NOT_IN_PLAYGROUND
    
    public func playgroundShouldContinueIndefinitely() { }
    
#else
    
    import PlaygroundSupport
    
    public func playgroundShouldContinueIndefinitely() {
        PlaygroundPage.current.needsIndefiniteExecution = true
    }
    
#endif
