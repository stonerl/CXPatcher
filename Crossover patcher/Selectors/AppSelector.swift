//
//  AppSelector.swift
//  CXPatcher
//
//  Created by Italo Mandara on 11/07/2023.
//

import Foundation

import SwiftUI

struct AppSelector: View {
//    @Binding var externalUrl: URL?
    @Binding var opts: Opts
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .stroke(getColorBy(status: opts.status), style: StrokeStyle(lineWidth: 6, dash: [11.7]))
            .foregroundColor(Color.black.opacity(0.5))
            .frame(width: 340, height: 300)
            .overlay(
                VStack() {
                    Image(systemName: getIconBy(status: opts.status)).foregroundColor(getColorBy(status: opts.status)).font(.system(size: 60))
                    Text(getTextBy(status: opts.status))
                        .foregroundColor(getColorBy(status: opts.status))
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(20.0)
                    
                }
            )
            .contentShape(RoundedRectangle(cornerRadius: 25))
            .onTapGesture {
                if let url = openAppSelectorPanel() {
                    restoreAndPatch(url: url, opts: &opts)
                }
            }
            .onDrop(of: [.fileURL], delegate: FileDropDelegate(opts: $opts))
//        if(externalUrl != nil) {
//            HStack(alignment: .center) {
//                Image(systemName: "externaldrive.fill.badge.checkmark")
//                    .foregroundColor(.green)
//                Text("External: \(externalUrl!.path)")
//            }
//            .padding(.top, 5.0)
//        }
        
        if(isGStreamerInstalled()) {
            HStack(alignment: .center) {
                Image(systemName: "checkmark.seal.fill").foregroundColor(.green)
                Text(localizedCXPatcherString(forKey: "GStreamerInstalled"))
            }
            .padding(.top, 16.0)
        } else {
            Text(localizedCXPatcherString(forKey: "MediaFoundation"))
                .padding(.top, 6.0)
                .frame(alignment: .center)
            Link(localizedCXPatcherString(forKey: "DownloadGStreamer"), destination: URL(string: "https://gstreamer.freedesktop.org/data/pkg/osx/1.22.4/gstreamer-1.0-1.22.4-universal.pkg")!)
                .padding(.top, 6.0)
                .buttonStyle(.borderedProminent)
        }
    }
}
