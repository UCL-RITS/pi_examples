JAVAC = javac 
CSHARP = mcs

default:
	echo "make pi.exe (c#) or pi.class (java)"

pi.exe: pi.cs sys.dll code.dll
	$(CSHARP) pi.cs -reference:code.dll,sys.dll

pi.class: pi.java sys.class code.class
	$(JAVAC) pi.java

code.class: code.mixed code.java sys.class
	$(JAVAC) code.java

sys.class: sys.java
	${JAVAC} sys.java

code.dll: code.mixed code.cs sys.dll
	$(CSHARP) -target:library -reference:sys.dll code.cs

sys.dll: sys.cs
	${CSHARP} -target:library sys.cs

code.cs:
	ln -s code.mixed code.cs

code.java:
	ln -s code.mixed code.java

clean:
	rm -f *.class *.dll *.exe code.java code.cs
