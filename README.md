# Breeder Genomics Hub
**🧬 Experimental / Alpha-Quality Software 🧪**

The Breeder Genomics Hub is a batteries-included [JupyterHub](https://jupyter.org/hub) distribution for breeders ([Pangeo](https://pangeo.io/) for plant scientists).

Please refer to the [documentation website](https://hub.maizegenetics.net) for more information, in particular:
* [Getting started](https://hub.maizegenetics.net/getting-started) with the Breeder Genomics Hub in your lab
* [Example with notes](https://hub.maizegenetics.net/example) on how the Buckler Lab uses the Breeder Genomics Hub alongside a RESTful [PHG](https://www.maizegenetics.net/phg) web server (see the [`example/`](./example) directory of this repo for configs)
* [When to use](https://hub.maizegenetics.net/when-to-use) the Breeder Genomics Hub, and alternatives like [TLJH](https://tljh.jupyter.org) and [Z2JH](https://z2jh.jupyter.org)

The [breeder-notebook](https://github.com/maize-genetics/breeder-notebook) Jupyter Docker Stack is the end-user environment, and contains common bioinformatics software useful to plant scientists and breeders, such as [rPHG](https://rphg.maizegenetics.net/) and [rTASSEL](https://rtassel.maizegenetics.net/).

## Development
### Documentation
Documentation is hosted via [GitHub Pages](https://pages.github.com/), which provides easy [Jekyll](https://jekyllrb.com/) integration.

To build the docs site locally:

```console
cd docs
bundle install
bundle exec jekyll serve
```

Requires [Ruby](https://www.ruby-lang.org).