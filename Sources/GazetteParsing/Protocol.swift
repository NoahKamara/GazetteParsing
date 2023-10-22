//
//  File.swift
//  
//
//  Created by Noah Kamara on 16.10.23.
//

import Foundation
import GazetteCore

enum FeedParsingError: Error {
	case unsupportedFeedType
}

protocol FeedParsing {
	typealias Err = FeedParsingError
	
	func parse(url: URL) async throws -> TransientFeed
}
