\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{exsheet}[2015/06/30 v1.0 a document class for exercise sheets based on class scrartcl by Markus Kohm]

\RequirePackage{kvoptions}
\RequirePackage{ifthen}                     % for using the \ifthenelse command
\RequirePackage{lmodern}                    % Schriftart Latin Modern
\RequirePackage{textcomp}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{luainputenc}

\SetupKeyvalOptions{
  family = scrhmwrk,
  prefix = scrhmwrk@
}

\DeclareStringOption{lang}
\DeclareStringOption[15]{DIV}
\DeclareStringOption[div]{margins}
\DeclareStringOption[normal]{headings}
\DeclareBoolOption[true]{listings}
\DeclareBoolOption[true]{extendmath}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessKeyvalOptions{scrhmwrk}

\PassOptionsToClass{headings=\scrhmwrk@headings}{scrartcl}
\LoadClass{scrartcl}

% if loaded with 'margins=small'
\ifthenelse{\equal{\scrhmwrk@margins}{small}}{
  \RequirePackage[left=2cm,right=2cm,top=2cm,bottom=2cm]{geometry}% Seitenränder
  \setlength{\footskip}{1cm}
}{
  % if loaded with 'margins=div'
  \ifthenelse{\equal{\scrhmwrk@margins}{div}}{%
    \KOMAoptions{DIV=\scrhmwrk@DIV}
    \recalctypearea
  }{
    % warn if loaded with unknown margins option
    \ClassWarning{scrhmwrk}{i don't know margins=\scrhmwrk@margins}% TODO remove
  }
}

\ifthenelse{\equal{\scrhmwrk@lang}{\@empty}}{
  % do nothing if no language is specified
}{
  % load babel with the given language option
  \ClassWarning{scrhmwrk}{package babel got loaded}% TODO remove
  \RequirePackage[\scrhmwrk@lang]{babel}             % Spracheinstellung
  \RequirePackage[autostyle=true]{csquotes}        % quotings with \enquote{}
}

% load hyphsubst if loaded with 'lang=ngerman'
\ifthenelse{\equal{\scrhmwrk@lang}{ngerman}}{
  \ClassWarning{scrhmwrk}{package hyphsubst got loaded}% TODO remove
  \RequirePackage[ngerman=ngerman-x-latest]{hyphsubst}% erweiterte Silbentrennmuster (experimentell)
}{
  % do nothing
}

% loaded with 'listings=true' (default)
\ifthenelse{\boolean{scrhmwrk@listings}}{
  \ClassWarning{scrhmwrk}{listings got loaded}% TODO remove
  \RequirePackage{listings}

  % define custom listings style 'scrhmwrk' and make it the default style
  \lstdefinestyle{scrhmwrk}{
    basicstyle=\small,
    frame=single,
  	breaklines=true,
  	postbreak=\raisebox{0ex}[0ex][0ex]{\ensuremath{\hookrightarrow\space}},
  	numbers=left,
  	numbersep=5pt,                   % how far the line-numbers are from the code}
    numberstyle=\tiny,
    xleftmargin=14pt,
    tabsize=2,
    literate=
    {á}{{\'a}}1 {é}{{\'e}}1 {í}{{\'i}}1 {ó}{{\'o}}1 {ú}{{\'u}}1
    {Á}{{\'A}}1 {É}{{\'E}}1 {Í}{{\'I}}1 {Ó}{{\'O}}1 {Ú}{{\'U}}1
    {à}{{\`a}}1 {è}{{\`e}}1 {ì}{{\`i}}1 {ò}{{\`o}}1 {ù}{{\`u}}1
    {À}{{\`A}}1 {È}{{\'E}}1 {Ì}{{\`I}}1 {Ò}{{\`O}}1 {Ù}{{\`U}}1
    {ä}{{\"a}}1 {ë}{{\"e}}1 {ï}{{\"i}}1 {ö}{{\"o}}1 {ü}{{\"u}}1
    {Ä}{{\"A}}1 {Ë}{{\"E}}1 {Ï}{{\"I}}1 {Ö}{{\"O}}1 {Ü}{{\"U}}1
    {â}{{\^a}}1 {ê}{{\^e}}1 {î}{{\^i}}1 {ô}{{\^o}}1 {û}{{\^u}}1
    {Â}{{\^A}}1 {Ê}{{\^E}}1 {Î}{{\^I}}1 {Ô}{{\^O}}1 {Û}{{\^U}}1
    {œ}{{\oe}}1 {Œ}{{\OE}}1 {æ}{{\ae}}1 {Æ}{{\AE}}1 {ß}{{\ss}}1
    {ű}{{\H{u}}}1 {Ű}{{\H{U}}}1 {ő}{{\H{o}}}1 {Ő}{{\H{O}}}1
    {ç}{{\c c}}1 {Ç}{{\c C}}1 {ø}{{\o}}1 {å}{{\r a}}1 {Å}{{\r A}}1
    {€}{{\EUR}}1 {£}{{\pounds}}1}
    \lstset{style=scrhmwrk}
  
  % Pseudocode language definition
  \lstdefinelanguage{Pseudocode}{
    keywords={if, then, while, for, do, else, fi, od, return, to, integer, bool, node, null},
    keywordstyle=\bfseries,
    sensitive=false,
    comment=[l]{//},
    morecomment=[s]{/*}{*/},
    commentstyle=\itshape
  }
}{
  % do nothing if loaded with 'listings=false'
}

% loaded with 'extendmath=true' (default)
\ifthenelse{\boolean{scrhmwrk@extendmath}}{
  \RequirePackage{amsmath}
  \RequirePackage{amssymb}
  \RequirePackage{amsthm}
  
  %% define additional math environments
  \theoremstyle{plain}
  \newtheorem*{lemma*}{Lemma}
  \newtheorem{lemma}{Lemma}
  
  \theoremstyle{remark}
  \newtheorem*{vor*}{Voraussetzung}
  \newtheorem*{beh*}{Behauptung}
  \newtheorem*{ia*}{IA}
  \newtheorem*{iv*}{IV}
  \newtheorem*{is*}{IS}
  
  % a theoreme style with an italic title (similar to the proof environment) that can be used to structure proofs
  \newtheoremstyle{ittitle}% Name
    {}%                 % Space above
    {}%                 % Space below
    {}%                 % Body font
    {}%                 % Indent amount
    {\itshape}% Theorem head font
    {:}%                 % Punctuation after theorem head
    {0.5em}%              % Space after theorem head, ' ', or \newline
    {\thmnote{#3}}%     % Theorem head spec (can be left empty, meaning `normal')
  
  \theoremstyle{ittitle}
  \newtheorem*{proofsec*}{}
  
  %% define additional math symbols
  % Erwartungswert
  \newcommand{\E}{\ensuremath{\mathrm{E}}}
  \newcommand{\sign}{\ensuremath{\mathrm{sign}}}

  % configure amsmath to be used with hyperref
  \let\equation\gather
  \let\endequation\endgather
}{
  % do nothing if loaded with extendmath=false
}
  
\RequirePackage{lastpage}
\RequirePackage[headsepline]{scrpage2}
\RequirePackage{hyperref}

% commands to fill the header
\newcounter{theseries}
\newcommand{\@seriestitle}{Serie}
\newcommand{\series}[2][Serie]{\renewcommand{\@seriestitle}{#1}\setcounter{theseries}{#2}}

\newcommand{\@participant}{}
\newcommand{\@participanttitle}{Teilnehmer}
\newcommand{\participant}[2][Teilnehmer]{\renewcommand{\@participanttitle}{#1}\renewcommand{\@participant}{#2}}

\newcommand{\@tutor}{}
\newcommand{\@tutortitle}{Übungsleiter}
\newcommand{\tutor}[2][Übungleiter]{\renewcommand{\@tutortitle}{#1}\renewcommand{\@tutor}{#2}}

\newcommand{\@course}{}
\newcommand{\course}[1]{\renewcommand{\@course}{#1}}

\newcommand{\@group}{}
\newcommand{\@grouptitle}{Gruppe}
\newcommand{\group}[2][Gruppe]{\renewcommand{\@grouptitle}{#1}\renewcommand{\@group}{#2}}

\newcommand{\@corrector}{}
\newcommand{\@correctortitle}{Korrektor}
\newcommand{\corrector}[2][Korrektor]{\renewcommand{\@correctortitle}{#1}\renewcommand{\@corrector}{#2}}

% configure header and footer
\clearscrheadings
\ihead{\textbf{\@course} \hfill \textbf{\@grouptitle{}:} \@group \hfill \textbf{\@tutortitle{}:} \@tutor \hfill \textbf{\@correctortitle{}:} \@corrector \\
       \textbf{\@participanttitle{}:} \@participant \hfill \textbf{\@seriestitle{}:} \arabic{theseries}}
\cfoot{Seite \pagemark{} von \pageref{LastPage}}
\setkomafont{pageheadfoot}{\sffamily\footnotesize}
\pagestyle{scrheadings}

% macros for task headings
\newcommand{\task}[1]{\section*{\centering #1}}
\newcommand{\subtask}[1]{\subsection*{\centering #1}}
