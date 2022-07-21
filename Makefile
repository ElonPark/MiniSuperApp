setup:
	brew bundle

swiftgen:
	swiftgen
	swiftformat ./Projects/AppResource/Sources/AppResource ./Projects/Localization/Sources/Localization

setup_swiftformat_hook:
	mkdir -p .git/hooks
	cp ./Scripts/pre-commit .git/hooks/pre-commit
	chmod 755 .git/hooks/pre-commit

mock:
	mockolo -s ./Projects \
	 --mockfiles ./Projects/App/Tests/RIBsMocks.swift \
	 -d ./Projects/App/Tests/OutputMocks.swift \
	 -i MiniSuperApp \
	 -x Tests Resources Resource Localization \
	 --use-mock-observable \
	 --mock-final \
	 --exclude-imports NeedleFoundation

	swiftformat ./Projects/App/Tests/OutputMocks.swift