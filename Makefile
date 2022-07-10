setup:
	brew bundle

swiftgen:
	swiftgen
	swiftformat ./MiniSuperApp/Sources/Resource ./MiniSuperApp/Sources/Localization

setup_swiftformat_hook:
	mkdir -p .git/hooks
	cp ./Scripts/pre-commit .git/hooks/pre-commit
	chmod 755 .git/hooks/pre-commit

mock:
	mockolo -s ./MiniSuperApp \
	 --mockfiles ./MiniSuperAppTests/RIBsMocks.swift \
	 -d ./MiniSuperAppTests/OutputMocks.swift \
	 -i MiniSuperApp \
	 -x Resources Resource Localization \
	 --use-mock-observable \
	 --mock-final \
	 --exclude-imports NeedleFoundation

	swiftformat ./MiniSuperAppTests/OutputMocks.swift