# JavaScript implementations

This directory contains the Pi example for a number of different JavaScript implementations.  Because there is no standardisation within JavaScript (not even for importing libraries, never mind printing to a terminal) there are effectively three implmentations at the momemt - one for v8 (inc Node.js)/browser interpreters and one each for gjs from Gnome and the Windows Scripting Host.  Even the v8 version has different wrappers to give access to command line args etc.

 * `pi.js` - the core implementation used by the v8/browser versions
 * `pi.html`, `webwrapper.js` - browser wrapper for v8 version
 * `runnode.js` - wrapper to run with Node.js
 * `rund8.js` - wrapper to run with the d8 wrapper for v8.
 * `rungjs.js` - stand alone gjs version
 * `runwsh.js` - stand alone Windows Scripting Host version.

## Running

### Node.js

```
$ node runnode.js <n>
```

On some systems the command to start Node.js is `nodejs`.

### D8

```
$ d8 rund8.js -- <n>
```

### GJS

```
$ gjs rungjs.js <n>
```

### Windows Scripting Host

```
C:\> cscript runwsh.js <n>
```
