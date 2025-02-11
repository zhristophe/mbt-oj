///|
fn solution(array : Array[Int]) -> Int {
  let n = array.length()
  let mut res = 0
  let tree = SegTree::new(array)
  for k in 1..=n {
    for i in 0..<(n - k + 1) {
      let j = i + k - 1
      res = @math.maximum(res, tree.query(i, j) * k)
    }
  }
  res
}

///| C风格线段树
struct SegTree {
  tree : Array[Int]
  size : Int
}

///|
fn SegTree::new(arr : Array[Int]) -> SegTree {
  let size = arr.length()
  let tree = Array::new(capacity=arr.length() * 4)
  for _ in 0..<(size * 4) {
    tree.push(@int.max_value)
  }
  fn build(tree : Array[Int], node : Int, l : Int, r : Int, arr : Array[Int]) {
    if l == r {
      tree[node] = arr[l]
      return
    }
    let mid = (l + r) / 2
    let ln = node * 2 + 1
    let rn = node * 2 + 2
    build(tree, ln, l, mid, arr)
    build(tree, rn, mid + 1, r, arr)
    tree[node] = @math.minimum(tree[ln], tree[rn])
  }

  build(tree, 0, 0, size - 1, arr)
  { tree, size }
}

///|
fn SegTree::query(self : SegTree, l : Int, r : Int) -> Int {
  fn _query(
    tree : Array[Int],
    node : Int,
    start : Int,
    end : Int,
    l : Int,
    r : Int
  ) -> Int {
    if start > r || end < l {
      return @int.max_value
    }
    if l <= start && end <= r {
      return tree[node]
    }
    let mid = (start + end) / 2
    let ln = node * 2 + 1
    let rn = node * 2 + 2
    let left = _query(tree, ln, start, mid, l, r)
    let right = _query(tree, rn, mid + 1, end, l, r)
    @math.minimum(left, right)
  }

  _query(self.tree, 0, 0, self.size - 1, l, r)
}

test {
  inspect!(solution([1, 2, 3, 4, 5]), content="9")
  inspect!(solution([5, 4, 3, 2, 1, 6]), content="9")
  inspect!(solution([4, 4, 4, 4]), content="16")
}
