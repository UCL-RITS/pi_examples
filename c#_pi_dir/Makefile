# Set compiler here.

pi.exe: bin/pi
	ln -fs "bin/pi" pi.exe

bin/pi: pi.cs
	dotnet build -o bin

clean:
	rm -f pi.exe
	rm -rf obj bin
