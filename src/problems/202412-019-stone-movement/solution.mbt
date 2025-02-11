///| 贪心，距离和最大化
fn solution(stones : Array[Int]) -> Int {
  stones.sort()
  let n = stones.length()
  loop 0 {
    time => {
      if stones[n - 1] - stones[0] == n - 1 {
        return time
      }
      let d1 = stones[1] - stones[0]
      let d2 = stones[n - 1] - stones[n - 2]
      if d1 < d2 {
        stones.remove(0) |> ignore
        loop stones.length() - 1 {
          idx => {
            if stones[idx] - stones[idx - 1] > 1 {
              stones.insert(idx, stones[idx] - 1)
              break
            }
            continue idx - 1
          }
        }
      } else {
        stones.remove(stones.length() - 1) |> ignore
        loop 0 {
          idx => {
            if stones[idx + 1] - stones[idx] > 1 {
              stones.insert(idx + 1, stones[idx] + 1)
              break
            }
            continue idx + 1
          }
        }
      }
      continue time + 1
    }
  }
}

test {
  inspect!(solution([3, 4, 5, 10]), content="4")
  inspect!(solution([7, 4, 9]), content="2")
  inspect!(solution([6, 5, 4, 3, 10]), content="3")
  inspect!(solution([1, 2, 3, 4, 5]), content="0")
}
