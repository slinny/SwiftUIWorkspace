//
//  NFCView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 1/30/25.
//

import SwiftUI
import CoreNFC

struct NFCView: View {
    @StateObject var nfcManager = NFCManager()
    
    var body: some View {
        VStack {
            Button("Start Scanning") {
                nfcManager.startScanning()
            }
            if let tag = nfcManager.tag {
                Text("Tag detected!")
                Text("Message: \(tag.records.first?.payload.debugDescription ?? "")")
            }
        }
    }
}

class NFCManager: NSObject, ObservableObject, NFCNDEFReaderSessionDelegate {
    @Published var tag: NFCNDEFMessage?
    
    private var readerSession: NFCNDEFReaderSession?
    private let queue = DispatchQueue(label: "com.nfcmanager.queue")
    
    func startScanning() {
        readerSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        readerSession?.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        // Process the detected tag
        if let tag = tags.first {
            session.connect(to: tag) { [weak self] (error) in
                if let error = error {
                    print("Error connecting to tag: \(error.localizedDescription)")
                    return
                }
                print("Tag connected!")
                tag.queryNDEFStatus { [weak self] (status, capacity, error) in
                    if let error = error {
                        print("Error querying tag status: \(error.localizedDescription)")
                        return
                    }
                    print("Tag status: \(status.rawValue)")
                    tag.readNDEF { [weak self] (message, error) in
                        if let error = error {
                            print("Error reading tag: \(error.localizedDescription)")
                            return
                        }
                        print("Tag message: \(message.debugDescription)")
                        self?.queue.async {
                            DispatchQueue.main.async {
                                self?.tag = message
                            }
                        }
                    }
                }
            }
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        // Not implemented
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("Error invalidating session: \(error.localizedDescription)")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didTerminateWithError error: Error) {
        print("Error terminating session: \(error.localizedDescription)")
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

#Preview {
    NFCView(nfcManager: NFCManager())
}
