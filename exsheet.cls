\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{exsheet}[2015/06/30 v1.0 a document class for exercise sheets based on class scrartcl by Markus Kohm]

\RequirePackage{kvoptions}
\RequirePackage{ifthen}                     % for using the \ifthenelse command
\RequirePackage{lmodern}                    % Schriftart Latin Modern

\SetupKeyvalOptions{
  family = scrhmwrk,
  prefix = scrhmwrk@
}

\DeclareStringOption{lang}
\DeclareStringOption[15]{DIV}
\DeclareStringOption[div]{margins}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessKeyvalOptions{scrhmwrk}

%\PassOptionsToClass{DIV=\scrhmwrk@DIV}{scrartcl}

%\LoadClassWithOptions{scrartcl}% load class with the options of this class
\LoadClass{scrartcl}% load class

% if loaded with 'margins=small'
\ifthenelse{\equal{\scrhmwrk@margins}{small}}{%
  \RequirePackage[left=2cm,right=2cm,top=2cm,bottom=2cm]{geometry}% Seitenränder
  \setlength{\footskip}{1cm}
}{%
  % if loaded with 'margins=div'
  \ifthenelse{\equal{\scrhmwrk@margins}{div}}{%
    \KOMAoptions{DIV=\scrhmwrk@DIV}
    \recalctypearea
  }{%
    % warn if loaded with unknown margins option
    \ClassWarning{scrhmwrk}{i don't know margins=\scrhmwrk@margins}% TODO remove
  }
}

\ifthenelse{\equal{\scrhmwrk@lang}{\@empty}}{%
  % do nothing if no language is specified
}{%
  % load babel with the given language option
  \ClassWarning{scrhmwrk}{package babel got loaded}% TODO remove
  \RequirePackage[\scrhmwrk@lang]{babel}             % Spracheinstellung
  \RequirePackage[autostyle=true]{csquotes}        % quotings with \enquote{}
}

% load hyphsubst if loaded with 'lang=ngerman'
\ifthenelse{\equal{\scrhmwrk@lang}{ngerman}}{%
  \ClassWarning{scrhmwrk}{package hyphsubst got loaded}% TODO remove
  \RequirePackage[ngerman=ngerman-x-latest]{hyphsubst}% erweiterte Silbentrennmuster (experimentell)
}{%
  % do nothing
}

\RequirePackage[T1]{fontenc}                % Encodierung der Ausgabe
\RequirePackage[utf8]{luainputenc}          % Encodierung der Eingabe
\RequirePackage[headsepline]{scrpage2}      % Kopf- und Fußzeilen
\RequirePackage{listings}                   % Listings
\RequirePackage{wralistings}
\RequirePackage{textcomp}                   % Sonderzeichen, z.B. €
\RequirePackage{amsmath}                    % ams math environments and symbols
\RequirePackage{amssymb}                    % additional math symbols
\RequirePackage{amsthm}                     % additional math environments
\RequirePackage{wramath}                    % my package with math definitions and environments
\RequirePackage{hyperref}                   % for refs

% configure amsmath to be used with hyperref
\let\equation\gather
\let\endequation\endgather

% commands to fill the header
\newcounter{theseries}
\newcommand{\series}[1]{\setcounter{theseries}{#1}}
\newcommand{\theparticipants}{}
\newcommand{\participants}[1]{\renewcommand{\theparticipants}{#1}}
\newcommand{\thetutor}{}
\newcommand{\thetutortitle}{Übungsleiter}
\newcommand{\tutor}[2][male]{\ifthenelse{\equal{#1}{female}}{\renewcommand{\thetutortitle}{Übungsleiterin}}{}\renewcommand{\thetutor}{#2}}
\newcommand{\thecourse}{}
\newcommand{\course}[1]{\renewcommand{\thecourse}{#1}}
\newcommand{\thegroup}{}
\newcommand{\group}[1]{\renewcommand{\thegroup}{#1}}
\newcommand{\thecorrector}{}
\newcommand{\thecorrectortitle}{Korrektor}
\newcommand{\corrector}[2][male]{\ifthenelse{\equal{#1}{female}}{\renewcommand{\thecorrectortitle}{Korrektorin}}{}\renewcommand{\thecorrector}{#2}}

% configure header and footer
\clearscrheadings
\ihead{\textbf{\thecourse} \hfill \textbf{Gruppe:} \thegroup \hfill \textbf{\thetutortitle{}:} \thetutor \hfill \textbf{\thecorrectortitle{}:} \thecorrector \\
       \textbf{Teilnehmer:} \theparticipants \hfill \textbf{Serie:} \arabic{theseries}}
\cfoot{\pagemark}
\pagestyle{scrheadings}
\setkomafont{pageheadfoot}{\normalfont\sffamily\footnotesize}

% configure headings
\setcounter{secnumdepth}{0}
\addtokomafont{section}{\centering}