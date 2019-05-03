//
//  Created by Scott Moon on 01/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import Foundation

import SwiftyBeaver

public class AppLogger {

	// MARK: - Private

	private let logger: SwiftyBeaver.Type
	var env = false

	// MARK: - Initializing
	init(with config: AppLoggerConfig? = nil) {
		logger = SwiftyBeaver.self
		setupConsole()

		guard let config = config else {
			return
		}

		let destination = SBPlatformDestination(
			appID: config.appId,
			appSecret: config.appSecret,
			encryptionKey: config.encryptionKey
		)

		logger.addDestination(destination)
		env = true
	}

	func isEnvUsable() -> Bool {
		return env
	}

	private func setupConsole() {
		let console = ConsoleDestination()
		console.asynchronously = false
		console.format = "$DHH:mm:ss.SSS$d $C$L$c - $M"
		logger.addDestination(console)
	}

}

extension AppLogger: Logger {
	func log(level: LoggerLevel, message: Any) {

		switch level {
		case .debug:
			logger.debug(message)
		case .verbose:
			logger.verbose(message)
		case .info:
			logger.info(message)
		case .warning:
			logger.info(message)
		case .error:
			logger.error(message)
		}
	}

}
