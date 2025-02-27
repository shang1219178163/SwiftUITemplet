//
//  UTType_ext.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/26.
//

import Foundation
import UniformTypeIdentifiers

public extension UTType {
    /// 
    static var values: [UTType]? {
        return [
            UTType.item,
            UTType.content,
            UTType.compositeContent,
            UTType.diskImage,
            UTType.data,
            UTType.directory,
            UTType.resolvable,
            UTType.symbolicLink,
            UTType.executable,
            UTType.mountPoint,
            UTType.aliasFile,
            UTType.urlBookmarkData,
            UTType.url,
            UTType.fileURL,
            UTType.text,
            UTType.plainText,
            UTType.utf8PlainText,
            UTType.utf16ExternalPlainText,
            UTType.utf16PlainText,
            UTType.delimitedText,
            UTType.commaSeparatedText,
            UTType.tabSeparatedText,
            UTType.utf8TabSeparatedText,
            UTType.rtf,
            UTType.html,
            UTType.xml,
            UTType.yaml,
            UTType.sourceCode,
            UTType.assemblyLanguageSource,
            UTType.cSource,
            UTType.objectiveCSource,
            UTType.swiftSource,
            UTType.cPlusPlusSource,
            UTType.objectiveCPlusPlusSource,
            UTType.cHeader,
            UTType.cPlusPlusHeader,
            UTType.script,
            UTType.appleScript,
            UTType.osaScript,
            UTType.osaScriptBundle,
            UTType.javaScript,
            UTType.shellScript,
            UTType.perlScript,
            UTType.pythonScript,
            UTType.rubyScript,
            UTType.phpScript,
            UTType.makefile,
            UTType.json,
            UTType.propertyList,
            UTType.xmlPropertyList,
            UTType.binaryPropertyList,
            UTType.pdf,
            UTType.rtfd,
            UTType.flatRTFD,
            UTType.webArchive,
            UTType.image,
            UTType.jpeg,
            UTType.tiff,
            UTType.gif,
            UTType.png,
            UTType.icns,
            UTType.bmp,
            UTType.ico,
            UTType.rawImage,
            UTType.svg,
            UTType.livePhoto,
            UTType.heif,
            UTType.heic,
            UTType.webP,
            UTType.threeDContent,
            UTType.usd,
            UTType.usdz,
            UTType.realityFile,
            UTType.sceneKitScene,
            UTType.arReferenceObject,
            UTType.audiovisualContent,
            UTType.movie,
            UTType.video,
            UTType.audio,
            UTType.quickTimeMovie,
            UTType.mpeg,
            UTType.mpeg2Video,
            UTType.mpeg2TransportStream,
            UTType.mp3,
            UTType.mpeg4Movie,
            UTType.mpeg4Audio,
            UTType.appleProtectedMPEG4Audio,
            UTType.appleProtectedMPEG4Video,
            UTType.avi,
            UTType.aiff,
            UTType.wav,
            UTType.midi,
            UTType.playlist,
            UTType.m3uPlaylist,
            UTType.folder,
            UTType.volume,
            UTType.package,
            UTType.bundle,
            UTType.pluginBundle,
            UTType.spotlightImporter,
            UTType.quickLookGenerator,
            UTType.xpcService,
            UTType.framework,
            UTType.application,
            UTType.applicationBundle,
            UTType.applicationExtension,
            UTType.unixExecutable,
            UTType.exe,
            UTType.systemPreferencesPane,
            UTType.archive,
            UTType.gzip,
            UTType.bz2,
            UTType.zip,
            UTType.appleArchive,
            UTType.spreadsheet,
            UTType.presentation,
            UTType.database,
            UTType.message,
            UTType.contact,
            UTType.vCard,
            UTType.toDoItem,
            UTType.calendarEvent,
            UTType.emailMessage,
            UTType.internetLocation,
            UTType.internetShortcut,
            UTType.font,
            UTType.bookmark,
            UTType.pkcs12,
            UTType.x509Certificate,
            UTType.epub,
            UTType.log,
//           UTType.ahap,
        ];
    }

}
