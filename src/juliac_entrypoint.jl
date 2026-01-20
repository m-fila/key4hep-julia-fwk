# workaround for JuliaC.jl requiring package names to be same as project directory
#https://github.com/JuliaLang/JuliaC.jl/issues/101
include("FrameworkDemo.jl")

using .FrameworkDemo: main
