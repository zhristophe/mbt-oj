///|
fn solution(x : Int, y : Int) -> Int {
  fn solve(x : Int) {
    let mut res = 0
    loop 1 {
      base => {
        if x >= base * 9 {
          res += 9
        } else if x < base {
          break res
        } else {
          res += x / base
        }
        continue base * 10 + 1
      }
    }
  }

  solve(y) - solve(x - 1)
}

test {
  inspect!(solution(1, 10), content="9")
  inspect!(solution(2, 22), content="10")
}
