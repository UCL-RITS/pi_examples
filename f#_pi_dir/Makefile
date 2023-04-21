# Set compiler here.

pi.exe: bin/pi
	ln -s "bin/pi" pi.exe

bin/pi: pi.fs pi.fsproj
	dotnet build -o bin

pi.fsproj:
	@echo "Make 6_0 or 7_0 to link pi.fsproj depending on .NET version."
	@exit 1

7_0:
	ln -fs pi.fsproj.7_0 pi.fsproj

6_0:
	ln -fs pi.fsproj.6_0 pi.fsproj

clean:
	rm -f pi.exe
	rm -rf obj bin

extraclean: clean
	rm -f pi.fsproj
