///|
fn solution(grid : Array[Array[Int]]) -> Int {
  let row_cnt = grid.length()
  let col_cnt = grid[0].length()
  let visited = grid.map(fn { line => line.map(fn { _ => false }) })
  let mut res = 0
  for i in 0..<row_cnt {
    for j in 0..<col_cnt {
      if visited[i][j] {
        continue
      }
      if grid[i][j] == 0 {
        continue
      }
      res += 1
      let q = @queue.new()
      q.push((i, j))
      while q.is_empty() == false {
        let (i, j) = q.pop().unwrap()
        visited[i][j] = true
        for pt in [(i - 1, j), (i + 1, j), (i, j - 1), (i, j + 1)] {
          let (i, j) = pt
          if i < 0 || i >= row_cnt || j < 0 || j >= col_cnt {
            continue
          }
          if visited[i][j] || grid[i][j] == 0 {
            continue
          }
          q.push(pt)
        }
      }
    }
  }
  res
}

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
