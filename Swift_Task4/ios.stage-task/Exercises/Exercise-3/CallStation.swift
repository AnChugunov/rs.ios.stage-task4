import Foundation

final class CallStation {
    
    var usersList = [User]()
    var callsList = [Call]()
}

extension CallStation: Station {
    func users() -> [User] {
        return usersList
    }
    
    func add(user: User) {
        if !usersList.contains(user) {
            usersList.append(user)
        } else {
            return
        }
    }
    
    func remove(user: User) {
        if usersList.contains(user) {
            usersList.remove(at: usersList.firstIndex(of: user)!)
        }
    }
    
    
    func execute(action: CallAction) -> CallID? {
        switch action {
            case .start(from: let sender, to: let addressee):
                if !usersList.contains(sender) && !usersList.contains(addressee) { return nil }
                    else
                if !usersList.contains(addressee) {
                    let call = Call(id: CallID.init(), incomingUser: sender, outgoingUser: addressee, status: .ended(reason: .error))
                    callsList.append(call)
                return call.id
                }
                if self.currentCall(user: addressee) != nil {
                        let call = Call(id: UUID.init(), incomingUser: sender, outgoingUser: addressee, status: .ended(reason: .userBusy))
                        callsList.append(call)
                } else {
                    let call = Call(id: UUID.init(), incomingUser: sender, outgoingUser: addressee, status: .calling)
                    callsList.append(call)
                }
               
                if let index = callsList.firstIndex(where: { $0.incomingUser == sender && $0.outgoingUser == addressee }) {
                    return callsList[index].id
                }

            return nil
                
            case .answer(from: let sender):
                if !usersList.contains(sender) {
                    guard let index = callsList.firstIndex(where: {$0.outgoingUser == sender}) else {return nil}
                    callsList[index].status = .ended(reason: .error)
                    return nil
                } else {
                    guard let index = callsList.firstIndex(where: {$0.outgoingUser == sender}) else {return nil}
                    callsList[index].status = .talk
                    return callsList[index].id
                }
                
                
            case .end(from: let sender):
                let callId = calls(user: sender).first?.id
                    if callsList.contains(where: { $0.id == callId }) {
                        if let index = callsList.firstIndex(where: { $0.id == callId }) {
                            if callsList[index].status == .talk {
                                callsList[index].status = .ended(reason: .end)
                            }
                            if callsList[index].status == .calling {
                                callsList[index].status = .ended(reason: .cancel)
                            }
                        }
                    }
                return callId
            }
    }
    
    
    func calls() -> [Call] {
        return callsList
    }
    
    func calls(user: User) -> [Call] {
        var newCallsList = [Call]()
        for call in callsList {
            if call.incomingUser == user || call.outgoingUser == user {
                newCallsList.append(call)
            }
        }
        return newCallsList
    }
    func call(id: CallID) -> Call? {
        for call in callsList {
            if call.id == id {
                return call
            }
        }
        return nil
    }
    
    func currentCall(user: User) -> Call? {
        for call in callsList {
            if (call.outgoingUser == user || call.incomingUser == user) && (call.status == .calling || call.status == .talk) {
                return call
            }
        }
        return nil
        }
    }


