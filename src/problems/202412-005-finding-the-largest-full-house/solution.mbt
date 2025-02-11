///|
fn solution(max : Int, cards : Array[Int]) -> (Int, Int) {
  let table = @hashmap.new()
  for card in cards {
    let tmp = table.get(card).or(0) + 1
    table.set(card, tmp)
  }
  let card_and_count = table.to_array()
  card_and_count.sort_by(fn { a, b => b.0 - a.0 })
  for a in 0..<card_and_count.length() {
    if card_and_count[a].1 < 3 {
      continue
    }
    let a = card_and_count[a].0
    for b in 0..<card_and_count.length() {
      if a == b {
        continue
      }
      if card_and_count[b].1 < 2 {
        continue
      }
      let b = card_and_count[b].0
      let sum = a * 3 + b * 2
      if sum > max {
        continue
      }
      return (a, b)
    }
  }
  (0, 0)
}

test {
  inspect!(solution(34, [6, 6, 6, 8, 8, 8, 5, 5, 1]), content="(8, 5)")
  inspect!(solution(37, [9, 9, 9, 9, 6, 6, 6, 6, 13]), content="(6, 9)")
  inspect!(solution(40, [1, 11, 13, 12, 7, 8, 11, 5, 6]), content="(0, 0)")
}
