///| 令x -> n为恒等映射即可
fn solution(
  injection~ : Array[Int],
  surjection~ : Array[Int]
) -> (Array[Int], Array[Int]) {
  let s2 = Array::makei(surjection.length(), fn { _ => 1 })
  let i2 = []
  let mut last = 0
  for i in 1..=injection.length() {
    let x = apply_inj(injection, i)
    let j = apply_sur(surjection, x)
    if j == last {
      i2[i2.length() - 1] += 1
    } else {
      for _ in (last + 1)..<j {
        i2.push(0)
      }
      i2.push(1)
      last = j
    }
  }
  (i2, s2)
}

///|
fn apply_inj(f : Array[Int], x : Int) -> Int {
  loop f[:], x, 0 {
    [], x, sum => {
      guard x == 0
      sum
    }
    _, 0, sum => sum
    [skipped, .. f], x, sum => continue f, x - 1, sum + skipped
  }
}

///|
fn apply_sur(f : Array[Int], x : Int) -> Int {
  loop f[:], 0, 0 {
    [], _, value => value
    [count, .. f], index_in_domain, value =>
      if index_in_domain >= x {
        value
      } else {
        continue f, index_in_domain + count, value + 1
      }
  }
}

///|
fn verify_solution(i1 : Array[Int], s1 : Array[Int]) -> Unit! {
  let (s2, i2) = solution(injection=i1, surjection=s1)
  let n = i1.length()
  for x in 1..=n {
    assert_eq!(apply_sur(s1, apply_inj(i1, x)), apply_inj(i2, apply_sur(s2, x)))
  }
}

///|
test {
  verify_solution!([1, 1, 1], [2, 1])
}

///|
test {
  verify_solution!([1, 2, 1], [2, 2])
}

///|
test {
  verify_solution!([1, 3, 1], [1, 2, 2])
}
