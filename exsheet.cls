\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{exsheet}[2015/06/30 v1.0 a document class for exercise sheets based on class scrartcl by Markus Kohm]

\LoadClassWithOptions{scrartcl}% load class with the options of this class

\RequirePackage{ifthen}                     % for using the \ifthenelse command
\RequirePackage[ngerman]{babel}             % Spracheinstellung
\RequirePackage[ngerman=ngerman-x-latest]{hyphsubst}% erweiterte Silbentrennmuster (experimentell)
\RequirePackage{lmodern}                    % Schriftart Latin Modern
\RequirePackage[left=2cm,right=2cm,top=2cm,bottom=2cm]{geometry}% Seitenränder
\RequirePackage[T1]{fontenc}                % Encodierung der Ausgabe
\RequirePackage[utf8]{luainputenc}          % Encodierung der Eingabe
\RequirePackage[headsepline]{scrpage2}      % Kopf- und Fußzeilen
\RequirePackage[autostyle]{csquotes}        % quotings with \enquote{}
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