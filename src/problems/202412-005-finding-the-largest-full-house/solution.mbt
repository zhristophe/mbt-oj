///| 1最大
fn solution(max : Int, cards : Array[Int]) -> (Int, Int) {
  let cards = {
    let tmp = Array::make(14, 0)
    for card in cards {
      tmp[card] += 1
    }
    tmp
  }
  for a in 1..=13 {
    let a = if a == 1 { 1 } else { 15 - a }
    if 3 * a > max || cards[a] < 3 {
      continue
    }
    cards[a] -= 3
    for b in 1..=13 {
      let b = if b == 1 { 1 } else { 15 - b }
      if b == a {
        continue
      }
      if 3 * a + 2 * b > max || cards[b] < 2 {
        continue
      }
      return (a, b)
    }
    cards[a] += 3
  }
  (0, 0)
}

///|
test {
  inspect!(solution(34, [6, 6, 6, 8, 8, 8, 5, 5, 1]), content="(8, 5)")
  inspect!(solution(37, [9, 9, 9, 9, 6, 6, 6, 6, 13]), content="(6, 9)")
  inspect!(solution(40, [1, 11, 13, 12, 7, 8, 11, 5, 6]), content="(0, 0)")
}
