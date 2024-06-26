
(in-package #:adp-github)

@select-output-file["/README.md"]

@header{Allioli}

@image["images/allioli-icon.png" :alt-text "Allioli logo" :scale 0.2]

Welcome to Allioli!!

This is a tiny project that creates the named readtable @code{allioli:syntax} with the only dispatch character macro @code{#¿}.

The purpose of @code{Allioli} is make easier the creation of short lambdas.


@subheader{Installation}

@itemize[
@item{Manual:}
]
@code-block[:lang "sh"]{
cd ~/common-lisp
git clone https://github.com/Hectarea1996/allioli.git
}
@itemize[
@item{Quicklisp (Ultralisp):}
]
@code-block[:lang "common-lisp"]{
(ql-dist:install-dist "http://dist.ultralisp.org/" :prompt nil)
(ql:quickload "allioli")
}



@subheader{Quick start}

After loading the system @code{allioli}, enable the named readtable @code{allioli:syntax}:

@example{
(named-readtables:in-readtable allioli:syntax)
}

And start creating short lambdas on the fly.

We create a lambda with one argument:

@example{
(mapcar #¿(cons ? 2) '(1 2 3 4))
}

Or two different arguments:

@example{
(mapcar #¿(list ? "Hello" ? "there!") '(1 2 3 4) '(5 6 7 8))
}

Or one argument placed in two different places:

@example{
(mapcar #¿(list ?arg "Ahoy!" ?arg) '(1 2 3 4))
}

Or we can get crazy!

@example{
(mapcar #¿(list ?num ? ?num ?char "A lot of arguments!" ?num ?char ?)
        '(1 2 3) '(a b c) '(#\x #\y #\z) '("AA" "BB" "CC"))
}


@subheader{Description}

After @code{#¿} is written, each symbol whose name starts with the character @code{?} can create a new argument for the lambda. If the exact name of the symbol is @code{"?"}, then a new argument is created. If its name is longer a new argument is created only if a symbol with that name didn't appear before.

@example{
;;            1   2       3        4   2          3               5               3  
'#¿(some-form ? ?arg ?another-arg (? ?arg) (?another-arg (?yet-another-arg) ?another-arg))
}
