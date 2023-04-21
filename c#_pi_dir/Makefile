# Set compiler here.

pi.exe: bin/pi
	ln -fs "bin/pi" pi.exe

bin/pi: pi.cs pi.csproj
	dotnet build -o bin

pi.csproj:
	@echo "Make 6_0 or 7_0 to link pi.csproj depending on .NET version."
	@exit 1

7_0:
	ln -fs pi.csproj.7_0 pi.csproj

6_0:
	ln -fs pi.csproj.6_0 pi.csproj

clean:
	rm -f pi.exe
	rm -rf obj bin

extraclean: clean
	rm -f pi.csproj
