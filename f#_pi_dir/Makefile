# Set compiler here.

_dotnet_major_ver := $(shell dotnet --version | cut -f1 -d.)
_dotnet_minor_ver := $(shell dotnet --version | cut -f2 -d.)

pi.exe: bin/pi
	ln -s "bin/pi" pi.exe

bin/pi: pi.fs pi.fsproj
	dotnet build --framework net${_dotnet_major_ver}.${_dotnet_minor_ver} -o bin

clean:
	rm -f pi.exe
	rm -rf obj bin

extraclean: clean
	rm -f pi.fsproj
