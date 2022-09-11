setup:
	brew bundle

swiftgen:
	swiftgen
	swiftformat ./Projects/Shared/Sources/AppResource ./Projects/Shared/Sources/Localization

setup_swiftformat_hook:
	mkdir -p .git/hooks
	cp ./Scripts/pre-commit .git/hooks/pre-commit
	chmod 755 .git/hooks/pre-commit

project:
	tuist generate

mock_app:
	mockolo -s Projects/App \
	 --mockfiles Projects/Core/Sources/AppTestSupport/RIBsMocks.swift \
	 Projects/Feature/*/Sources/*TestSupport/*InterfaceMocks.swift \
	 -d Projects/App/Tests/AppMocks.swift \
	 -i MiniSuperApp \
	 -x Feature Tests Resources Resource Localization \
	 --use-mock-observable \
	 --mock-final \
	 --custom-imports AppTestSupport \
	 --exclude-imports NeedleFoundation AppFoundation AppResource DesignSystem Localization Network\

	swiftformat ./Projects/App/Tests/AppMocks.swift

# make feature=Splash mock_interface 
mock_interface:
	mockolo -s Projects/Feature/$(feature)/Sources/$(feature)Interface \
	 --mockfiles Projects/Core/Sources/AppTestSupport/RIBsMocks.swift \
	 -d Projects/Feature/$(feature)/Sources/$(feature)TestSupport/$(feature)InterfaceMocks.swift \
	 --use-mock-observable \
	 --mock-final \
	 --custom-imports AppTestSupport $(feature)Interface\
	 --exclude-imports NeedleFoundation AppFoundation AppResource DesignSystem Localization Network UIKit\

	swiftformat Projects/Feature/$(feature)/Sources/$(feature)TestSupport/$(feature)InterfaceMocks.swift

# make feature=Splash mock 
mock:
	mockolo -s Projects/Feature/$(feature)/Sources \
	 --mockfiles Projects/Core/Sources/AppTestSupport/RIBsMocks.swift \
	 -d Projects/Feature/$(feature)/Tests/$(feature)Tests/$(feature)Mocks.swift \
	 -i $(feature) \
	 -x Tests Resources Resource Localization \
	 --use-mock-observable \
	 --mock-final \
	 --custom-imports AppTestSupport \
	 --exclude-imports NeedleFoundation AppFoundation AppResource DesignSystem Localization Network UIKit\

	swiftformat Projects/Feature/$(feature)/Tests/$(feature)Tests/$(feature)Mocks.swift