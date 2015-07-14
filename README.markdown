### Development

To develop this library, first get its submodules:

```sh
git submodule init
git submodule update
```

Then, load `development.cm` in the SML/NJ repl:

```sh
rlwrap sml
> CM.make "development.cm";
```

### Library Integration

To use this library as a dependency, you need to source `zipper.cm` in your CM
file, and bind the `libs` anchor to a location which contains
[`sml-spreads`](https://github.com/jonsterling/sml-spreads). For example, if
`vendor` contains the `sml-spreads` dependency, use:

```cm
  zipper.cm (bind:(anchor:libs value:vendor))
```
