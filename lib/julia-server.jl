using Pkg;

LintPkg = PackageSpec(url="https://github.com/tonyhffong/Lint.jl", rev="master");

named_pipe = ARGS[1]

if get(Pkg.installed(), "Lint", nothing) == nothing == nothing
    print(Base.stderr, "linter-julia-installing-lint");
    try
        Pkg.add(LintPkg);
    catch
        print(Base.stderr, "linter-julia-msg-install");
        rethrow();
    end
else
    if get(Pkg.installed(), "Lint", nothing) < v"0.3.0"
        print(Base.stderr, "linter-julia-updating-lint");
        try
            # NOTE: This doesn't appear to be working?
            Pkg.update(LintPkg);
        catch
            print(Base.stderr, "linter-julia-msg-update");
            rethrow();
        end
    else # start the server
        try
            using Lint;
            lintserver(named_pipe,"standard-linter-v2");
        catch
            print(Base.stderr, "linter-julia-msg-load");
            rethrow();
        end
    end
end
