# *Salomon* (*BSD* port) <img src="https://raw.githubusercontent.com/urbanware-org/salomon-bsd/master/wiki/salomon-bsd.png" alt="Salomon BSD port logo" height="128px" width="128px" align="right"/>

**Table of contents**
*   [Definition](#definition)
*   [Details](#details)
*   [Usage](#usage)
*   [Requirements](#requirements)
*   [Limitations](#limitations)
*   [Version numbers](#version-numbers)
*   [Support the project](#support-the-project)
*   [Contact](#contact)
*   [Useless facts](#useless-facts)

----

## Definition

The *Salomon* project is a simple log file monitor and analyzer with various filter and highlighting features which can also be used with other text files.

:smiling_imp: This is the *BSD* port of the project developed on *FreeBSD* and tested on various [distributions](#distributions).

:penguin: The *Linux* version can be found [here](https://github.com/urbanware-org/salomon).

:information_source: Notice that the [version numbers](#version-numbers) of this port are independent from the *Linux* version of the project.

[Top](#salomon-bsd-port-)

## Details

### Project

<img src="https://raw.githubusercontent.com/urbanware-org/salomon-bsd/master/wiki/salomon_output.png" alt="Salomon sample output" width=320px align="right"/>The project was primarily built to monitor and analyze log files inside a terminal emulator and also on systems without a graphical user interface. Of course, you can use the features of *Salomon* with other plain text files of any kind.

The input files will be processed line by line.

Each line can easily be colorized with a user-defined color (and additionally highlighted in different ways) depending on given criteria. For example, all lines which contain the word "error" can be displayed red and those that contain the word "success" can be displayed green (as shown above). Furthermore, the output can be filtered to only return certain lines instead of all.

<img src="https://raw.githubusercontent.com/urbanware-org/salomon-bsd/master/wiki/salomon_dialog_inputfile.png" alt="Salomon interactive dialog" align="right"/>There are various additional combinable features such as multiple ways to filter the output (e.g. by using exclude and remove patterns) and different methods to additionally highlight the filter terms. The output can also be paused or slowed down with a user-defined delay.

Furthermore, as you can see on the right, there is the option to use interactive dialogs instead of or in combination with command-line arguments which is useful when e.g. running *Salomon* via shortcut in a terminal window on a graphical user interface.

### Distributions

Originally, the development of the *BSD* port was started under *OpenBSD*, but has moved to *FreeBSD*. This also is the only *BSD* derivate where the project is being tested regularly.

The project has been tested on the following distributions, yet.

| Distribution | Version | Architecture | Bash | Comment                                |
| ------------ | ------: | :----------: | ---: | ---------------------------------------|
| *FreeBSD*    |    12.0 | `amd64`      |  5.0 | Runs out of the box.                   |
| *FreeBSD*    |    12.1 | `amd64`      |  5.0 | Runs out of the box.                   |
| *FreeBSD*    |    13.0 | `amd64`      |  5.0 | Runs out of the box.                   |
| *NetBSD*     |     8.0 | `amd64`      |  5.0 | Runs out of the box.                   |
| *OpenBSD*    |     6.4 | `amd64`      |  4.4 | See [limitations](#limitations) below. |
| *OpenBSD*    |     6.5 | `amd64`      |  5.0 | See [limitations](#limitations) below. |
| *OpenBSD*    |     6.6 | `amd64`      |  5.0 | See [limitations](#limitations) below. |
| *OpenBSD*    |     6.7 | `amd64`      |  5.0 | See [limitations](#limitations) below. |

[Top](#salomon-bsd-port-)

## Usage

### Quick start

You can get started with *Salomon* in less than two minutes by reading the *Salomon* [quick start guide](https://github.com/urbanware-org/salomon/wiki/Quick-start).

### Documentation

You can find a fundamental documentation inside the *Salomon* [wiki](https://github.com/urbanware-org/salomon/wiki).

In the `docs` sub-directory of the project, there are plain text files containing a detailed documentation for each component with further information and usage examples.

[Top](#salomon-bsd-port-)

## Requirements

### Packages

The *Salomon* project was developed on (and for) the *Bash* shell, which is the default shell on many *Unix*-like systems (or at least *Linux* distributions).

Furthermore, it uses popular shell utilities that should be pre-installed by default. See the included `REQUIREMENTS` file for details.

[Top](#salomon-bsd-port-)

## Limitations

### *OpenBSD*

Unlike in *FreeBSD* or *NetBSD*, the `sed` command provided by default in *OpenBSD* does not support the `i` (ignore case) flag.

Due to this, there are some limitations (or differences) which affect the `-hm` (or `--highlight-matches`) and `-hu` (or `--highlight-upper`) as well as the `-r` (or `--remove`) argument.

When using `-hu` (or `--highlight-upper`), the whole line will be switched to upper case instead of just the highlighted term.

Furthermore, `-hm` (or `--highlight-matches`) is identical with `-hu` (or `--highlight-upper`). Both arguments have the same effect.

The remove pattern from `-r` (or `--remove`) is always case-sensitive unless one of those highlighting arguments is also given. If so, the remove pattern is automatically applied in upper case for those lines. So, in that constellation the pattern is case-insensitive.

[Top](#salomon-bsd-port-)

## Version numbers

Notice that although the version numbers of this port are similar (or maybe even the same) to the *Linux* version of *Salomon*, the releases are not identical and also not necessarily related.

The *BSD* port was built from *Salomon* 1.13.0 for *Linux*. Due to this, the releases of the port started with that version number.

[Top](#salomon-bsd-port-)

## Support the project

You do not need to be a software developer to support the project.

If you have any requests or suggestions for improving or extending *Salomon*, its documentation or the color schemes, just let me know.

For example, if you have created a color config file for a log file which you want to share, you can send it to me so I can add it to the color config files distributed with *Salomon* by default.

[Top](#salomon-bsd-port-)

## Contact

Any suggestions, questions, bugs to report or feedback to give?

You can contact me by sending an email to [dev@urbanware.org](mailto:dev@urbanware.org) or by opening a *GitHub* issue (which I would prefer if you have a *GitHub* account).

Further information can be found inside the `CONTACT` file.

[Top](#salomon-bsd-port-)

## Useless facts

Whoever cares can find them [here](https://github.com/urbanware-org/salomon/wiki#useless-facts).

[Top](#salomon-bsd-port-)
