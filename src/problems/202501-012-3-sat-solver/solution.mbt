// Additional type definitions or helper functions go here

///| DPLL
fn solution(variables : Int, clauses : Array[(Int, Int, Int)]) -> Array[Bool] {
  for i in 0..<(1 << variables) {
    let res = Array::make(variables, false)
    for j in 0..<variables {
      res[j] = (i & (1 << j)) != 0
    }
    let sat = clauses
      .iter()
      .all(fn {
        clause =>
          [clause.0, clause.1, clause.2]
          .iter()
          .any(fn {
            lit => (lit > 0 && res[lit - 1]) || (lit < 0 && res[-lit - 1])
          })
      })
    if sat {
      return res
    }
  }
  []
}

// Public test cases go here

test {
  inspect!(
    solution(3, [(1, -2, 3), (-1, 2, -3), (1, 2, -3)]),
    content="[true, false, true]",
  )
}
