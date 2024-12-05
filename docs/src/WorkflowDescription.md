# Workflow description

## Data-flow graph

A data-flow graph (DFG) is a directed acyclic graph (DAG)that describes the data dependencies between algorithms, which dictate their execution order. If one algorithm requires input from another's output, it must wait for that computation to complete before proceeding. The flow of data through the graph determines when each operation can execute, as algorithms can only run once their data dependencies are resolved. As a result, operations that have dependencies cannot be executed in parallel.

### Properties

| Property           | Type     | Description                                                                                   |
|--------------------|----------|-----------------------------------------------------------------------------------------------|
| `node_id`          | string   | Unique name of a vertex.                                                                       |
| `type`             | string   | Either `Algorithm` for algorithm vertices or `DataObject` for data-object vertices.            |
| `class`            | string   | Optional. Name of the concrete implementation used for the given algorithm or data object, provided for verification or debugging purposes only. |
| `size_average_B`   | double   | Optional. Defined only for data-object vertices. Average object memory footprint in bytes.     |
| `runtime_average_s`| double   | Optional. Defined only for algorithm vertices. Average execution duration in seconds.          |

**Note:** Edges do not have any defined properties.

### Rules

An edge `DataObject` $\rightarrow$ `Algorithm` represents input relation, while `Algorithm` $\rightarrow$ `DataObject` represents output relation.

Edges connecting vertices of the same type are not allowed (no `DataObject` $\rightarrow$ `DataOBject` or `Algorithm` $\rightarrow$ `Algorithm` edges).

A `DataObject` vertex must have exactly one predecessor but can have any number of successors including zero. An `Algorithm` vertex can have any number including zero of predecessors or successors.  

## Control-flow graph

!!! warning
    Control-flow graph scheduling is not implemented yet in the project

A control-flow graph (CFG) is a DAG describing 

### Properties
| Property            | Type     | Description                                                                                       |
|---------------------|----------|---------------------------------------------------------------------------------------------------|
| `node_id`           | string   | Unique name of a vertex.                                                                           |
| `type`              | string   | Either `Algorithm` for algorithm vertices or `DecisionHub` for decision-hub vertices.              |
| `sequential`        | boolean  | Defined only for decision-hub vertices. If true the direct successors must be executed sequentially according to their order. Otherwise, the direct successors can be executed in parallel if the data-flow allows it.                                    |
| `ignoreFilterPassed`| boolean  |                                                                                                   |
| `shortCircuit`      | boolean  | Defined only for decision-hub vertices. If true the decision-hub use short-circuit evaluation for its logical operation meaning the successors are evaluated lazily until the decision value is determined, possibly skipping execution of some successors. Otherwise, the successors are evaluated eagerly without skipping.                                                           |
| `modeOR`            | boolean  | Defined only for decision-hub vertices. If true the decision-hub applies logical OR operations to its successors decisions, otherwise logical AND operations is applied.                                                          |
| `blocking`          | boolean  | Defined only for algorithm vertices.  Indicates that the the                                                           |

**Note:** Edges do not have any defined properties.

### Rules

A graph must have an universal source/root vertex of type `DecisionHub`.

Only edges `DecisionHub` $\rightarrow$ `DecisionHub` or `DecisionHub` $\rightarrow$ `Algorithm` are allowed. 

An `Algorithm` vertex must have exactly one predecessor (of type `DecisionHub`) and must not have any successors. A `DecisionHub` vertex must have exactly one predecessor (of type `DecisionHub`) and can have any number including zero of successors.

A `DecisionHub` with property `sequential = false` must have property `shortCircuit=false` as short-circuit logic is not allowed with parallel execution.

### Logic

In a control-flow graph, decision hubs determine the flow of execution based on evaluated conditions. These hubs utilize logical operations in a form structured Boolean expression, to combine the filter decisions of their components. Each decision hub can implement either an `AND` or `OR` logic, where an `AND` hub requires all child nodes to yield a positive result for the decision to be affirmative, while an `OR` hub allows for a positive outcome if at least one child node succeeds. The use of short-circuit evaluation enhances efficiency; for instance, in an `AND` decision, if any child node returns a negative outcome, the subsequent nodes need not be evaluated, as the overall decision will be negative. Conversely, in an `OR` scenario, evaluation can cease as soon as a positive decision is reached among the children. This logical structuring within decision hubs ensures a modular and flexible approach to managing complex decision-making processes, facilitating clearer paths for execution and enhancing overall performance in the control-flow graph.