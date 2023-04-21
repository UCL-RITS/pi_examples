# Set compiler here.

pi.exe: bin/pi
	ln -fs "bin/pi" pi.exe

bin/pi: pi.vb pi.vbproj
	dotnet build -o bin

pi.vbproj:
	@echo "Make 6_0 or 7_0 to link pi.vbproj depending on .NET version."
	@exit 1

7_0:
	ln -fs pi.vbproj.7_0 pi.vbproj

6_0:
	ln -fs pi.vbproj.6_0 pi.vbproj

clean:
	rm -f pi.exe
	rm -rf obj bin

extraclean: clean
	rm -f pi.vbproj
