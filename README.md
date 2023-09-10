LearnerFlow client
=================

This custom version of the Hypothesis client has been adapted from the original [`hypothesis/client`](https://github.com/hypothesis/client) to include several enhancements:

1. **New Granular Tagging Categories**: We've introduced additional tagging categories, including "Comment," "Important," "Errata," "Interesting," "Confusing," and "Question." These tags allow for more precise annotation categorization.

2. **Upvote Feature**: We've added an upvote feature for posts, providing users with the ability to endorse annotations or comments.

3. **Enhanced Analytics**: Our customized client includes enhanced analytics capabilities that track every click, keypress, and scroll on the page. This feature provides valuable insights into user interactions and behaviors within the platform.

Feel free to explore these enhancements and provide feedback on their functionality.

For the original Hypothesis client repository, please visit [here](https://github.com/hypothesis/client).

To explore these additions, simply clone or download this repository and follow the installation instructions provided. Enjoy exploring the enhanced features!


[![Build status](https://img.shields.io/travis/hypothesis/client/master.svg)][travis]
[![npm version](https://img.shields.io/npm/v/hypothesis.svg)][npm]
[![#hypothes.is IRC channel](https://img.shields.io/badge/IRC-%23hypothes.is-blue.svg)][irc]
[![BSD licensed](https://img.shields.io/badge/license-BSD-blue.svg)][license]

[travis]: https://travis-ci.org/hypothesis/client
[npm]: https://www.npmjs.com/package/hypothesis
[irc]: https://www.irccloud.com/invite?channel=%23hypothes.is&amp;hostname=irc.freenode.net&amp;port=6667&amp;ssl=1
[license]: https://github.com/hypothesis/client/blob/master/LICENSE

The Hypothesis client is a browser-based tool for making annotations on web
documents. It is used by the [Hypothesis browser extension][ext], and can also
be [embedded directly on web pages][embed].

![Screenshot of Hypothesis client](/images/screenshot.png?raw=true)

[ext]: https://chrome.google.com/webstore/detail/hypothesis-web-pdf-annota/bjfhmglciegochdpefhhlphglcehbmek
[embed]: https://hypothes.is/for-publishers/

Development
-----------

We'll soon be adding instructions on how to set up a development environment for
the Hypothesis client.

If you are already clear on the difference between this repository and the
[`hypothesis/h`](https://github.com/hypothesis/h) repository then in the mean
time the [Contributor's Guide](https://h.readthedocs.io/en/latest/developing/)
may be of use. Be aware that many instructions in that guide do not apply to
this repository.

Community
---------

Join us in [#hypothes.is][irc] on [freenode](https://freenode.net/) for
discussion.

If you'd like to contribute to the project, you should consider subscribing to
the [development mailing list][ml], where we can help you plan your
contributions.

Please note that this project is released with a [Contributor Code of
Conduct][coc]. By participating in this project you agree to abide by its terms.

[ml]: https://groups.google.com/a/list.hypothes.is/forum/#!forum/dev
[coc]: https://github.com/hypothesis/client/blob/master/CODE_OF_CONDUCT

License
-------

The Hypothesis client is released under the [2-Clause BSD License][bsd2c],
sometimes referred to as the "Simplified BSD License". Some third-party
components are included. They are subject to their own licenses. All of the
license information can be found in the included [LICENSE][license] file.

[bsd2c]: http://www.opensource.org/licenses/BSD-2-Clause
[license]: https://github.com/hypothesis/client/blob/master/LICENSE
