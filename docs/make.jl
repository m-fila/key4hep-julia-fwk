using Documenter
using FrameworkDemo

makedocs(sitename = "FrameworkDemo.jl",
         pages = [
             "Home" => "index.md",
             "MockupRunner.md",
             "WorkflowDescription.md",
             "LogsVisualization.md",
             "AlgorithmInterface.md",
             "API" => "API.md"
         ])
