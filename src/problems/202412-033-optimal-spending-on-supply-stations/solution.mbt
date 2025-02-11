///| 贪心
fn solution(m : Int, p : Array[(Int, Int)]) -> Int {
  loop 0, 0 {
    prev, res => {
      if prev == p.length() {
        break res
      }
      let next = loop prev + 1 {
        next => {
          if next >= p.length() {
            break next
          }
          if p[next].1 < p[prev].1 {
            break next
          }
          continue next + 1
        }
      }
      let next_day = if next >= p.length() { m } else { p[next].0 }
      continue next, res + p[prev].1 * (next_day - p[prev].0)
    }
  }
}

test {
  inspect!(solution(5, [(0, 2), (1, 3), (2, 1), (3, 2)]), content="7")
  inspect!(solution(6, [(0, 1), (1, 5), (2, 2), (3, 4), (5, 1)]), content="6")
  inspect!(solution(4, [(0, 3), (2, 2), (3, 1)]), content="9")
}
