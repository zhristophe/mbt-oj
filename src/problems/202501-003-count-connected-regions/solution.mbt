///|
fn solution(grid : Array[Array[Int]]) -> Int {
  let mut res = 0
  grid.eachi(fn(i, row) {
    row.eachi(fn(j, col) {
      if col == 0 {
        return
      }
      res += 1
      dfs(grid, i, j)
    })
  })
  res
}

///| 把相邻1染白
fn dfs(grid : Array[Array[Int]], i : Int, j : Int) -> Unit {
  if i < 0 ||
    i >= grid.length() ||
    j < 0 ||
    j >= grid[i].length() ||
    grid[i][j] == 0 {
    return
  }
  grid[i][j] = 0
  for pt in [(i - 1, j), (i + 1, j), (i, j - 1), (i, j + 1)] {
    let (i, j) = pt
    dfs(grid, i, j)
  }
}

///|
test {
  inspect!(solution([[1, 0], [0, 1]]), content="2")
  inspect!(
    solution([
      [1, 0, 0, 0, 0],
      [1, 0, 1, 0, 0],
      [0, 0, 0, 1, 1],
      [0, 0, 0, 1, 1],
    ]),
    content="3",
  )
}

///|
test {
  inspect!(solution([[0, 1], [1, 1]]), content="1")
  inspect!(solution([[0]]), content="0")
  inspect!(
    solution([
      [1, 1, 1, 0, 1],
      [1, 0, 1, 0, 1],
      [1, 1, 1, 0, 1],
      [0, 0, 0, 1, 1],
    ]),
    content="2",
  )
}
