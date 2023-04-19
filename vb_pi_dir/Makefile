# Set compiler here.

pi.exe: bin/pi
	ln -fs "bin/pi" pi.exe

bin/pi: pi.vb
	dotnet build -o bin

clean:
	rm -f pi.exe
	rm -rf obj bin
