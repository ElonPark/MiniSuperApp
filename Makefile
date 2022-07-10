setup:
	brew bundle

mock:
	mockolo -s ./MiniSuperApp \
	 --mockfiles ./MiniSuperAppTests/RIBsMocks.swift \
	 -d ./MiniSuperAppTests/OutputMocks.swift \
	 -i MiniSuperApp \
	 -x Resources \
	 --use-mock-observable \
	 --mock-final \
	 --exclude-imports NeedleFoundation