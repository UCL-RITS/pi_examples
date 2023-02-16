# Set compiler here.

pi.exe: bin/pi
	ln -s "bin/pi" pi.exe

bin/pi:
	dotnet build -o bin

clean:
	rm -f pi.exe
	rm -rf obj bin
