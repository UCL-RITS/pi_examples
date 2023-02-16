# Set compiler here.

pi.exe: bin/c\#_pi_dir
	ln -s "bin/c#_pi_dir" pi.exe

bin/c\#_pi_dir:
	dotnet build -o bin

clean:
	rm -f pi.exe
	rm -rf obj bin
