format:
	@echo "╠ Formatting the project..."
	@dart format .
	@echo "╠ Project has been formatted"

clean: 
	@echo "╠ Cleaning the project..."
	@flutter clean

build_runner:
	@echo "╠ Running the build runner on the project..."
	@flutter pub run build_runner build --delete-conflicting-outputs
	@echo "╠ Build runner successed!"

init:
	@echo "╠ Initialize the project..."
	make clean
	@flutter pub get
	make build_runner
	@echo "╠ Initialize successed!"

dev:
	@flutter run lib/main.dart

build_apk:
	@flutter build apk

release:
	make init
	@flutter pub run flutter_launcher_icons
	@flutter build appbundle

.PHONY: format clean build_runner init dev build_apk