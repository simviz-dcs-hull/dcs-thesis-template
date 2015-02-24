%% -*- Mode:LaTeX -*-

\setcounter{errorcontextlines}{4}

\def\fileversion{v0.9}
\def\filedate{2015/02/24}
\def\filename{uhull_dcs_thesis}

\ProvidesClass{\filename}[\filedate\space\fileversion\space dcs.uhull.ac.uk thesis class]

\newcommand\@degreeshort{{\ttfamily\bfseries DEGREE}}
\newcommand\@degreelong{{\ttfamily\bfseries DEGREE}}
\newcommand\@thesis{{\ttfamily\bfseries THESIS}}
\newcommand\@profession{{\ttfamily\bfseries PROFESSION}}

\DeclareOption{phd}{%
  \renewcommand{\@degreeshort}{PhD}
  \renewcommand{\@degreelong}{{Doctor of Philosophy}}
  \renewcommand{\@thesis}{{thesis}}
}
\DeclareOption{mphil}{%
  \renewcommand{\@degreeshort}{MPhil}
  \renewcommand{\@degreelong}{{Master of Philosophy}}
  \renewcommand{\@thesis}{{thesis}}
}
\DeclareOption{msc}{%
  \renewcommand{\@degreeshort}{MSc}
  \renewcommand{\@degreelong}{{Master of Science}}
  \renewcommand{\@thesis}{{dissertation}}
}
\DeclareOption{bsc}{%
  \renewcommand{\@degreeshort}{BSc}
  \renewcommand{\@degreelong}{{Bachelor of Science}}
  \renewcommand{\@thesis}{{dissertation}}
}
\DeclareOption{ceng}{%
  \renewcommand{\@profession}{Computer Engineering}
}
\DeclareOption{csci}{%
  \renewcommand{\@profession}{Computer Science}
}

\DeclareOption{twocolumn}{%
  \ClassError{\filename}{Option 'twocolumn' not supported for \filename.}{}
}
\DeclareOption{notitlepage}{%
  \ClassError{\filename}{Option 'notitlepage' not supported for \filename.}{}
}

\newcommand\@supervisorone{{\ttfamily\bfseries SUPERVISOR}}
\newcommand\@supervisortwo{{\ttfamily\bfseries 2ND EXAMINER}}
\newcommand\@supervisorext{{\ttfamily\bfseries EXTERNAL}}
\newcommand\@supervisorchair{{\ttfamily\bfseries CHAIR}}

\newcommand{\supervisor}[2][1st]{%
  \ifthenelse{\equal{#1}{1st}}  {%
    \renewcommand{\@supervisorone}{#2}
  }{%
    \ifthenelse{\equal{#1}{2nd}}{%
      \renewcommand{\@supervisortwo}{#2}
    }{%
      \ifthenelse{\equal{#1}{ext}}{%
        \renewcommand{\@supervisorext}{#2}
      }{%
        \ifthenelse{\equal{#1}{chair}}{%
          \renewcommand{\@supervisorchair}{#2}
        }
      }
    }
  }
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
    11pt,
    BCOR=5mm,
    DIV=calc,
    a4paper,
    twoside,
  }{scrbook}
}
\DeclareOption{online}{%
  \@printmodefalse
  \PassOptionsToClass{%
    12pt,
    BCOR=0mm,
    DIV=classic,
    a4paper,
    oneside,
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
  toc=graduated,
}{scrbook}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\ExecuteOptions{final,online,bsc,csci}
\ProcessOptions
\LoadClass{scrbook}

\RequirePackage{ifxetex}

\ifxetex
  \RequirePackage{fontspec}
  \defaultfontfeatures{Ligatures=TeX}
  \RequirePackage{polyglossia}
  \setmainlanguage[variant=usmax]{english}
\else
  \RequirePackage[OT2,T1]{fontenc}
  \RequirePackage[latin1]{inputenc}
  \RequirePackage[USenglish]{babel}
  \RequirePackage[yyyymmdd]{datetime}
\fi

\RequirePackage{calc}
\RequirePackage{checkend}
\RequirePackage{enumitem}
\RequirePackage{etex}
\RequirePackage{etoolbox}
\RequirePackage{graphicx}
\RequirePackage{rotating}
\RequirePackage{scrpage2}
\RequirePackage{setspace}
\RequirePackage{xifthen}

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
  \PackageInfo{\filename}{%
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
\defpagestyle{uhulldcsthesisheadings}{%
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
\pagestyle{uhulldcsthesisheadings}

%% startvskip: space before chapter title (should be fix; default: see scrboock.cls)
%% endvskip: space after chapter title (should be variable or glue; default: see scrboock.cls)
\renewcommand*{\chapterheadstartvskip}{\vspace*{.5\baselineskip}}
\renewcommand*{\chapterheadendvskip}{\vspace{2.5\baselineskip}}

\PackageInfo{\filename}{%
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

    \begin{tabular}{lcr}
      {%
        \begin{minipage}[b][0.985\textheight]{0.11\textwidth}
          \includegraphics[trim=18 19 20 18,clip,draft=false,angle=90,width=0.61\textwidth]
          {figures/uhull_logo_black}%
          \hfill
          \begin{sideways}
            \sffamily\small\,Department of Computer Science
          \end{sideways}
        \end{minipage}
      } &
      \hspace{0.9em} &
      {%
        \begin{minipage}[b][0.983\textheight]{0.71\textwidth}
          \vspace{6ex}
          \begin{flushleft}
            {\sffamily\bfseries\huge\hspace{-.125em}\@title}\\
            \vspace{5ex}
            {\sffamily\Large by\ \@author}\\
            \vspace{5ex}
            {\sffamily\large\@date}
            \vfill
            {\sffamily
              A \@thesis\ submitted in partial conformity with the requirements for the degree of
              \@degreelong\ (\@degreeshort)\\
              in \@profession}\par
            \vspace{5ex plus 1ex minus 2ex}
            {\sffamily
              \begin{tabular}{rl}
                Supervisor:                     & \@supervisorone\\
                2\textsuperscript{nd} Examiner: & \@supervisortwo\\
                \ifthenelse{\equal{\@degreeshort}{PhD}}{%
                  External Examiner:            & \@supervisorext\\
                }{}
                \ifthenelse{\equal{\@degreeshort}{MPhil}\or\equal{\@degreeshort}{PhD}}{%
                  Panel Chair:                  & \@supervisorchair\\
                }{}
              \end{tabular}
            }
            \vspace{1pt plus 0pt minus 1pt}
          \end{flushleft}
        \end{minipage}
      }
    \end{tabular}
    
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
      {\sffamily\large\@dedication}\par
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

\ifthenelse{\not\boolean{@internalreview}}{%
  \date{}
}{}

\ifthenelse{\boolean{@printmode}}{%
  \extratitle{%
    \ifthenelse{\boolean{cropmarks}}{%
      {%
        \crop[axes,cross]
        \mbox{}
        \clearpage
        \thispagestyle{empty}
        \cleardoublepage
        \thispagestyle{empty}
      }%
    }
    \noindent
    \vspace*{2.3\baselineskip}
    \begin{flushright}
      \begin{minipage}[t]{.875\textwidth}
        \begin{flushleft}
          \leavevmode
          \sffamily\bfseries\huge\@title
        \end{flushleft}
      \end{minipage}
    \end{flushright}
  }
}{}

\newcommand{\thesiscopyright}{%
  \begin{center}
    \sffamily\small\textcopyright\hspace*{.4em}\oldstylenums{\the\year}\hspace*{.5em}\@author\@. All
    rights reserved.
  \end{center}
}

\newcommand{\enablemicrotyping}{%
  \ifxetex
  \typeout{^^J\filename:Not using package 'microtype' in xetex mode^^J}%
  \else
  \RequirePackage{microtype}
  \microtypesetup{%
    final,
    activate={true,nocompatibility},
    kerning=true,
    spacing=true,
    tracking=true,
    factor=1100,
    stretch=10,
    shrink=10,
    verbose=errors,
  }
  \microtypecontext{%
    spacing=nonfrench,
  }
  \ifthenelse{\pdftexversion>130}{%
    \DisableLigatures{encoding=T1,family=tt*}
  }{}
  \fi
}

\newcommand{\setupcaptions}{%
  \captionsetup{%
    font={small,sf},
    format=plain,
    justification=raggedright,
    labelfont=bf,
    margin=1pt,
    singlelinecheck=1,
  }
  \captionsetup*[subfloat]{%
    font={footnotesize,sf},
    format=hang,
    labelsep=space,
    margin=2pt,
    singlelinecheck=0,
  }
}

\newcommand{\setuphyperref}{%
  \RequirePackage{hyperref}
  \RequirePackage{xcolor}
  \definecolor{href:citecolor}{rgb}{.002,.002,.56}
  \definecolor{href:linkcolor}{rgb}{.002,.002,.56}
  \hypersetup{%
    breaklinks = true,
    citecolor  = href:citecolor,
    colorlinks = true,
    draft      = false,
    linkcolor  =,
    linktoc    = all,
    plainpages = false,
    urlcolor   = href:linkcolor,
    pdfauthor  = {\@author},
    pdftitle   = {\@title},
  }
  \ifthenelse{\boolean{@draftmode}}{%
    \hypersetup{%
      pdfsubject = {\@degreeshort\ \@thesis\ draft, Department of Computer Science, University of
        Hull},
    }
  }{%
     \hypersetup{%
      pdfsubject = {\@degreeshort\ \@thesis, Department of Computer Science, University of Hull},
    }
  }
  \ifthenelse{\boolean{@printmode}}{%
    \hypersetup{%
      citecolor=,
      urlcolor=,
    }
  }{}
  \ifxetex
  \typeout{^^J\filename:No tinkering with PDF setup in xetex mode^^J}%
  \else
  \pdfcompresslevel=9
  \ifthenelse{\pdftexversion>121}{%
    \pdfoptionpdfminorversion=5
    \pdfimagehicolor=1
  }{}
  \ifthenelse{\pdftexversion>130}{%
    \pdfobjcompresslevel=3
  }{}
  \pdfinfo{%
    /GTS_PDFXVersion (PDF/X-3:2003)
  }
  \fi
}

\AtEndPreamble{%
  \lowertitleback{%
    \thesiscopyright
  }
  \ifthenelse{\not\boolean{@printmode}}{%
    \dedication{%
      \vspace*{.875\textheight}
      \thesiscopyright
    }
  }{}
  \setupcaptions
  \setuphyperref
  \KOMAoptions{DIV=last}
  \enablemicrotyping
}

% chapter preamples
\renewcommand*{\dictumauthorformat}[1]{#1}
\setkomafont{dictumauthor}{\slshape}

\newcommand{\chapterpreamble}[3]{%
  \renewcommand*{\dictumwidth}{#1}
  \setchapterpreamble[u]{%
    \begin{spacing}{1}
      \dictum[#2]{{#3}}
      \vspace{2\baselineskip}
    \end{spacing}
  }
}

\endinput

%%% Local Variables:
%%% mode: latex
%%% TeX-master: "uhull_dcs_thesis"
%%% End:
