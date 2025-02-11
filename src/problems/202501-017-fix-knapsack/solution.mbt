///|
fn _knapsack(
  max_w : Int,
  n : Int,
  weight~ : Array[Int],
  value~ : Array[Int]
) -> Int {
  // dp[0][_] == 0
  // dp[_][0] == 0
  let dp = Array::make(n + 1, Array::make(max_w + 1, 0))
  for i = 1; i <= n; i = i + 1 {
    for w = 1; w <= max_w; w = w + 1 {
      if w - weight[i - 1] < 0 {
        dp[i][w] = dp[i - 1][w]
      } else {
        dp[i][w] = @math.maximum(
          dp[i - 1][w - weight[i - 1]] + value[i - 1],
          dp[i - 1][w],
        )
      }
    }
  }
  return dp[n][max_w]
}

///|
fn solution(max_w : Int, weight : Array[Int], value : Array[Int]) -> Int {
  let n = weight.length()
  let dp = Array::makei(n + 1, fn { _ => Array::make(max_w + 1, 0) })
  for i in 1..=n {
    for w in 1..=max_w {
      if w - weight[i - 1] < 0 {
        dp[i][w] = dp[i - 1][w]
      } else {
        dp[i][w] = @math.maximum(
          dp[i - 1][w - weight[i - 1]] + value[i - 1],
          dp[i - 1][w],
        )
      }
    }
  }
  return dp[n][max_w]
}

test {
  inspect!(solution(4, [2, 1, 3], [4, 2, 3]), content="6")
  inspect!(solution(5, [2, 1, 3], [4, 2, 3]), content="7")
}
