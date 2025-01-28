actor Boss
  let env: Env
  let workers: U32
  var completed: U32 = 0

  new create(env': Env, workers': U32) =>
    env = env'
    workers = workers'

  be result(start: U32, sum_of_squares: U32) =>
    env.out.print("Starting number: " + start.string() + ", Sum of squares: " + sum_of_squares.string() + " (Perfect square)")

  be no_sequence() =>
    env.out.print("No sequence for this worker")

  be done() =>
    completed = completed + 1
    if completed == workers then
      env.out.print("All workers finished.")
    end

actor Worker
  let boss: Boss
  new create(b: Boss) =>
    boss = b

  be sequence_finder(start: U32, endx: U32, k: U32) =>
    var current: U32 = start
    while current <= endx do
      var sum_of_squares: U32 = 0
      var i: U32 = 0
      while i < k do
        sum_of_squares = sum_of_squares + ((current + i) * (current + i))
        i = i + 1
      end
      if is_perfect_square(sum_of_squares) then
        boss.result(current, sum_of_squares)
      end
      current = current + 1
    end
    boss.done()

  fun is_perfect_square(n: U32): Bool =>
    let sqrt_of_n: U32 = square_root(n)
    (sqrt_of_n * sqrt_of_n) == n

  fun square_root(n: U32): U32 =>
    var lower_number: U32 = 0
    var higher_number: U32 = n
    var mid: U32 = 0
    while lower_number <= higher_number do
      mid = (lower_number + higher_number) / 2
      let square = mid * mid
      if square == n then
        return mid
      else
        if square < n then
          lower_number = mid + 1
        else
          higher_number = mid - 1
        end
      end
    end
    higher_number

actor Main
  new create(env: Env) =>
    let n_limit: U32 = 100000000
    let k: U32 = 2
    let worker_count: U32 = 8
    let chunk_size: U32 = n_limit / worker_count
    let boss = Boss(env, worker_count)
    
    var i: U32 = 0
    while i < worker_count do
      let start = i * (chunk_size + 1)
      let endx = if i == (worker_count - 1) then n_limit else (i + 1) * chunk_size end
      let worker = Worker(boss)
      worker.sequence_finder(start, endx, k)
      i = i + 1
    end