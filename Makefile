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
	 --mockfiles Projects/Shared/Sources/AppTestSupport/RIBsMocks.swift \
	 Projects/Feature/*/Sources/*TestSupport/*InterfaceMocks.swift \
	 -d Projects/App/Tests/AppMocks.swift \
	 -i MiniSuperApp \
	 -x Feature Tests Resources Resource Localization \
	 --use-mock-observable \
	 --mock-final \
	 --custom-imports AppTestSupport \
	 --exclude-imports NeedleFoundation AppFoundation AppResource DesignSystem Localization Network\

	swiftformat ./Projects/App/Tests/AppMocks.swift

# make domain=Bootstrap mock_domain 
mock_domain:
	mockolo -s Projects/Data/$(domain)Domain/Sources/$(domain)Domain \
	 -d Projects/Data/$(domain)Domain/Sources/$(domain)DomainTestSupport/$(domain)DomainMocks.swift \
	 --use-mock-observable \
	 --mock-final \
	 --custom-imports $(domain)Domain\
	 --exclude-imports NeedleFoundation AppFoundation AppResource DesignSystem Localization Network UIKit\

	swiftformat Projects/Data/$(domain)Domain/Sources/$(domain)DomainTestSupport/$(domain)DomainMocks.swift

# make data=Bootstrap mock_data
mock_data:
	mockolo -s Projects/Data/$(data)Data/Sources/$(data)Data \
	 -d Projects/Data/$(data)Data/Sources/$(data)DataTests/$(data)DataMocks.swift \
	 --use-mock-observable \
	 --mock-final \
	 --custom-imports $(data)Data\
	 --exclude-imports NeedleFoundation AppFoundation AppResource DesignSystem Localization Network UIKit\

	swiftformat Projects/Data/$(data)Data/Sources/$(data)DataTests/$(data)DataMocks.swift

# make feature=Splash mock_interface 
mock_interface:
	mockolo -s Projects/Feature/$(feature)/Sources/$(feature)Interface \
	 --mockfiles Projects/Shared/Sources/AppTestSupport/RIBsMocks.swift \
	 -d Projects/Feature/$(feature)/Sources/$(feature)TestSupport/$(feature)InterfaceMocks.swift \
	 --use-mock-observable \
	 --mock-final \
	 --custom-imports AppTestSupport $(feature)Interface\
	 --exclude-imports NeedleFoundation AppFoundation AppResource DesignSystem Localization Network UIKit\

	swiftformat Projects/Feature/$(feature)/Sources/$(feature)TestSupport/$(feature)InterfaceMocks.swift

# make feature=Splash mock 
mock:
	mockolo -s Projects/Feature/$(feature)/Sources \
	 --mockfiles Projects/Shared/Sources/AppTestSupport/RIBsMocks.swift \
	 -d Projects/Feature/$(feature)/Tests/$(feature)Tests/$(feature)Mocks.swift \
	 -i $(feature) \
	 -x Tests Resources Resource Localization \
	 --use-mock-observable \
	 --mock-final \
	 --custom-imports AppTestSupport \
	 --exclude-imports NeedleFoundation AppFoundation AppResource DesignSystem Localization Network UIKit\

	swiftformat Projects/Feature/$(feature)/Tests/$(feature)Tests/$(feature)Mocks.swift