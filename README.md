<a id="header-adp-github-headertag610"></a>
# Allioli

<img src="/images/allioli-icon.png" alt="Allioli logo" width="20%">

Welcome to Allioli\!\!

This is a tiny project that creates the named readtable ``` allioli:syntax ``` with the only dispatch character macro ``` #¿ ```\.

The purpose of ``` Allioli ``` is make easier the creation of short lambdas\.


<a id="header-adp-github-headertag611"></a>
## Quick start

After loading the system ``` allioli ```\, enable the named readtable ``` allioli:syntax ```\:

`````common-lisp
(named-readtables:in-readtable allioli:syntax)
`````
`````common-lisp
#<:named-readtable allioli:syntax {1005C2A173}>
`````

And start creating short lambdas on the fly\.

We create a lambda with one argument\:

`````common-lisp
(mapcar #¿(cons ? 2) '(1 2 3 4))
`````
`````common-lisp
((1 . 2) (2 . 2) (3 . 2) (4 . 2))
`````

Or two different arguments\:

`````common-lisp
(mapcar #¿(list ? "Hello" ? "there!") '(1 2 3 4) '(5 6 7 8))
`````
`````common-lisp
((1 "Hello" 5 "there!") (2 "Hello" 6 "there!") (3 "Hello" 7 "there!")
 (4 "Hello" 8 "there!"))
`````

Or one argument placed in two different places\:

`````common-lisp
(mapcar #¿(list ?arg "Ahoy!" ?arg) '(1 2 3 4))
`````
`````common-lisp
((1 "Ahoy!" 1) (2 "Ahoy!" 2) (3 "Ahoy!" 3) (4 "Ahoy!" 4))
`````

Or we can get crazy\!

`````common-lisp
(mapcar #¿(list ?num ? ?num ?char "A lot of arguments!" ?num ?char ?)
        '(1 2 3) '(a b c) '(#\x #\y #\z) '("AA" "BB" "CC"))
`````
`````common-lisp
((1 a 1 #\x "A lot of arguments!" 1 #\x "AA")
 (2 b 2 #\y "A lot of arguments!" 2 #\y "BB")
 (3 c 3 #\z "A lot of arguments!" 3 #\z "CC"))
`````


<a id="header-adp-github-headertag627"></a>
## Description

After ``` #¿ ``` is written\, each symbol whose name starts with the character ``` ? ``` can create a new argument for the lambda\. If the exact name of the symbol is ``` "?" ```\, then a new argument is created\. If its name is longer a new argument is created only if a symbol with that name didn\'t appear before\.

`````common-lisp
;;            1   2       3        4   2          3               5               3
'#¿(some-form ? ?arg ?another-arg (? ?arg) (?another-arg (?yet-another-arg) ?another-arg))
`````
`````common-lisp
(lambda (?628 ?arg ?another-arg ?629 ?yet-another-arg)
  (some-form ?628 ?arg ?another-arg (?629 ?arg)
   (?another-arg (?yet-another-arg) ?another-arg)))
`````