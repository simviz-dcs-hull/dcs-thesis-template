%% -*- Mode:LaTeX -*-

\def\fileversion{v0.9}
\def\filedate{2014/09/17}

\ProvidesClass{uhull_dcs_thesis}[\filedate\space\fileversion\space dcs.uhull.ac.uk thesis class]

\newcommand\@degree{{\ttfamily\bfseries DEGREE}}
\newcommand\@thesis{{\ttfamily\bfseries THESIS}}


\DeclareOption{phd}{%
  \renewcommand\@degree{{Doctor of Philosophy (PhD)}}
  \renewcommand\@thesis{{thesis}}
}
\DeclareOption{mphil}{%
  \renewcommand\@degree{{Master of Philosophy (MPhil)}}
  \renewcommand\@thesis{{thesis}}
}
\DeclareOption{msc}{%
  \renewcommand\@degree{{Master of Science (MSc)}}
  \renewcommand\@thesis{{thesis}}
}
\DeclareOption{bsc}{%
  \renewcommand\@degree{{Bachelor of Science (BSc)}}
  \renewcommand\@thesis{{thesis}}
}

\DeclareOption{twocolumn}{%
  \ClassError{uhull_dcs_thesis}{Option 'twocolumn' not supported for BUW theses.}{}
}

\DeclareOption{notitlepage}{%
  \ClassError{uhull_dcs_thesis}{Option 'notitlepage' not supported for BUW theses.}{}
}

%% internal review
\newif\if@internalreview
\@internalreviewfalse
\DeclareOption{internalreview}{%
  \@internalreviewtrue
}

%% draftmode
\newif\if@draftmode
\@draftmodefalse
\DeclareOption{draft}{%
  \@draftmodetrue
  \PassOptionsToClass{draft}{scrbook}
}

%% final
\DeclareOption{final}{%
  \@internalreviewfalse
  \@draftmodefalse
  \PassOptionsToClass{final}{scrbook}
}

%% printmode
\newif\if@printmode
\@printmodefalse
\DeclareOption{print}{%
  \@printmodetrue
  \PassOptionsToClass{%
    10pt,
    BCOR5mm,
    DIV=calc,
    a5paper,
    twoside,
    version=first,
  }{scrbook}
}
\DeclareOption{online}{%
  \@printmodefalse
  \PassOptionsToClass{%
    12pt,
    BCOR0mm,
    DIV=classic,
    a4paper,
    oneside,
    version=first,
  }{scrbook}
}

%% general scrbook options
\PassOptionsToClass{%
  bibliography=totoc,
  chapterprefix,
  cleardoublepage=empty,
  fleqn,
  headsepline,
  index=totoc,
  listof=totoc,
  numbers=noenddot,
  openbib,
  toc=graduated,
  version=first,
}{scrbook}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\ExecuteOptions{bsc}
\ProcessOptions
\LoadClass{scrbook}

\RequirePackage{calc}
\RequirePackage{ifthen}
\RequirePackage{lmodern}
\RequirePackage{scrpage2}
\RequirePackage{setspace}

\ifthenelse{\boolean{@draftmode}}{%
  %% create 1.5\baselineskip
  \onehalfspacing
  \typearea[current]{last}
}{}

\ifthenelse{\not\isundefined{\KOMAScriptVersion}}{%
  \ifthenelse{\boolean{@printmode}}{%
    \addtolength{\topmargin}{-.1\topmargin}
    % \addtolength{\textheight}{-1\baselineskip}
    % \setlength{\parskip}{0pt plus.5\baselineskip minus0pt}
  }{%
    \addtolength{\topmargin}{-.2\topmargin}
    \addtolength{\textheight}{4\baselineskip}
  }
  \PackageInfo{uhull_dcs_thesis}{%
          \space\string\parindent\space=\space\the\parindent\MessageBreak
\space\space\space\string\parskip\space=\space\the\parskip\MessageBreak
          \space\string\topmargin\space=\space\the\topmargin\MessageBreak
               \string\textheight\space=\space\the\textheight\MessageBreak
  }
}{}

%% \headmark and \pagemark font style
\renewcommand{\headfont}{\normalfont\sffamily}
\renewcommand{\pnumfont}{\normalfont\sffamily}

%% headings/footings
\defpagestyle{buwthesisheadings}{%
  % header
  % (\textwidth+10mm,.1mm)
  {\pagemark\hfill\headmark}{\headmark\hfill\pagemark} % 2side, {l}{r}
  {\headmark\hfill\pagemark}                           % 1side
  (\textwidth+3pt,.5pt)
}{%
  % footer
  % (\textwidth+3pt,.5pt)
  {}{} % 2side, {l}{r}
  {}   % 1side
  % (\textwidth+10mm,.1mm)
}
\pagestyle{buwthesisheadings}

%% startvskip: space before chapter title (should be fix; default: see scrboock.cls)
%% endvskip: space after chapter title (should be variable or glue; default: see scrboock.cls)
\renewcommand*{\chapterheadstartvskip}{\vspace*{.5\baselineskip}}
\renewcommand*{\chapterheadendvskip}{\vspace{2.5\baselineskip}}

\PackageInfo{uhull_dcs_thesis}{%
            \string\chapterheadstartvskip\space=\space\chapterheadstartvskip\MessageBreak
  \space\space\string\chapterheadendvskip\space=\space\chapterheadendvskip\MessageBreak
}

%% cleardoublepage produces empty left pages before new chapter
\renewcommand*{\chapterpagestyle}{empty}

% \@startsection {NAME}{LEVEL}{INDENT}{BEFORESKIP}{AFTERSKIP}{STYLE} 
%            optional * [ALTHEADING]{HEADING}
%    Generic command to start a section.  
%    NAME       : e.g., 'subsection'
%    LEVEL      : a number, denoting depth of section -- e.g., chapter=1,
%                 section = 2, etc.  A section number will be printed if
%                 and only if LEVEL < or = the value of the secnumdepth
%                 counter.
%    INDENT     : Indentation of heading from left margin
%    BEFORESKIP : Absolute value = skip to leave above the heading.  
%                 If negative, then paragraph indent of text following 
%                 heading is suppressed.
%    AFTERSKIP  : if positive, then skip to leave below heading,
%                       else - skip to leave to right of run-in heading.
%    STYLE      : commands to set style
%  If '*' missing, then increments the counter.  If it is present, then
%  there should be no [ALTHEADING] argument.  A sectioning command
%  is normally defined to \@startsection + its first six arguments.
\renewcommand{\paragraph}{%
  \@startsection{paragraph}{4}{\z@}{1ex \@plus.75ex \@minus.25ex}{-1em}%
  {\raggedsection\normalfont\sectfont\nobreak\size@paragraph\nobreak}%
}

%% sectioning font style
\addtokomafont{chapter}{\sffamily}
\addtokomafont{section}{\sffamily}
\addtokomafont{subsection}{\sffamily}
\addtokomafont{subsubsection}{\sffamily}
\addtokomafont{paragraph}{\sffamily\bfseries}
\addtokomafont{subparagraph}{\sffamily\bfseries}

%% footnotes
% \deffootnote{1.25em}{1em}{\makebox[1.25em][l]{\thefootnotemark}}
% \setkomafont{footnote}{\sffamily}

%% abstract env.
\newcommand{\@abstractname}{Abstract}
\newenvironment{abstract}{%
  \chapter*{\@abstractname}%
  \@mkboth{\@abstractname}{\@abstractname}%
}{}

%% acknowledgments env.
\newcommand{\@acknowledgmentsname}{Acknowledgments}
\newenvironment{acknowledgments}{%
  \chapter*{\@acknowledgmentsname}%
  \@mkboth{\@acknowledgmentsname}{\@acknowledgmentsname}%
}{}

\renewcommand*\maketitle[1][1]{%
  \begin{titlepage}%
    \setcounter{page}{#1}
    \let\footnotesize\small
    \let\footnoterule\relax
    \let\footnote\thanks
    \renewcommand*{\thefootnote}{\@fnsymbol\c@footnote}
    \let\@oldmakefnmark\@makefnmark
    \renewcommand*{\@makefnmark}{\rlap\@oldmakefnmark}

    \ifthenelse{\not\equal{@extratitle}{}}{%
      \noindent
      \@extratitle
      \clearpage
      \thispagestyle{empty}
      \cleardoublepage
      \thispagestyle{empty}
    }{}

    \vspace*{6ex}

    \begin{flushright}
      \noindent
      \begin{minipage}[t]{.875\textwidth}
        \begin{flushleft}
          {%
            \sffamily\bfseries\huge
            \@title
            \par
          }
          \vspace*{5ex}
          {%
            \sffamily\Large
            by \@author
            \par
          }
          \vspace*{5ex}
          {%
            \sffamily\large
            \@date
            \par
          }
        \end{flushleft}
      \end{minipage}
    \end{flushright}
    \par
    \vfill
    \begin{flushright}
      \noindent
      \begin{minipage}[b]{.875\textwidth}
        \begin{flushleft}
          {%
            \sffamily\large
            A \@thesis\ submitted in conformity with\\
            the requirements for the degree of \@degree
            \par
          }
          \vspace*{5ex}
          {%
            \sffamily\large
            University of Hull\\
            Department of Computer Science
            \par
          }
          \ifthenelse{\not\equal{@publishers}{}}{%
            \vspace*{5ex} 
            {%
              \sffamily\large
              \@publishers
              \par
            }
          }{}
        \end{flushleft}
      \end{minipage}
    \end{flushright}
    
    \@thanks
    
    \ifthenelse{\boolean{@twoside}}{%
      \clearpage
      \thispagestyle{empty}
      \noindent
      \begin{minipage}[t]{\textwidth}
        \@uppertitleback
      \end{minipage}
      \par
      \vfill
      \noindent
      \begin{minipage}[b]{\textwidth}
        \@lowertitleback
      \end{minipage}
    }{}

    \ifthenelse{\not\equal{@dedication}{}}{%
      \clearpage
      \thispagestyle{empty}
      \vfill
      {%
        \sffamily\large
        \@dedication
        \par
      }
      \ifthenelse{\boolean{@twoside}}{%
        \clearpage
        \thispagestyle{empty}
        \cleardoublepage
      }{}
    }{}
  \end{titlepage}
  \setcounter{footnote}{0}
}

\newboolean{cropmarks}
\setboolean{cropmarks}{false}

\endinput

%%% Local Variables:
%%% mode: latex
%%% TeX-master: "uhull_dcs_thesis"
%%% End:
